package com.example.demo.Sales.impl;

import com.example.demo.Parameter.entity.Person;
import com.example.demo.Parameter.repository.PersonRepository;
import com.example.demo.Sales.dto.CustomerRequestDto;
import com.example.demo.Sales.dto.CustomerResponseDto;
import com.example.demo.Sales.entity.Customer;
import com.example.demo.Sales.repository.CustomerRepository;
import com.example.demo.Sales.service.CustomerService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CustomerServiceImpl implements CustomerService {

    private final CustomerRepository customerRepository;
    private final PersonRepository personRepository;

    @Override
    public CustomerResponseDto save(CustomerRequestDto request) {
        if (customerRepository.existsByPersonId(request.getPersonId()))
            throw new RuntimeException("Ya existe un cliente para la persona con ID: " + request.getPersonId());

        Person person = findPersonById(request.getPersonId());
        Customer entity = Customer.builder()
                .person(person)
                .status(true)
                .build();
        return toResponse(customerRepository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        Customer entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        customerRepository.save(entity);
    }

    @Override
    public CustomerResponseDto findById(UUID id) {
        return toResponse(findEntityById(id));
    }

    @Override
    public CustomerResponseDto findByDocumentNumber(String documentNumber) {
        return customerRepository.findByDocumentNumber(documentNumber)
                .map(this::toResponse)
                .orElseThrow(() -> new RuntimeException("Cliente no encontrado con documento: " + documentNumber));
    }

    @Override
    public List<CustomerResponseDto> findByName(String name) {
        return customerRepository.findByPersonName(name)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<CustomerResponseDto> findAllActive() {
        return customerRepository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<CustomerResponseDto> findAll() {
        return customerRepository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private Customer findEntityById(UUID id) {
        return customerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Cliente no encontrado con ID: " + id));
    }

    private Person findPersonById(UUID id) {
        return personRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Persona no encontrada con ID: " + id));
    }

    private CustomerResponseDto toResponse(Customer entity) {
        return CustomerResponseDto.builder()
                .id(entity.getId())
                .personId(entity.getPerson().getId())
                .personFullName(entity.getPerson().getFirstName() + " " + entity.getPerson().getLastName())
                .documentNumber(entity.getPerson().getDocumentNumber())
                .phone(entity.getPerson().getPhone())
                .email(entity.getPerson().getEmail())
                .status(entity.getStatus())
                .build();
    }
}
