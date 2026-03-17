package com.mediaedit.repository;

import com.mediaedit.entity.EditProject;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface EditProjectRepository extends JpaRepository<EditProject, Long> {
    
    Page<EditProject> findByUserIdOrderByUpdatedAtDesc(Long userId, Pageable pageable);
    
    List<EditProject> findByUserIdAndProjectType(Long userId, String projectType);
    
    List<EditProject> findByUserIdAndIsCompletedTrue(Long userId);
}
