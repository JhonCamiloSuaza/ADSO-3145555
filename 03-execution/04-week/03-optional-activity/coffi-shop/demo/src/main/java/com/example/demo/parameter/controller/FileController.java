package com.example.demo.parameter.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

import com.example.demo.parameter.dtos.FileRequestDto;
import com.example.demo.parameter.dtos.FileResponseDto;
import com.example.demo.parameter.service.FileService;

@RestController
@RequestMapping("/api/file")
@RequiredArgsConstructor
public class FileController {

    private final FileService service;

    // Guardar
    @PostMapping
    public ResponseEntity<FileResponseDto> save(@Valid @RequestBody FileRequestDto request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(request));
    }

    // Actualizar
    @PutMapping("/{id}")
    public ResponseEntity<FileResponseDto> update(
            @PathVariable UUID id,
            @Valid @RequestBody FileRequestDto request) {
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
    public ResponseEntity<FileResponseDto> findById(@PathVariable UUID id) {
        return ResponseEntity.ok(service.findById(id));
    }

    // Buscar por nombre de archivo
    @GetMapping("/search")
    public ResponseEntity<List<FileResponseDto>> findByFileName(@RequestParam String fileName) {
        return ResponseEntity.ok(service.findByFileName(fileName));
    }

    // Buscar archivos de una persona
    @GetMapping("/person/{personId}")
    public ResponseEntity<List<FileResponseDto>> findByPersonId(@PathVariable UUID personId) {
        return ResponseEntity.ok(service.findByPersonId(personId));
    }

    // Buscar por tipo de archivo
    @GetMapping("/type/{fileType}")
    public ResponseEntity<List<FileResponseDto>> findByFileType(@PathVariable String fileType) {
        return ResponseEntity.ok(service.findByFileType(fileType));
    }

    // Listar todos los activos
    @GetMapping("/active")
    public ResponseEntity<List<FileResponseDto>> findAllActive() {
        return ResponseEntity.ok(service.findAllActive());
    }

    // Listar todos
    @GetMapping
    public ResponseEntity<List<FileResponseDto>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }
}
