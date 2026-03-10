package com.example.demo.security.Repository;

import com.example.demo.security.entity.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface RoleRepository extends JpaRepository<Role, UUID> {
    Optional<Role> findByName(String name);
    List<Role> findByNameContainingIgnoreCase(String name);
    List<Role> findByStatusTrue();
    boolean existsByName(String name);
}
