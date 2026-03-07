package com.example.demo.security.controller;

import com.example.demo.security.dtos.ModuleRequestDto;
import com.example.demo.security.dtos.ModuleResponseDto;
import com.example.demo.security.service.ModuleService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/module")
@RequiredArgsConstructor
public class ModuleController {
    private final ModuleService service;

    @PostMapping
    public ResponseEntity<ModuleResponseDto> save(@Valid @RequestBody ModuleRequestDto request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ModuleResponseDto> update(@PathVariable UUID id, @Valid @RequestBody ModuleRequestDto request) {
        return ResponseEntity.ok(service.update(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ModuleResponseDto> findById(@PathVariable UUID id) {
        return ResponseEntity.ok(service.findById(id));
    }

    @GetMapping("/search")
    public ResponseEntity<List<ModuleResponseDto>> findByName(@RequestParam String name) {
        return ResponseEntity.ok(service.findByName(name));
    }

    @GetMapping("/active")
    public ResponseEntity<List<ModuleResponseDto>> findAllActive() {
        return ResponseEntity.ok(service.findAllActive());
    }

    @GetMapping
    public ResponseEntity<List<ModuleResponseDto>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }
}
