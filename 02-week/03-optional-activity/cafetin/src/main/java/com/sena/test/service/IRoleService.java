package com.sena.test.service;

import java.util.List;
import com.sena.test.dto.RoleDTO;

public interface IRoleService {

    List<RoleDTO> findAll();

    RoleDTO findById(Integer id);

    List<RoleDTO> findByName(String name);

    RoleDTO save(RoleDTO dto);

    RoleDTO update(Integer id, RoleDTO dto);

    void delete(Integer id);
}