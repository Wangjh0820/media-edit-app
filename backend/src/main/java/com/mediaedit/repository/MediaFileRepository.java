package com.mediaedit.repository;

import com.mediaedit.entity.MediaFile;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface MediaFileRepository extends JpaRepository<MediaFile, Long> {
    
    Page<MediaFile> findByUserIdAndIsDeletedFalseOrderByCreatedAtDesc(Long userId, Pageable pageable);
    
    List<MediaFile> findByUserIdAndFileTypeAndIsDeletedFalse(Long userId, String fileType);
    
    @Query("SELECT SUM(m.fileSize) FROM MediaFile m WHERE m.userId = :userId AND m.isDeleted = false")
    Long getTotalStorageUsed(@Param("userId") Long userId);
    
    @Modifying
    @Query("UPDATE MediaFile m SET m.isDeleted = true WHERE m.userId = :userId AND m.id = :id")
    void softDeleteByUserIdAndId(@Param("userId") Long userId, @Param("id") Long id);
}
