package com.sena.test.service.security;

import java.util.List;

import com.sena.test.entity.security.User;

public interface IUserService {

    List<User> findAll();

    User findById(Integer id);

    List<User> findByName(String name);

    List<User> findByEdad(Integer edad);

    User save(User user);

    User update(Integer id, User user);

    boolean delete(Integer id);
}
