package com.mediaedit.repository;

import com.mediaedit.entity.MediaFile;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface MediaFileRepository extends JpaRepository<MediaFile, Long> {
    
    Page<MediaFile> findByUserIdAndIsDeletedFalseOrderByCreatedAtDesc(Long userId, Pageable pageable);
    
    List<MediaFile> findByUserIdAndFileTypeAndIsDeletedFalse(Long userId, String fileType);
    
    @Query("SELECT SUM(m.fileSize) FROM MediaFile m WHERE m.userId = ?1 AND m.isDeleted = false")
    Long getTotalStorageUsed(Long userId);
    
    void softDeleteByUserIdAndId(Long userId, Long id);
}
