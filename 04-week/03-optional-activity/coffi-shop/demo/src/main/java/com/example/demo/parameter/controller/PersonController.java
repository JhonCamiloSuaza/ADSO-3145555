package com.example.demo.parameter.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

import com.example.demo.parameter.dtos.PersonRequestDto;
import com.example.demo.parameter.dtos.PersonResponseDto;
import com.example.demo.parameter.service.PersonService;

@RestController
@RequestMapping("/api/person")
@RequiredArgsConstructor
public class PersonController {

    private final PersonService service;

    // Guardar
    @PostMapping
    public ResponseEntity<PersonResponseDto> save(@Valid @RequestBody PersonRequestDto request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(request));
    }

    // Actualizar
    @PutMapping("/{id}")
    public ResponseEntity<PersonResponseDto> update(
            @PathVariable UUID id,
            @Valid @RequestBody PersonRequestDto request) {
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
    public ResponseEntity<PersonResponseDto> findById(@PathVariable UUID id) {
        return ResponseEntity.ok(service.findById(id));
    }

    // Buscar por número de documento
    @GetMapping("/document/{documentNumber}")
    public ResponseEntity<PersonResponseDto> findByDocumentNumber(@PathVariable String documentNumber) {
        return ResponseEntity.ok(service.findByDocumentNumber(documentNumber));
    }

    // Buscar por nombre o apellido
    @GetMapping("/search")
    public ResponseEntity<List<PersonResponseDto>> findByName(@RequestParam String name) {
        return ResponseEntity.ok(service.findByName(name));
    }

    // Buscar por tipo de documento
    @GetMapping("/type-document/{typeDocumentId}")
    public ResponseEntity<List<PersonResponseDto>> findByTypeDocumentId(@PathVariable UUID typeDocumentId) {
        return ResponseEntity.ok(service.findByTypeDocumentId(typeDocumentId));
    }

    // Listar todos los activos
    @GetMapping("/active")
    public ResponseEntity<List<PersonResponseDto>> findAllActive() {
        return ResponseEntity.ok(service.findAllActive());
    }

    // Listar todos
    @GetMapping
    public ResponseEntity<List<PersonResponseDto>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }
}
