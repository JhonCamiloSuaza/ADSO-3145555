package com.sena.test.service.Impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sena.test.dto.RoleDTO;
import com.sena.test.entity.Role;
import com.sena.test.repository.IRoleRepository;
import com.sena.test.service.IRoleService;

@Service
public class RoleServiceimpl implements IRoleService {

    @Autowired
    private IRoleRepository roleRepository;

    
    private RoleDTO toDTO(Role role) {
        return new RoleDTO(
            role.getId(),
            role.getRole()
        );
    }

    
    private Role toEntity(RoleDTO dto) {
        Role role = new Role();
        role.setRole(dto.getRole());
        return role;
    }

    @Override
    public List<RoleDTO> findAll() {
        return roleRepository.findAll()
            .stream()
            .map(this::toDTO)
            .collect(Collectors.toList());
    }

    @Override
    public RoleDTO findById(Integer id) {
        Role role = roleRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Rol no encontrado con id: " + id));
        return toDTO(role);
    }

    @Override
    public List<RoleDTO> findByName(String name) {
        return roleRepository.filterByName(name)
            .stream()
            .map(this::toDTO)
            .collect(Collectors.toList());
    }

    @Override
    public RoleDTO save(RoleDTO dto) {
        Role role = toEntity(dto);
        return toDTO(roleRepository.save(role));
    }

    @Override
    public RoleDTO update(Integer id, RoleDTO dto) {
        Role role = roleRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Rol no encontrado con id: " + id));
        role.setRole(dto.getRole());
        return toDTO(roleRepository.save(role));
    }

    @Override
    public void delete(Integer id) {
        if (!roleRepository.existsById(id)) {
            throw new RuntimeException("Rol no encontrado con id: " + id);
        }
        roleRepository.deleteById(id);
    }
}