package com.example.demo.security.Repository;

import com.example.demo.security.entity.RoleModule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.UUID;

@Repository
public interface RoleModuleRepository extends JpaRepository<RoleModule, UUID> {
    List<RoleModule> findByRoleId(UUID roleId);
    List<RoleModule> findByModuleId(UUID moduleId);
    List<RoleModule> findByStatusTrue();
    boolean existsByRoleIdAndModuleId(UUID roleId, UUID moduleId);
}
