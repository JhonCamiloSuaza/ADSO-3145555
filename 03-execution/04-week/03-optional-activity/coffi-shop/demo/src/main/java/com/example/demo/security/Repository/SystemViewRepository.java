package com.example.demo.security.Repository;

import com.example.demo.security.entity.SystemView;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface SystemViewRepository extends JpaRepository<SystemView, UUID> {
    Optional<SystemView> findByName(String name);
    List<SystemView> findByNameContainingIgnoreCase(String name);
    List<SystemView> findByStatusTrue();
    boolean existsByName(String name);
}
