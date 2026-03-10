package com.sena.test.repository.security;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.sena.test.entity.security.Person;

@Repository
public interface IPersonRepository extends JpaRepository<Person, Integer> {

    @Query("SELECT p FROM Person p WHERE p.id = ?1")
    Person findByIdCustom(Integer id);

    @Query("SELECT p FROM Person p WHERE p.edad = ?1")
    List<Person> filterByAge(int edad);

    @Query("SELECT p FROM Person p WHERE p.name LIKE %?1%")
    List<Person> filterByName(String name);
}
