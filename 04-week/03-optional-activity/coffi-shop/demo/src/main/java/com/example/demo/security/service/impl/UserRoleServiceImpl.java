package com.example.demo.security.service.impl;

import com.example.demo.security.dtos.UserRoleRequestDto;
import com.example.demo.security.dtos.UserRoleResponseDto;
import com.example.demo.security.entity.Role;
import com.example.demo.security.entity.User;
import com.example.demo.security.entity.UserRole;
import com.example.demo.security.Repository.RoleRepository;
import com.example.demo.security.Repository.UserRepository;
import com.example.demo.security.Repository.UserRoleRepository;
import com.example.demo.security.service.UserRoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserRoleServiceImpl implements UserRoleService {
    private final UserRoleRepository userRoleRepository;
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    @Override
    public UserRoleResponseDto save(UserRoleRequestDto request) {
        if (userRoleRepository.existsByUserIdAndRoleId(request.getUserId(), request.getRoleId()))
            throw new RuntimeException("El usuario ya tiene asignado ese rol");
        User user = findUserById(request.getUserId());
        Role role = findRoleById(request.getRoleId());
        UserRole entity = UserRole.builder().user(user).role(role).status(true).build();
        return toResponse(userRoleRepository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        UserRole entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        userRoleRepository.save(entity);
    }

    @Override
    public List<UserRoleResponseDto> findByUserId(UUID userId) {
        return userRoleRepository.findByUserId(userId)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<UserRoleResponseDto> findByRoleId(UUID roleId) {
        return userRoleRepository.findByRoleId(roleId)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<UserRoleResponseDto> findAllActive() {
        return userRoleRepository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<UserRoleResponseDto> findAll() {
        return userRoleRepository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private UserRole findEntityById(UUID id) {
        return userRoleRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("UserRole no encontrado con ID: " + id));
    }

    private User findUserById(UUID id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado con ID: " + id));
    }

    private Role findRoleById(UUID id) {
        return roleRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Rol no encontrado con ID: " + id));
    }

    private UserRoleResponseDto toResponse(UserRole entity) {
        return UserRoleResponseDto.builder()
                .id(entity.getId()).userId(entity.getUser().getId())
                .username(entity.getUser().getUsername())
                .roleId(entity.getRole().getId()).roleName(entity.getRole().getName())
                .status(entity.getStatus()).build();
    }
}
