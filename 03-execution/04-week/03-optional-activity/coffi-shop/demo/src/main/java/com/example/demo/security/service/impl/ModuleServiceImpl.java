package com.example.demo.security.service.impl;

import com.example.demo.security.dtos.ModuleRequestDto;
import com.example.demo.security.dtos.ModuleResponseDto;
import com.example.demo.security.entity.Module;
import com.example.demo.security.Repository.ModuleRepository;
import com.example.demo.security.service.ModuleService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ModuleServiceImpl implements ModuleService {
    private final ModuleRepository repository;

    @Override
    public ModuleResponseDto save(ModuleRequestDto request) {
        if (repository.existsByName(request.getName()))
            throw new RuntimeException("Ya existe un módulo con el nombre: " + request.getName());
        Module entity = Module.builder()
                .name(request.getName()).description(request.getDescription())
                .icon(request.getIcon()).route(request.getRoute())
                .sortOrder(request.getSortOrder() != null ? request.getSortOrder() : 0)
                .status(true).build();
        return toResponse(repository.save(entity));
    }

    @Override
    public ModuleResponseDto update(UUID id, ModuleRequestDto request) {
        Module entity = findEntityById(id);
        entity.setName(request.getName());
        entity.setDescription(request.getDescription());
        entity.setIcon(request.getIcon());
        entity.setRoute(request.getRoute());
        entity.setSortOrder(request.getSortOrder() != null ? request.getSortOrder() : entity.getSortOrder());
        return toResponse(repository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        Module entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        repository.save(entity);
    }

    @Override
    public ModuleResponseDto findById(UUID id) { return toResponse(findEntityById(id)); }

    @Override
    public List<ModuleResponseDto> findByName(String name) {
        return repository.findByNameContainingIgnoreCase(name)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<ModuleResponseDto> findAllActive() {
        return repository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<ModuleResponseDto> findAll() {
        return repository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private Module findEntityById(UUID id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Módulo no encontrado con ID: " + id));
    }

    private ModuleResponseDto toResponse(Module entity) {
        return ModuleResponseDto.builder()
                .id(entity.getId()).name(entity.getName()).description(entity.getDescription())
                .icon(entity.getIcon()).route(entity.getRoute())
                .sortOrder(entity.getSortOrder()).status(entity.getStatus()).build();
    }
}
