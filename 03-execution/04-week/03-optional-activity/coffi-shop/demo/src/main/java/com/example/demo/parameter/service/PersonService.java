package com.example.demo.parameter.service;
import java.util.List;
import java.util.UUID;

import com.example.demo.parameter.dtos.PersonRequestDto;
import com.example.demo.parameter.dtos.PersonResponseDto;

public interface PersonService {

    // Guardar
    PersonResponseDto save(PersonRequestDto request);

    // Actualizar
    PersonResponseDto update(UUID id, PersonRequestDto request);

    // Eliminar (soft delete)
    void delete(UUID id);

    // Buscar por ID
    PersonResponseDto findById(UUID id);

    // Buscar por número de documento
    PersonResponseDto findByDocumentNumber(String documentNumber);

    // Buscar por nombre o apellido
    List<PersonResponseDto> findByName(String name);

    // Buscar por tipo de documento
    List<PersonResponseDto> findByTypeDocumentId(UUID typeDocumentId);

    // Listar todos los activos
    List<PersonResponseDto> findAllActive();

    // Listar todos
    List<PersonResponseDto> findAll();
}
