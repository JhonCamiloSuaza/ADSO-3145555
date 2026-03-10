package com.sena.test.service.security;

import java.util.List;

import com.sena.test.entity.security.Person;

public interface IPersonService {

    List<Person> findAll();

    Person findById(Integer id);

    List<Person> findByName(String name);

    List<Person> findByEdad(Integer edad);

    Person save(Person person);

    Person update(Integer id, Person person);

    boolean delete(Integer id);
}
