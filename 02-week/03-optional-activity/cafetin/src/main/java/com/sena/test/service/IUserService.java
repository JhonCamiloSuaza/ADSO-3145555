package com.sena.test.service;

import java.util.List;
import com.sena.test.dto.UserPasswordDTO;
import com.sena.test.dto.UserQueryDTO;

public interface IUserService {

    
    List<UserQueryDTO> findAll();

    UserQueryDTO findById(Integer id);

    List<UserQueryDTO> findByName(String name);

    List<UserQueryDTO> findByEdad(Integer edad);

    
    UserQueryDTO save(UserPasswordDTO dto);

    UserQueryDTO update(Integer id, UserPasswordDTO dto);

    void delete(Integer id);
}