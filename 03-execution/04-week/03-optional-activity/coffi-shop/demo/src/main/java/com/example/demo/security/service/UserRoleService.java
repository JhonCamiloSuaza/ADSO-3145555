package com.example.demo.security.service;

import com.example.demo.security.dtos.UserRoleRequestDto;
import com.example.demo.security.dtos.UserRoleResponseDto;
import java.util.List;
import java.util.UUID;

public interface UserRoleService {
    UserRoleResponseDto save(UserRoleRequestDto request);
    void delete(UUID id);
    List<UserRoleResponseDto> findByUserId(UUID userId);
    List<UserRoleResponseDto> findByRoleId(UUID roleId);
    List<UserRoleResponseDto> findAllActive();
    List<UserRoleResponseDto> findAll();
}
