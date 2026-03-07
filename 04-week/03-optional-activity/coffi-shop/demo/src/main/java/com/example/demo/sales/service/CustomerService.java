package com.example.demo.Sales.service;

import com.example.demo.Sales.dto.CustomerRequestDto;
import com.example.demo.Sales.dto.CustomerResponseDto;

import java.util.List;
import java.util.UUID;

public interface CustomerService {

    CustomerResponseDto save(CustomerRequestDto request);
    void delete(UUID id);
    CustomerResponseDto findById(UUID id);
    CustomerResponseDto findByDocumentNumber(String documentNumber);
    List<CustomerResponseDto> findByName(String name);
    List<CustomerResponseDto> findAllActive();
    List<CustomerResponseDto> findAll();
}
