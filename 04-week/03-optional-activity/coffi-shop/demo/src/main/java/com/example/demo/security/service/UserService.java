package com.example.demo.security.service;

import com.example.demo.security.dtos.UserRequestDto;
import com.example.demo.security.dtos.UserResponseDto;
import java.util.List;
import java.util.UUID;

public interface UserService {
    UserResponseDto save(UserRequestDto request);
    UserResponseDto update(UUID id, UserRequestDto request);
    void delete(UUID id);
    UserResponseDto findById(UUID id);
    UserResponseDto findByUsername(String username);
    List<UserResponseDto> findByName(String name);
    List<UserResponseDto> findAllActive();
    List<UserResponseDto> findAll();
}
