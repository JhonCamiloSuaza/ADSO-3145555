package com.example.demo.Inventory.impl;

import com.example.demo.Inventory.dto.ProductRequestDto;
import com.example.demo.Inventory.dto.ProductResponseDto;
import com.example.demo.Inventory.entity.Category;
import com.example.demo.Inventory.entity.Product;
import com.example.demo.Inventory.entity.Supplier;
import com.example.demo.Inventory.repository.CategoryRepository;
import com.example.demo.Inventory.repository.ProductRepository;
import com.example.demo.Inventory.repository.SupplierRepository;
import com.example.demo.Inventory.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final SupplierRepository supplierRepository;

    @Override
    public ProductResponseDto save(ProductRequestDto request) {
        if (productRepository.existsByName(request.getName()))
            throw new RuntimeException("Ya existe un producto con el nombre: " + request.getName());

        Category category = findCategoryById(request.getCategoryId());
        Supplier supplier = request.getSupplierId() != null
                ? supplierRepository.findById(request.getSupplierId())
                    .orElseThrow(() -> new RuntimeException("Proveedor no encontrado con ID: " + request.getSupplierId()))
                : null;

        Product entity = Product.builder()
                .category(category)
                .supplier(supplier)
                .name(request.getName())
                .unitPrice(request.getUnitPrice())
                .unit(request.getUnit())
                .imageUrl(request.getImageUrl())
                .status(true)
                .build();
        return toResponse(productRepository.save(entity));
    }

    @Override
    public ProductResponseDto update(UUID id, ProductRequestDto request) {
        Product entity = findEntityById(id);
        Category category = findCategoryById(request.getCategoryId());
        Supplier supplier = request.getSupplierId() != null
                ? supplierRepository.findById(request.getSupplierId())
                    .orElseThrow(() -> new RuntimeException("Proveedor no encontrado con ID: " + request.getSupplierId()))
                : null;

        entity.setCategory(category);
        entity.setSupplier(supplier);
        entity.setName(request.getName());
        entity.setUnitPrice(request.getUnitPrice());
        entity.setUnit(request.getUnit());
        entity.setImageUrl(request.getImageUrl());
        return toResponse(productRepository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        Product entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        productRepository.save(entity);
    }

    @Override
    public ProductResponseDto findById(UUID id) {
        return toResponse(findEntityById(id));
    }

    @Override
    public List<ProductResponseDto> findByName(String name) {
        return productRepository.findByNameContainingIgnoreCase(name)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<ProductResponseDto> findByCategoryId(UUID categoryId) {
        return productRepository.findByCategoryId(categoryId)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<ProductResponseDto> findBySupplierId(UUID supplierId) {
        return productRepository.findBySupplierId(supplierId)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<ProductResponseDto> findByUnit(String unit) {
        return productRepository.findByUnit(unit)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<ProductResponseDto> findAllActive() {
        return productRepository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<ProductResponseDto> findAll() {
        return productRepository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private Product findEntityById(UUID id) {
        return productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Producto no encontrado con ID: " + id));
    }

    private Category findCategoryById(UUID id) {
        return categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Categoría no encontrada con ID: " + id));
    }

    private ProductResponseDto toResponse(Product entity) {
        return ProductResponseDto.builder()
                .id(entity.getId())
                .categoryName(entity.getCategory().getName())
                .supplierCompany(entity.getSupplier() != null ? entity.getSupplier().getCompany() : null)
                .name(entity.getName())
                .unitPrice(entity.getUnitPrice())
                .unit(entity.getUnit())
                .imageUrl(entity.getImageUrl())
                .status(entity.getStatus())
                .build();
    }
}
