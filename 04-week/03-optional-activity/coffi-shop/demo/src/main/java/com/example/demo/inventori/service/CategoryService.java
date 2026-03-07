package com.example.demo.Inventory.service;

import com.example.demo.Inventory.dto.CategoryRequestDto;
import com.example.demo.Inventory.dto.CategoryResponseDto;

import java.util.List;
import java.util.UUID;

public interface CategoryService {

    CategoryResponseDto save(CategoryRequestDto request);
    CategoryResponseDto update(UUID id, CategoryRequestDto request);
    void delete(UUID id);
    CategoryResponseDto findById(UUID id);
    List<CategoryResponseDto> findByName(String name);
    List<CategoryResponseDto> findAllActive();
    List<CategoryResponseDto> findAll();
}
