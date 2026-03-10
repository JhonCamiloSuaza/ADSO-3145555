package com.example.demo.Inventory.impl;

import com.example.demo.Inventory.dto.CategoryRequestDto;
import com.example.demo.Inventory.dto.CategoryResponseDto;
import com.example.demo.Inventory.entity.Category;
import com.example.demo.Inventory.repository.CategoryRepository;
import com.example.demo.Inventory.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService {

    private final CategoryRepository repository;

    @Override
    public CategoryResponseDto save(CategoryRequestDto request) {
        if (repository.existsByName(request.getName()))
            throw new RuntimeException("Ya existe una categoría con el nombre: " + request.getName());

        Category entity = Category.builder()
                .name(request.getName())
                .description(request.getDescription())
                .imageUrl(request.getImageUrl())
                .status(true)
                .build();
        return toResponse(repository.save(entity));
    }

    @Override
    public CategoryResponseDto update(UUID id, CategoryRequestDto request) {
        Category entity = findEntityById(id);
        entity.setName(request.getName());
        entity.setDescription(request.getDescription());
        entity.setImageUrl(request.getImageUrl());
        return toResponse(repository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        Category entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        repository.save(entity);
    }

    @Override
    public CategoryResponseDto findById(UUID id) {
        return toResponse(findEntityById(id));
    }

    @Override
    public List<CategoryResponseDto> findByName(String name) {
        return repository.findByNameContainingIgnoreCase(name)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<CategoryResponseDto> findAllActive() {
        return repository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<CategoryResponseDto> findAll() {
        return repository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private Category findEntityById(UUID id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Categoría no encontrada con ID: " + id));
    }

    private CategoryResponseDto toResponse(Category entity) {
        return CategoryResponseDto.builder()
                .id(entity.getId())
                .name(entity.getName())
                .description(entity.getDescription())
                .imageUrl(entity.getImageUrl())
                .status(entity.getStatus())
                .build();
    }
}
