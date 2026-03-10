package com.example.demo.security.service.impl;

import com.example.demo.security.dtos.RoleRequestDto;
import com.example.demo.security.dtos.RoleResponseDto;
import com.example.demo.security.entity.Role;
import com.example.demo.security.Repository.RoleRepository;
import com.example.demo.security.service.RoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RoleServiceImpl implements RoleService {
    private final RoleRepository repository;

    @Override
    public RoleResponseDto save(RoleRequestDto request) {
        if (repository.existsByName(request.getName()))
            throw new RuntimeException("Ya existe un rol con el nombre: " + request.getName());
        Role entity = Role.builder()
                .name(request.getName()).description(request.getDescription())
                .status(true).build();
        return toResponse(repository.save(entity));
    }

    @Override
    public RoleResponseDto update(UUID id, RoleRequestDto request) {
        Role entity = findEntityById(id);
        entity.setName(request.getName());
        entity.setDescription(request.getDescription());
        return toResponse(repository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        Role entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        repository.save(entity);
    }

    @Override
    public RoleResponseDto findById(UUID id) { return toResponse(findEntityById(id)); }

    @Override
    public List<RoleResponseDto> findByName(String name) {
        return repository.findByNameContainingIgnoreCase(name)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<RoleResponseDto> findAllActive() {
        return repository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<RoleResponseDto> findAll() {
        return repository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private Role findEntityById(UUID id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Rol no encontrado con ID: " + id));
    }

    private RoleResponseDto toResponse(Role entity) {
        return RoleResponseDto.builder()
                .id(entity.getId()).name(entity.getName())
                .description(entity.getDescription()).status(entity.getStatus()).build();
    }
}
