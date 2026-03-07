package com.example.demo.parameter.service.impl;


import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import com.example.demo.parameter.Repository.FileRepository;
import com.example.demo.parameter.Repository.PersonRepository;
import com.example.demo.parameter.dtos.FileRequestDto;
import com.example.demo.parameter.dtos.FileResponseDto;
import com.example.demo.parameter.entity.File;
import com.example.demo.parameter.entity.Person;
import com.example.demo.parameter.service.FileService;

@Service
@RequiredArgsConstructor
public class FileServiceImpl implements FileService {

    private final FileRepository fileRepository;
    private final PersonRepository personRepository;

    @Override
    public FileResponseDto save(FileRequestDto request) {
        Person person = findPersonById(request.getPersonId());
        File entity = File.builder()
                .person(person)
                .fileName(request.getFileName())
                .filePath(request.getFilePath())
                .fileType(request.getFileType())
                .fileSize(request.getFileSize())
                .status(true)
                .build();
        return toResponse(fileRepository.save(entity));
    }

    @Override
    public FileResponseDto update(UUID id, FileRequestDto request) {
        File entity = findEntityById(id);
        Person person = findPersonById(request.getPersonId());
        entity.setPerson(person);
        entity.setFileName(request.getFileName());
        entity.setFilePath(request.getFilePath());
        entity.setFileType(request.getFileType());
        entity.setFileSize(request.getFileSize());
        return toResponse(fileRepository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        File entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        fileRepository.save(entity);
    }

    @Override
    public FileResponseDto findById(UUID id) {
        return toResponse(findEntityById(id));
    }

    @Override
    public List<FileResponseDto> findByFileName(String fileName) {
        return fileRepository.findByFileNameContainingIgnoreCase(fileName)
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<FileResponseDto> findByPersonId(UUID personId) {
        return fileRepository.findActiveFilesByPersonId(personId)
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<FileResponseDto> findByFileType(String fileType) {
        return fileRepository.findByFileType(fileType)
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<FileResponseDto> findAllActive() {
        return fileRepository.findByStatusTrue()
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<FileResponseDto> findAll() {
        return fileRepository.findAll()
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    // ── Métodos privados

    private File findEntityById(UUID id) {
        return fileRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Archivo no encontrado con ID: " + id));
    }

    private Person findPersonById(UUID id) {
        return personRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Persona no encontrada con ID: " + id));
    }

    private FileResponseDto toResponse(File entity) {
        return FileResponseDto.builder()
                .id(entity.getId())
                .personId(entity.getPerson().getId())
                .personFullName(entity.getPerson().getFirstName() + " " + entity.getPerson().getLastName())
                .fileName(entity.getFileName())
                .filePath(entity.getFilePath())
                .fileType(entity.getFileType())
                .fileSize(entity.getFileSize())
                .status(entity.getStatus())
                .build();
    }
}
