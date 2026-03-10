package com.example.demo.security.service;

import com.example.demo.security.dtos.ModuleViewRequestDto;
import com.example.demo.security.dtos.ModuleViewResponseDto;
import java.util.List;
import java.util.UUID;

public interface ModuleViewService {
    ModuleViewResponseDto save(ModuleViewRequestDto request);
    void delete(UUID id);
    List<ModuleViewResponseDto> findByModuleId(UUID moduleId);
    List<ModuleViewResponseDto> findBySystemViewId(UUID systemViewId);
    List<ModuleViewResponseDto> findAllActive();
    List<ModuleViewResponseDto> findAll();
}
