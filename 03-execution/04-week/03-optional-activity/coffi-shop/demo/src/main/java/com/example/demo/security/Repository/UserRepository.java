package com.example.demo.security.Repository;

import com.example.demo.security.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserRepository extends JpaRepository<User, UUID> {
    Optional<User> findByUsername(String username);
    boolean existsByUsername(String username);
    List<User> findByStatusTrue();
    @Query("SELECT u FROM User u WHERE " +
           "LOWER(u.person.firstName) LIKE LOWER(CONCAT('%', :name, '%')) OR " +
           "LOWER(u.person.lastName)  LIKE LOWER(CONCAT('%', :name, '%'))")
    List<User> findByPersonName(@Param("name") String name);
}
