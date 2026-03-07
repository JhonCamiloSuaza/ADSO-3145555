package com.example.demo.parameter.service.impl;


import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import com.example.demo.parameter.Repository.TypeDocumentRepository;
import com.example.demo.parameter.dtos.TypeDocumentRequestDto;
import com.example.demo.parameter.dtos.TypeDocumentResponseDto;
import com.example.demo.parameter.entity.TypeDocument;
import com.example.demo.parameter.service.TypeDocumentService;

@Service
@RequiredArgsConstructor
public class TypeDocumentServiceImpl implements TypeDocumentService {

    private final TypeDocumentRepository repository;

    @Override
    public TypeDocumentResponseDto save(TypeDocumentRequestDto request) {
        if (repository.existsByCode(request.getCode())) {
            throw new RuntimeException("Ya existe un tipo de documento con el código: " + request.getCode());
        }
        TypeDocument entity = TypeDocument.builder()
                .name(request.getName())
                .code(request.getCode())
                .description(request.getDescription())
                .status(true)
                .build();
        return toResponse(repository.save(entity));
    }

    @Override
    public TypeDocumentResponseDto update(UUID id, TypeDocumentRequestDto request) {
        TypeDocument entity = findEntityById(id);
        entity.setName(request.getName());
        entity.setCode(request.getCode());
        entity.setDescription(request.getDescription());
        return toResponse(repository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        TypeDocument entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        repository.save(entity);
    }

    @Override
    public TypeDocumentResponseDto findById(UUID id) {
        return toResponse(findEntityById(id));
    }

    @Override
    public TypeDocumentResponseDto findByCode(String code) {
        return repository.findByCode(code)
                .map(this::toResponse)
                .orElseThrow(() -> new RuntimeException("Tipo de documento no encontrado con código: " + code));
    }

    @Override
    public List<TypeDocumentResponseDto> findByName(String name) {
        return repository.findByNameContainingIgnoreCase(name)
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<TypeDocumentResponseDto> findAllActive() {
        return repository.findByStatusTrue()
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<TypeDocumentResponseDto> findAll() {
        return repository.findAll()
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    // ── Métodos privados

    private TypeDocument findEntityById(UUID id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Tipo de documento no encontrado con ID: " + id));
    }

    private TypeDocumentResponseDto toResponse(TypeDocument entity) {
        return TypeDocumentResponseDto.builder()
                .id(entity.getId())
                .name(entity.getName())
                .code(entity.getCode())
                .description(entity.getDescription())
                .status(entity.getStatus())
                .build();
    }
}
