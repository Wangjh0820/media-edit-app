package com.mediaedit.service;

import com.mediaedit.entity.MediaFile;
import com.mediaedit.entity.User;
import com.mediaedit.repository.MediaFileRepository;
import com.mediaedit.repository.UserRepository;
import io.minio.*;
import io.minio.messages.Item;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class FileService {
    
    private final MinioClient minioClient;
    private final MediaFileRepository mediaFileRepository;
    private final UserRepository userRepository;
    
    @Value("${minio.bucket-name}")
    private String bucketName;
    
    @Transactional
    public MediaFile uploadFile(Long userId, MultipartFile file, String fileType) {
        try {
            String originalName = file.getOriginalFilename();
            String extension = originalName.substring(originalName.lastIndexOf("."));
            String fileName = generateFileName(extension);
            String objectName = userId + "/" + fileName;
            
            ensureBucketExists();
            
            minioClient.putObject(
                    PutObjectArgs.builder()
                            .bucket(bucketName)
                            .object(objectName)
                            .stream(file.getInputStream(), file.getSize(), -1)
                            .contentType(file.getContentType())
                            .build()
            );
            
            MediaFile mediaFile = MediaFile.builder()
                    .userId(userId)
                    .fileName(fileName)
                    .originalName(originalName)
                    .filePath(objectName)
                    .fileType(fileType)
                    .fileSize(file.getSize())
                    .build();
            
            mediaFile = mediaFileRepository.save(mediaFile);
            
            updateUserStorage(userId, file.getSize());
            
            return mediaFile;
        } catch (Exception e) {
            log.error("文件上传失败", e);
            throw new RuntimeException("文件上传失败: " + e.getMessage());
        }
    }
    
    public InputStream getFileStream(Long userId, Long fileId) {
        try {
            MediaFile mediaFile = mediaFileRepository.findById(fileId)
                    .orElseThrow(() -> new RuntimeException("文件不存在"));
            
            if (!mediaFile.getUserId().equals(userId)) {
                throw new RuntimeException("无权访问此文件");
            }
            
            return minioClient.getObject(
                    GetObjectArgs.builder()
                            .bucket(bucketName)
                            .object(mediaFile.getFilePath())
                            .build()
            );
        } catch (Exception e) {
            log.error("获取文件失败", e);
            throw new RuntimeException("获取文件失败: " + e.getMessage());
        }
    }
    
    public Page<MediaFile> getUserFiles(Long userId, Pageable pageable) {
        return mediaFileRepository.findByUserIdAndIsDeletedFalseOrderByCreatedAtDesc(userId, pageable);
    }
    
    public List<MediaFile> getUserFilesByType(Long userId, String fileType) {
        return mediaFileRepository.findByUserIdAndFileTypeAndIsDeletedFalse(userId, fileType);
    }
    
    @Transactional
    public void deleteFile(Long userId, Long fileId) {
        MediaFile mediaFile = mediaFileRepository.findById(fileId)
                .orElseThrow(() -> new RuntimeException("文件不存在"));
        
        if (!mediaFile.getUserId().equals(userId)) {
            throw new RuntimeException("无权删除此文件");
        }
        
        mediaFile.setIsDeleted(true);
        mediaFileRepository.save(mediaFile);
    }
    
    private String generateFileName(String extension) {
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"))
                + "/" + UUID.randomUUID().toString() + extension;
    }
    
    private void ensureBucketExists() throws Exception {
        boolean exists = minioClient.bucketExists(
                BucketExistsArgs.builder().bucket(bucketName).build()
        );
        if (!exists) {
            minioClient.makeBucket(
                    MakeBucketArgs.builder().bucket(bucketName).build()
            );
        }
    }
    
    private void updateUserStorage(Long userId, Long fileSize) {
        User user = userRepository.findById(userId).orElseThrow();
        user.setStorageUsed(user.getStorageUsed() + fileSize.intValue());
        userRepository.save(user);
    }
}
