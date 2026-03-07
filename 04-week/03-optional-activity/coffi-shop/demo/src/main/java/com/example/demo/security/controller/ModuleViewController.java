package com.example.demo.security.controller;

import com.example.demo.security.dtos.ModuleViewRequestDto;
import com.example.demo.security.dtos.ModuleViewResponseDto;
import com.example.demo.security.service.ModuleViewService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/module-view")
@RequiredArgsConstructor
public class ModuleViewController {
    private final ModuleViewService service;

    @PostMapping
    public ResponseEntity<ModuleViewResponseDto> save(@Valid @RequestBody ModuleViewRequestDto request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/module/{moduleId}")
    public ResponseEntity<List<ModuleViewResponseDto>> findByModuleId(@PathVariable UUID moduleId) {
        return ResponseEntity.ok(service.findByModuleId(moduleId));
    }

    @GetMapping("/view/{systemViewId}")
    public ResponseEntity<List<ModuleViewResponseDto>> findBySystemViewId(@PathVariable UUID systemViewId) {
        return ResponseEntity.ok(service.findBySystemViewId(systemViewId));
    }

    @GetMapping("/active")
    public ResponseEntity<List<ModuleViewResponseDto>> findAllActive() {
        return ResponseEntity.ok(service.findAllActive());
    }

    @GetMapping
    public ResponseEntity<List<ModuleViewResponseDto>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }
}
