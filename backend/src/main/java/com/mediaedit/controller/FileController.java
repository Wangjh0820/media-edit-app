package com.mediaedit.controller;

import com.mediaedit.dto.ApiResponse;
import com.mediaedit.entity.MediaFile;
import com.mediaedit.service.FileService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.InputStream;
import java.util.List;

@RestController
@RequestMapping("/api/files")
@RequiredArgsConstructor
@Tag(name = "文件管理", description = "文件上传下载相关接口")
public class FileController {
    
    private final FileService fileService;
    
    @PostMapping(value = "/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @Operation(summary = "上传文件")
    public ResponseEntity<ApiResponse<MediaFile>> uploadFile(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam("file") MultipartFile file,
            @RequestParam(value = "type", defaultValue = "image") String type) {
        
        Long userId = getUserId(userDetails);
        MediaFile mediaFile = fileService.uploadFile(userId, file, type);
        return ResponseEntity.ok(ApiResponse.success("上传成功", mediaFile));
    }
    
    @GetMapping("/download/{fileId}")
    @Operation(summary = "下载文件")
    public void downloadFile(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable Long fileId,
            HttpServletResponse response) {
        
        Long userId = getUserId(userDetails);
        try {
            MediaFile mediaFile = fileService.getUserFiles(userId, PageRequest.of(0, 1))
                    .getContent().stream()
                    .filter(f -> f.getId().equals(fileId))
                    .findFirst()
                    .orElseThrow(() -> new RuntimeException("文件不存在"));
            
            InputStream inputStream = fileService.getFileStream(userId, fileId);
            
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=" + mediaFile.getOriginalName());
            
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                response.getOutputStream().write(buffer, 0, bytesRead);
            }
            inputStream.close();
        } catch (Exception e) {
            throw new RuntimeException("下载失败: " + e.getMessage());
        }
    }
    
    @GetMapping("/list")
    @Operation(summary = "获取文件列表")
    public ResponseEntity<ApiResponse<Page<MediaFile>>> getFileList(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        
        Long userId = getUserId(userDetails);
        Page<MediaFile> files = fileService.getUserFiles(userId, 
                PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "createdAt")));
        return ResponseEntity.ok(ApiResponse.success(files));
    }
    
    @GetMapping("/list/{type}")
    @Operation(summary = "按类型获取文件列表")
    public ResponseEntity<ApiResponse<List<MediaFile>>> getFilesByType(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable String type) {
        
        Long userId = getUserId(userDetails);
        List<MediaFile> files = fileService.getUserFilesByType(userId, type);
        return ResponseEntity.ok(ApiResponse.success(files));
    }
    
    @DeleteMapping("/{fileId}")
    @Operation(summary = "删除文件")
    public ResponseEntity<ApiResponse<Void>> deleteFile(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable Long fileId) {
        
        Long userId = getUserId(userDetails);
        fileService.deleteFile(userId, fileId);
        return ResponseEntity.ok(ApiResponse.success("删除成功", null));
    }
    
    private Long getUserId(UserDetails userDetails) {
        return 1L;
    }
}
