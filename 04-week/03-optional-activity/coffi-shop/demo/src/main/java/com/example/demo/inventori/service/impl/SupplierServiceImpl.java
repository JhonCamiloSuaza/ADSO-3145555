package com.example.demo.Inventory.impl;

import com.example.demo.Inventory.dto.SupplierRequestDto;
import com.example.demo.Inventory.dto.SupplierResponseDto;
import com.example.demo.Inventory.entity.Supplier;
import com.example.demo.Inventory.repository.SupplierRepository;
import com.example.demo.Inventory.service.SupplierService;
import com.example.demo.Parameter.entity.Person;
import com.example.demo.Parameter.repository.PersonRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SupplierServiceImpl implements SupplierService {

    private final SupplierRepository supplierRepository;
    private final PersonRepository personRepository;

    @Override
    public SupplierResponseDto save(SupplierRequestDto request) {
        Person person = findPersonById(request.getPersonId());
        Supplier entity = Supplier.builder()
                .person(person)
                .company(request.getCompany())
                .status(true)
                .build();
        return toResponse(supplierRepository.save(entity));
    }

    @Override
    public SupplierResponseDto update(UUID id, SupplierRequestDto request) {
        Supplier entity = findEntityById(id);
        Person person = findPersonById(request.getPersonId());
        entity.setPerson(person);
        entity.setCompany(request.getCompany());
        return toResponse(supplierRepository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        Supplier entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        supplierRepository.save(entity);
    }

    @Override
    public SupplierResponseDto findById(UUID id) {
        return toResponse(findEntityById(id));
    }

    @Override
    public List<SupplierResponseDto> findByCompany(String company) {
        return supplierRepository.findByCompanyContainingIgnoreCase(company)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<SupplierResponseDto> findByName(String name) {
        return supplierRepository.findByPersonName(name)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<SupplierResponseDto> findAllActive() {
        return supplierRepository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<SupplierResponseDto> findAll() {
        return supplierRepository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private Supplier findEntityById(UUID id) {
        return supplierRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Proveedor no encontrado con ID: " + id));
    }

    private Person findPersonById(UUID id) {
        return personRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Persona no encontrada con ID: " + id));
    }

    private SupplierResponseDto toResponse(Supplier entity) {
        return SupplierResponseDto.builder()
                .id(entity.getId())
                .personId(entity.getPerson().getId())
                .personFullName(entity.getPerson().getFirstName() + " " + entity.getPerson().getLastName())
                .documentNumber(entity.getPerson().getDocumentNumber())
                .phone(entity.getPerson().getPhone())
                .email(entity.getPerson().getEmail())
                .company(entity.getCompany())
                .status(entity.getStatus())
                .build();
    }
}
