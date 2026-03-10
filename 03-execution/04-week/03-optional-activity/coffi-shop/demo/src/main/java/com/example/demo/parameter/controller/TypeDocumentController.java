package com.example.demo.parameter.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.demo.parameter.service.TypeDocumentService;

import java.util.List;
import java.util.UUID;

import com.example.demo.parameter.dtos.TypeDocumentRequestDto;
import com.example.demo.parameter.dtos.TypeDocumentResponseDto;

@RestController
@RequestMapping("/api/type-document")
@RequiredArgsConstructor
public class TypeDocumentController {

    private final TypeDocumentService service;

    // Guardar
    @PostMapping
    public ResponseEntity<TypeDocumentResponseDto> save(@Valid @RequestBody TypeDocumentRequestDto request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(request));
    }

    // Actualizar
    @PutMapping("/{id}")
    public ResponseEntity<TypeDocumentResponseDto> update(
            @PathVariable UUID id,
            @Valid @RequestBody TypeDocumentRequestDto request) {
        return ResponseEntity.ok(service.update(id, request));
    }

    // Eliminar (soft delete)
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    // Buscar por ID
    @GetMapping("/{id}")
    public ResponseEntity<TypeDocumentResponseDto> findById(@PathVariable UUID id) {
        return ResponseEntity.ok(service.findById(id));
    }

    // Buscar por código
    @GetMapping("/code/{code}")
    public ResponseEntity<TypeDocumentResponseDto> findByCode(@PathVariable String code) {
        return ResponseEntity.ok(service.findByCode(code));
    }

    // Buscar por nombre
    @GetMapping("/search")
    public ResponseEntity<List<TypeDocumentResponseDto>> findByName(@RequestParam String name) {
        return ResponseEntity.ok(service.findByName(name));
    }

    // Listar todos los activos
    @GetMapping("/active")
    public ResponseEntity<List<TypeDocumentResponseDto>> findAllActive() {
        return ResponseEntity.ok(service.findAllActive());
    }

    // Listar todos
    @GetMapping
    public ResponseEntity<List<TypeDocumentResponseDto>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }
}
