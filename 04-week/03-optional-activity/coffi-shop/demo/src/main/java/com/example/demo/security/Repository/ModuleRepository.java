package com.example.demo.security.Repository;

import com.example.demo.security.entity.Module;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ModuleRepository extends JpaRepository<Module, UUID> {
    Optional<Module> findByName(String name);
    List<Module> findByNameContainingIgnoreCase(String name);
    List<Module> findByStatusTrue();
    boolean existsByName(String name);
}
