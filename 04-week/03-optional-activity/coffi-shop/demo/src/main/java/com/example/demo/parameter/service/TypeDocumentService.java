package com.example.demo.parameter.service;

import java.util.List;
import java.util.UUID;

import com.example.demo.parameter.dtos.TypeDocumentRequestDto;
import com.example.demo.parameter.dtos.TypeDocumentResponseDto;

public interface TypeDocumentService {

    // Guardar
    TypeDocumentResponseDto save(TypeDocumentRequestDto request);

    // Actualizar
    TypeDocumentResponseDto update(UUID id, TypeDocumentRequestDto request);

    // Eliminar (soft delete)
    void delete(UUID id);

    // Buscar por ID
    TypeDocumentResponseDto findById(UUID id);

    // Buscar por código
    TypeDocumentResponseDto findByCode(String code);

    // Buscar por nombre
    List<TypeDocumentResponseDto> findByName(String name);

    // Listar todos los activos
    List<TypeDocumentResponseDto> findAllActive();

    // Listar todos
    List<TypeDocumentResponseDto> findAll();
}
