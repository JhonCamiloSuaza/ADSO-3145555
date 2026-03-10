package com.sena.test.controller.security;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.sena.test.dto.security.RoleDTO;
import com.sena.test.entity.security.Role;
import com.sena.test.service.security.IRoleService;

@RestController
@RequestMapping("/api/roles")
@CrossOrigin("*")
public class RoleController {

    @Autowired
    private IRoleService roleService;

    // ✅ Entity → DTO
    private RoleDTO toDTO(Role role) {
        return new RoleDTO(role.getId(), role.getRole());
    }

    // ✅ DTO → Entity
    private Role toEntity(RoleDTO dto) {
        Role r = new Role();
        r.setId(dto.getId());
        r.setRole(dto.getRole());
        return r;
    }

    // ✅ Obtener todos
    @GetMapping
    public ResponseEntity<List<RoleDTO>> getAll() {
        List<Role> list = roleService.findAll();
        List<RoleDTO> dtos = list.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    // ✅ Obtener por ID (con validación)
    @GetMapping("/{id}")
    public ResponseEntity<RoleDTO> getById(@PathVariable Integer id) {
        Role r = roleService.findById(id);

        if (r == null) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(toDTO(r));
    }

    // ✅ Buscar por nombre
    @GetMapping("/name/{name}")
    public ResponseEntity<List<RoleDTO>> getByName(@PathVariable String name) {
        List<Role> list = roleService.findByName(name);
        List<RoleDTO> dtos = list.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    // ✅ Crear
    @PostMapping
    public ResponseEntity<RoleDTO> save(@RequestBody RoleDTO dto) {
        Role r = toEntity(dto);
        Role saved = roleService.save(r);
        return ResponseEntity.status(HttpStatus.CREATED).body(toDTO(saved));
    }

    // ✅ Actualizar (con validación)
    @PutMapping("/{id}")
    public ResponseEntity<RoleDTO> update(@PathVariable Integer id, @RequestBody RoleDTO dto) {
        Role r = toEntity(dto);
        Role updated = roleService.update(id, r);

        if (updated == null) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(toDTO(updated));
    }

    // ✅ Eliminar (mejor con validación)
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        boolean deleted = roleService.delete(id);

        if (!deleted) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.noContent().build();
    }
}