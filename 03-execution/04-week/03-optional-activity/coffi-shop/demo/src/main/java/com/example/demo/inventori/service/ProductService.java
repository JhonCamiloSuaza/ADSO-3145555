package com.example.demo.Inventory.service;

import com.example.demo.Inventory.dto.ProductRequestDto;
import com.example.demo.Inventory.dto.ProductResponseDto;

import java.util.List;
import java.util.UUID;

public interface ProductService {

    ProductResponseDto save(ProductRequestDto request);
    ProductResponseDto update(UUID id, ProductRequestDto request);
    void delete(UUID id);
    ProductResponseDto findById(UUID id);
    List<ProductResponseDto> findByName(String name);
    List<ProductResponseDto> findByCategoryId(UUID categoryId);
    List<ProductResponseDto> findBySupplierId(UUID supplierId);
    List<ProductResponseDto> findByUnit(String unit);
    List<ProductResponseDto> findAllActive();
    List<ProductResponseDto> findAll();
}
