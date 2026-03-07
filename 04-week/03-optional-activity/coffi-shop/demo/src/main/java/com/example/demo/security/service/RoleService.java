package com.example.demo.security.service;

import com.example.demo.security.dtos.RoleRequestDto;
import com.example.demo.security.dtos.RoleResponseDto;
import java.util.List;
import java.util.UUID;

public interface RoleService {
    RoleResponseDto save(RoleRequestDto request);
    RoleResponseDto update(UUID id, RoleRequestDto request);
    void delete(UUID id);
    RoleResponseDto findById(UUID id);
    List<RoleResponseDto> findByName(String name);
    List<RoleResponseDto> findAllActive();
    List<RoleResponseDto> findAll();
}
