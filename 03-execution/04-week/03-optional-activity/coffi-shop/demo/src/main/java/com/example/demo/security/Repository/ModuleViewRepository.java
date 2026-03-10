package com.example.demo.security.Repository;

import com.example.demo.security.entity.ModuleView;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.UUID;

@Repository
public interface ModuleViewRepository extends JpaRepository<ModuleView, UUID> {
    List<ModuleView> findByModuleId(UUID moduleId);
    List<ModuleView> findBySystemViewId(UUID systemViewId);
    List<ModuleView> findByStatusTrue();
    boolean existsByModuleIdAndSystemViewId(UUID moduleId, UUID systemViewId);
}
