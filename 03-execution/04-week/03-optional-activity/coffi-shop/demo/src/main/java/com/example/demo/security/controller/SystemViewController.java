package com.example.demo.security.controller;

import com.example.demo.security.dtos.SystemViewRequestDto;
import com.example.demo.security.dtos.SystemViewResponseDto;
import com.example.demo.security.service.SystemViewService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/system-view")
@RequiredArgsConstructor
public class SystemViewController {
    private final SystemViewService service;

    @PostMapping
    public ResponseEntity<SystemViewResponseDto> save(@Valid @RequestBody SystemViewRequestDto request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<SystemViewResponseDto> update(@PathVariable UUID id, @Valid @RequestBody SystemViewRequestDto request) {
        return ResponseEntity.ok(service.update(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<SystemViewResponseDto> findById(@PathVariable UUID id) {
        return ResponseEntity.ok(service.findById(id));
    }

    @GetMapping("/search")
    public ResponseEntity<List<SystemViewResponseDto>> findByName(@RequestParam String name) {
        return ResponseEntity.ok(service.findByName(name));
    }

    @GetMapping("/active")
    public ResponseEntity<List<SystemViewResponseDto>> findAllActive() {
        return ResponseEntity.ok(service.findAllActive());
    }

    @GetMapping
    public ResponseEntity<List<SystemViewResponseDto>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }
}
