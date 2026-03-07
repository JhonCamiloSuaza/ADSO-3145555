package com.example.demo.security.service.impl;

import com.example.demo.security.dtos.RoleModuleRequestDto;
import com.example.demo.security.dtos.RoleModuleResponseDto;
import com.example.demo.security.entity.Module;
import com.example.demo.security.entity.Role;
import com.example.demo.security.entity.RoleModule;
import com.example.demo.security.Repository.ModuleRepository;
import com.example.demo.security.Repository.RoleModuleRepository;
import com.example.demo.security.Repository.RoleRepository;
import com.example.demo.security.service.RoleModuleService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RoleModuleServiceImpl implements RoleModuleService {
    private final RoleModuleRepository roleModuleRepository;
    private final RoleRepository roleRepository;
    private final ModuleRepository moduleRepository;

    @Override
    public RoleModuleResponseDto save(RoleModuleRequestDto request) {
        if (roleModuleRepository.existsByRoleIdAndModuleId(request.getRoleId(), request.getModuleId()))
            throw new RuntimeException("El rol ya tiene asignado ese módulo");
        Role role = findRoleById(request.getRoleId());
        Module module = findModuleById(request.getModuleId());
        RoleModule entity = RoleModule.builder().role(role).module(module).status(true).build();
        return toResponse(roleModuleRepository.save(entity));
    }

    @Override
    public RoleModuleResponseDto update(UUID id, RoleModuleRequestDto request) {
        RoleModule entity = findEntityById(id);
        entity.setRole(findRoleById(request.getRoleId()));
        entity.setModule(findModuleById(request.getModuleId()));
        return toResponse(roleModuleRepository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        RoleModule entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        roleModuleRepository.save(entity);
    }

    @Override
    public List<RoleModuleResponseDto> findByRoleId(UUID roleId) {
        return roleModuleRepository.findByRoleId(roleId)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<RoleModuleResponseDto> findByModuleId(UUID moduleId) {
        return roleModuleRepository.findByModuleId(moduleId)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<RoleModuleResponseDto> findAllActive() {
        return roleModuleRepository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<RoleModuleResponseDto> findAll() {
        return roleModuleRepository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private RoleModule findEntityById(UUID id) {
        return roleModuleRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("RoleModule no encontrado con ID: " + id));
    }

    private Role findRoleById(UUID id) {
        return roleRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Rol no encontrado con ID: " + id));
    }

    private Module findModuleById(UUID id) {
        return moduleRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Módulo no encontrado con ID: " + id));
    }

    private RoleModuleResponseDto toResponse(RoleModule entity) {
        return RoleModuleResponseDto.builder()
                .id(entity.getId()).roleId(entity.getRole().getId()).roleName(entity.getRole().getName())
                .moduleId(entity.getModule().getId()).moduleName(entity.getModule().getName())
                .status(entity.getStatus()).build();
    }
}
