package com.sena.test.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.sena.test.dto.RoleDTO;
import com.sena.test.service.IRoleService;

@RestController
@RequestMapping("/api/roles")
@CrossOrigin("*")
public class RoleController {

    @Autowired
    private IRoleService roleService;

    @GetMapping
    public ResponseEntity<List<RoleDTO>> getAll() {
        return ResponseEntity.ok(roleService.findAll());
    }

    
    @GetMapping("/{id}")
    public ResponseEntity<RoleDTO> getById(@PathVariable Integer id) {
        return ResponseEntity.ok(roleService.findById(id));
    }

    
    @GetMapping("/name/{name}")
    public ResponseEntity<List<RoleDTO>> getByName(@PathVariable String name) {
        return ResponseEntity.ok(roleService.findByName(name));
    }

    
    @PostMapping
    public ResponseEntity<RoleDTO> save(@RequestBody RoleDTO dto) {
        return ResponseEntity.status(HttpStatus.CREATED).body(roleService.save(dto));
    }

    
    @PutMapping("/{id}")
    public ResponseEntity<RoleDTO> update(@PathVariable Integer id, @RequestBody RoleDTO dto) {
        return ResponseEntity.ok(roleService.update(id, dto));
    }

    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        roleService.delete(id);
        return ResponseEntity.noContent().build();
    }
}