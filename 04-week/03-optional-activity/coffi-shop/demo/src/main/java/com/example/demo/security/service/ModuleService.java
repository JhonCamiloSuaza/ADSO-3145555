package com.example.demo.security.service;

import com.example.demo.security.dtos.ModuleRequestDto;
import com.example.demo.security.dtos.ModuleResponseDto;
import java.util.List;
import java.util.UUID;

public interface ModuleService {
    ModuleResponseDto save(ModuleRequestDto request);
    ModuleResponseDto update(UUID id, ModuleRequestDto request);
    void delete(UUID id);
    ModuleResponseDto findById(UUID id);
    List<ModuleResponseDto> findByName(String name);
    List<ModuleResponseDto> findAllActive();
    List<ModuleResponseDto> findAll();
}
