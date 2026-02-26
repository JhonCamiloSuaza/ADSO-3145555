package com.sena.test.service.security;

import java.util.List;
import com.sena.test.entity.security.Role;

public interface IRoleService {

    List<Role> findAll();

    Role findById(Integer id);

    List<Role> findByName(String name);

    Role save(Role role);

    Role update(Integer id, Role role);

    void delete(Integer id);
}
