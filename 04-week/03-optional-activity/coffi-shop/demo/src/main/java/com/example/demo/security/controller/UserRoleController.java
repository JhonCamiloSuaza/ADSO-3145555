package com.example.demo.security.controller;

import com.example.demo.security.dtos.UserRoleRequestDto;
import com.example.demo.security.dtos.UserRoleResponseDto;
import com.example.demo.security.service.UserRoleService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/user-role")
@RequiredArgsConstructor
public class UserRoleController {
    private final UserRoleService service;

    @PostMapping
    public ResponseEntity<UserRoleResponseDto> save(@Valid @RequestBody UserRoleRequestDto request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<UserRoleResponseDto>> findByUserId(@PathVariable UUID userId) {
        return ResponseEntity.ok(service.findByUserId(userId));
    }

    @GetMapping("/role/{roleId}")
    public ResponseEntity<List<UserRoleResponseDto>> findByRoleId(@PathVariable UUID roleId) {
        return ResponseEntity.ok(service.findByRoleId(roleId));
    }

    @GetMapping("/active")
    public ResponseEntity<List<UserRoleResponseDto>> findAllActive() {
        return ResponseEntity.ok(service.findAllActive());
    }

    @GetMapping
    public ResponseEntity<List<UserRoleResponseDto>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }
}
