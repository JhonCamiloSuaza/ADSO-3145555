package com.example.demo.parameter.service;

import java.util.List;
import java.util.UUID;

import com.example.demo.parameter.dtos.FileRequestDto;
import com.example.demo.parameter.dtos.FileResponseDto;

public interface FileService {

    // Guardar
    FileResponseDto save(FileRequestDto request);

    // Actualizar
    FileResponseDto update(UUID id, FileRequestDto request);

    // Eliminar (soft delete)
    void delete(UUID id);

    // Buscar por ID
    FileResponseDto findById(UUID id);

    // Buscar por nombre de archivo
    List<FileResponseDto> findByFileName(String fileName);

    // Buscar archivos de una persona
    List<FileResponseDto> findByPersonId(UUID personId);

    // Buscar por tipo de archivo
    List<FileResponseDto> findByFileType(String fileType);

    // Listar todos los activos
    List<FileResponseDto> findAllActive();

    // Listar todos
    List<FileResponseDto> findAll();
}
