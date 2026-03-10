package com.example.demo.parameter.service.impl;


import com.example.demo.parameter.dtos.PersonRequestDto;
import com.example.demo.parameter.dtos.PersonResponseDto;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import com.example.demo.parameter.Repository.PersonRepository;
import com.example.demo.parameter.Repository.TypeDocumentRepository;
import com.example.demo.parameter.entity.Person;
import com.example.demo.parameter.entity.TypeDocument;
import com.example.demo.parameter.service.PersonService;

@Service
@RequiredArgsConstructor
public class PersonServiceImpl implements PersonService {

    private final PersonRepository personRepository;
    private final TypeDocumentRepository typeDocumentRepository;

    @Override
    public PersonResponseDto save(PersonRequestDto request) {
        if (personRepository.existsByDocumentNumber(request.getDocumentNumber())) {
            throw new RuntimeException("Ya existe una persona con el documento: " + request.getDocumentNumber());
        }
        if (request.getEmail() != null && personRepository.existsByEmail(request.getEmail())) {
            throw new RuntimeException("Ya existe una persona con el email: " + request.getEmail());
        }
        TypeDocument typeDocument = findTypeDocumentById(request.getTypeDocumentId());
        Person entity = Person.builder()
                .typeDocument(typeDocument)
                .documentNumber(request.getDocumentNumber())
                .firstName(request.getFirstName())
                .lastName(request.getLastName())
                .phone(request.getPhone())
                .email(request.getEmail())
                .status(true)
                .build();
        return toResponse(personRepository.save(entity));
    }

    @Override
    public PersonResponseDto update(UUID id, PersonRequestDto request) {
        Person entity = findEntityById(id);
        TypeDocument typeDocument = findTypeDocumentById(request.getTypeDocumentId());
        entity.setTypeDocument(typeDocument);
        entity.setDocumentNumber(request.getDocumentNumber());
        entity.setFirstName(request.getFirstName());
        entity.setLastName(request.getLastName());
        entity.setPhone(request.getPhone());
        entity.setEmail(request.getEmail());
        return toResponse(personRepository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        Person entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        personRepository.save(entity);
    }

    @Override
    public PersonResponseDto findById(UUID id) {
        return toResponse(findEntityById(id));
    }

    @Override
    public PersonResponseDto findByDocumentNumber(String documentNumber) {
        return personRepository.findByDocumentNumber(documentNumber)
                .map(this::toResponse)
                .orElseThrow(() -> new RuntimeException("Persona no encontrada con documento: " + documentNumber));
    }

    @Override
    public List<PersonResponseDto> findByName(String name) {
        return personRepository
                .findByFirstNameContainingIgnoreCaseOrLastNameContainingIgnoreCase(name, name)
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<PersonResponseDto> findByTypeDocumentId(UUID typeDocumentId) {
        return personRepository.findByTypeDocumentId(typeDocumentId)
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<PersonResponseDto> findAllActive() {
        return personRepository.findByStatusTrue()
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<PersonResponseDto> findAll() {
        return personRepository.findAll()
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    // ── Métodos privados
    private Person findEntityById(UUID id) {
        return personRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Persona no encontrada con ID: " + id));
    }

    private TypeDocument findTypeDocumentById(UUID id) {
        return typeDocumentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Tipo de documento no encontrado con ID: " + id));
    }

    private PersonResponseDto toResponse(Person entity) {
        return PersonResponseDto.builder()
                .id(entity.getId())
                .typeDocumentName(entity.getTypeDocument().getName())
                .typeDocumentCode(entity.getTypeDocument().getCode())
                .documentNumber(entity.getDocumentNumber())
                .firstName(entity.getFirstName())
                .lastName(entity.getLastName())
                .phone(entity.getPhone())
                .email(entity.getEmail())
                .status(entity.getStatus())
                .build();
    }
}
