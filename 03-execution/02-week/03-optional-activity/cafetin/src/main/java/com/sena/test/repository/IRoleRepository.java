package com.sena.test.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.sena.test.entity.Role;

@Repository
public interface IRoleRepository extends JpaRepository<Role, Integer> {

    @Query("SELECT r FROM Role r WHERE r.id = ?1")
    Role findByIdCustom(Integer id);

    @Query("SELECT r FROM Role r WHERE r.role = ?1")
    List<Role> filterByName(String name);

    @Query("SELECT r FROM Role r WHERE r.role LIKE %?1%")
    List<Role> filterByNameLike(String name);
}