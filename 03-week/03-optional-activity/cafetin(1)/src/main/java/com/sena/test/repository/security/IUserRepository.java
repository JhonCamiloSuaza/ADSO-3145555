package com.sena.test.repository.security;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.sena.test.entity.security.User;

@Repository
public interface IUserRepository extends JpaRepository<User, Integer> {

    @Query("SELECT u FROM User u WHERE u.id = ?1")
    User findByIdCustom(Integer id);

    @Query("SELECT u FROM User u WHERE u.userName = ?1")
    List<User> filterByUsername(String userName);

    @Query("SELECT u FROM User u WHERE u.email = ?1")
    User filterByEmail(String email);

    // Filtros por Person (relación)
    @Query("SELECT u FROM User u WHERE u.person.name LIKE %?1%")
    List<User> filterByPersonName(String name);

    @Query("SELECT u FROM User u WHERE u.person.edad = ?1")
    List<User> filterByPersonEdad(Integer edad);

    public boolean existsByEmail(String email);
}
