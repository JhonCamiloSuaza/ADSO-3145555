package com.example.demo.security.service;

import com.example.demo.security.dtos.RoleModuleRequestDto;
import com.example.demo.security.dtos.RoleModuleResponseDto;
import java.util.List;
import java.util.UUID;

public interface RoleModuleService {
    RoleModuleResponseDto save(RoleModuleRequestDto request);
    RoleModuleResponseDto update(UUID id, RoleModuleRequestDto request);
    void delete(UUID id);
    List<RoleModuleResponseDto> findByRoleId(UUID roleId);
    List<RoleModuleResponseDto> findByModuleId(UUID moduleId);
    List<RoleModuleResponseDto> findAllActive();
    List<RoleModuleResponseDto> findAll();
}
