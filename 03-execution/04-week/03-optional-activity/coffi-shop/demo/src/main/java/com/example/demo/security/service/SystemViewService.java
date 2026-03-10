package com.example.demo.security.service;

import com.example.demo.security.dtos.SystemViewRequestDto;
import com.example.demo.security.dtos.SystemViewResponseDto;
import java.util.List;
import java.util.UUID;

public interface SystemViewService {
    SystemViewResponseDto save(SystemViewRequestDto request);
    SystemViewResponseDto update(UUID id, SystemViewRequestDto request);
    void delete(UUID id);
    SystemViewResponseDto findById(UUID id);
    List<SystemViewResponseDto> findByName(String name);
    List<SystemViewResponseDto> findAllActive();
    List<SystemViewResponseDto> findAll();
}
