package com.example.demo.security.service.impl;

import com.example.demo.security.dtos.ModuleViewRequestDto;
import com.example.demo.security.dtos.ModuleViewResponseDto;
import com.example.demo.security.entity.Module;
import com.example.demo.security.entity.ModuleView;
import com.example.demo.security.entity.SystemView;
import com.example.demo.security.Repository.ModuleRepository;
import com.example.demo.security.Repository.ModuleViewRepository;
import com.example.demo.security.Repository.SystemViewRepository;
import com.example.demo.security.service.ModuleViewService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ModuleViewServiceImpl implements ModuleViewService {
    private final ModuleViewRepository moduleViewRepository;
    private final ModuleRepository moduleRepository;
    private final SystemViewRepository systemViewRepository;

    @Override
    public ModuleViewResponseDto save(ModuleViewRequestDto request) {
        if (moduleViewRepository.existsByModuleIdAndSystemViewId(request.getModuleId(), request.getSystemViewId()))
            throw new RuntimeException("La vista ya está asignada a ese módulo");
        Module module = findModuleById(request.getModuleId());
        SystemView systemView = findSystemViewById(request.getSystemViewId());
        ModuleView entity = ModuleView.builder().module(module).systemView(systemView).status(true).build();
        return toResponse(moduleViewRepository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        ModuleView entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        moduleViewRepository.save(entity);
    }

    @Override
    public List<ModuleViewResponseDto> findByModuleId(UUID moduleId) {
        return moduleViewRepository.findByModuleId(moduleId)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<ModuleViewResponseDto> findBySystemViewId(UUID systemViewId) {
        return moduleViewRepository.findBySystemViewId(systemViewId)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<ModuleViewResponseDto> findAllActive() {
        return moduleViewRepository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<ModuleViewResponseDto> findAll() {
        return moduleViewRepository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private ModuleView findEntityById(UUID id) {
        return moduleViewRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("ModuleView no encontrado con ID: " + id));
    }

    private Module findModuleById(UUID id) {
        return moduleRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Módulo no encontrado con ID: " + id));
    }

    private SystemView findSystemViewById(UUID id) {
        return systemViewRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Vista no encontrada con ID: " + id));
    }

    private ModuleViewResponseDto toResponse(ModuleView entity) {
        return ModuleViewResponseDto.builder()
                .id(entity.getId()).moduleId(entity.getModule().getId()).moduleName(entity.getModule().getName())
                .systemViewId(entity.getSystemView().getId()).systemViewName(entity.getSystemView().getName())
                .status(entity.getStatus()).build();
    }
}
