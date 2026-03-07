package com.example.demo.security.service.impl;

import com.example.demo.security.dtos.SystemViewRequestDto;
import com.example.demo.security.dtos.SystemViewResponseDto;
import com.example.demo.security.entity.SystemView;
import com.example.demo.security.Repository.SystemViewRepository;
import com.example.demo.security.service.SystemViewService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SystemViewServiceImpl implements SystemViewService {
    private final SystemViewRepository repository;

    @Override
    public SystemViewResponseDto save(SystemViewRequestDto request) {
        if (repository.existsByName(request.getName()))
            throw new RuntimeException("Ya existe una vista con el nombre: " + request.getName());
        SystemView entity = SystemView.builder()
                .name(request.getName()).route(request.getRoute())
                .description(request.getDescription()).status(true).build();
        return toResponse(repository.save(entity));
    }

    @Override
    public SystemViewResponseDto update(UUID id, SystemViewRequestDto request) {
        SystemView entity = findEntityById(id);
        entity.setName(request.getName());
        entity.setRoute(request.getRoute());
        entity.setDescription(request.getDescription());
        return toResponse(repository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        SystemView entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        repository.save(entity);
    }

    @Override
    public SystemViewResponseDto findById(UUID id) { return toResponse(findEntityById(id)); }

    @Override
    public List<SystemViewResponseDto> findByName(String name) {
        return repository.findByNameContainingIgnoreCase(name)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<SystemViewResponseDto> findAllActive() {
        return repository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<SystemViewResponseDto> findAll() {
        return repository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private SystemView findEntityById(UUID id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Vista no encontrada con ID: " + id));
    }

    private SystemViewResponseDto toResponse(SystemView entity) {
        return SystemViewResponseDto.builder()
                .id(entity.getId()).name(entity.getName())
                .route(entity.getRoute()).description(entity.getDescription())
                .status(entity.getStatus()).build();
    }
}
