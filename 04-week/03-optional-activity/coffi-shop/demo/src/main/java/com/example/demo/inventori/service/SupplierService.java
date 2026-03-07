package com.example.demo.Inventory.service;

import com.example.demo.Inventory.dto.SupplierRequestDto;
import com.example.demo.Inventory.dto.SupplierResponseDto;

import java.util.List;
import java.util.UUID;

public interface SupplierService {

    SupplierResponseDto save(SupplierRequestDto request);
    SupplierResponseDto update(UUID id, SupplierRequestDto request);
    void delete(UUID id);
    SupplierResponseDto findById(UUID id);
    List<SupplierResponseDto> findByCompany(String company);
    List<SupplierResponseDto> findByName(String name);
    List<SupplierResponseDto> findAllActive();
    List<SupplierResponseDto> findAll();
}
