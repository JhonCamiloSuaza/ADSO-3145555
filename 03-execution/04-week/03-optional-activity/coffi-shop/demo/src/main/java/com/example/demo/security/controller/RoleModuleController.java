package com.example.demo.security.controller;

import com.example.demo.security.dtos.RoleModuleRequestDto;
import com.example.demo.security.dtos.RoleModuleResponseDto;
import com.example.demo.security.service.RoleModuleService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/role-module")
@RequiredArgsConstructor
public class RoleModuleController {
    private final RoleModuleService service;

    @PostMapping
    public ResponseEntity<RoleModuleResponseDto> save(@Valid @RequestBody RoleModuleRequestDto request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<RoleModuleResponseDto> update(@PathVariable UUID id, @Valid @RequestBody RoleModuleRequestDto request) {
        return ResponseEntity.ok(service.update(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/role/{roleId}")
    public ResponseEntity<List<RoleModuleResponseDto>> findByRoleId(@PathVariable UUID roleId) {
        return ResponseEntity.ok(service.findByRoleId(roleId));
    }

    @GetMapping("/module/{moduleId}")
    public ResponseEntity<List<RoleModuleResponseDto>> findByModuleId(@PathVariable UUID moduleId) {
        return ResponseEntity.ok(service.findByModuleId(moduleId));
    }

    @GetMapping("/active")
    public ResponseEntity<List<RoleModuleResponseDto>> findAllActive() {
        return ResponseEntity.ok(service.findAllActive());
    }

    @GetMapping
    public ResponseEntity<List<RoleModuleResponseDto>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }
}
