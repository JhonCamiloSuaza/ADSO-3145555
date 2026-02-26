package com.sena.test.service.Impl.security;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sena.test.dto.security.RoleDTO;
import com.sena.test.entity.security.Role;
import com.sena.test.repository.security.IRoleRepository;
import com.sena.test.service.security.IRoleService;

@Service
public class RoleServiceImpl implements IRoleService {

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
    public List<Role> findAll() {
        return roleRepository.findAll();
    }

    @Override
    public Role findById(Integer id) {
        return roleRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Rol no encontrado con id: " + id));
    }

    @Override
    public List<Role> findByName(String name) {
        return roleRepository.filterByName(name);
    }

    @Override
    public Role save(Role role) {
        return roleRepository.save(role);
    }

    @Override
    public Role update(Integer id, Role role) {
        Role existing = roleRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Rol no encontrado con id: " + id));
        existing.setRole(role.getRole());
        return roleRepository.save(existing);
    }

    @Override
    public void delete(Integer id) {
        if (!roleRepository.existsById(id)) {
            throw new RuntimeException("Rol no encontrado con id: " + id);
        }
        roleRepository.deleteById(id);
    }
}