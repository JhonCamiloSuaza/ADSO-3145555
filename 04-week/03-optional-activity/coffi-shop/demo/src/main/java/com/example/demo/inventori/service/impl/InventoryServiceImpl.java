package com.example.demo.Inventory.impl;

import com.example.demo.Inventory.dto.InventoryRequestDto;
import com.example.demo.Inventory.dto.InventoryResponseDto;
import com.example.demo.Inventory.entity.Inventory;
import com.example.demo.Inventory.entity.Product;
import com.example.demo.Inventory.repository.InventoryRepository;
import com.example.demo.Inventory.repository.ProductRepository;
import com.example.demo.Inventory.service.InventoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class InventoryServiceImpl implements InventoryService {

    private final InventoryRepository inventoryRepository;
    private final ProductRepository productRepository;

    @Override
    public InventoryResponseDto save(InventoryRequestDto request) {
        if (inventoryRepository.existsByProductId(request.getProductId()))
            throw new RuntimeException("Ya existe un inventario para el producto con ID: " + request.getProductId());

        Product product = findProductById(request.getProductId());

        Inventory entity = Inventory.builder()
                .product(product)
                .quantity(request.getQuantity())
                .minStock(request.getMinStock())
                .maxStock(request.getMaxStock())
                .lastUpdated(OffsetDateTime.now())
                .status(true)
                .build();
        return toResponse(inventoryRepository.save(entity));
    }

    @Override
    public InventoryResponseDto update(UUID id, InventoryRequestDto request) {
        Inventory entity = findEntityById(id);
        entity.setQuantity(request.getQuantity());
        entity.setMinStock(request.getMinStock());
        entity.setMaxStock(request.getMaxStock());
        entity.setLastUpdated(OffsetDateTime.now());
        return toResponse(inventoryRepository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        Inventory entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        inventoryRepository.save(entity);
    }

    @Override
    public InventoryResponseDto findById(UUID id) {
        return toResponse(findEntityById(id));
    }

    @Override
    public InventoryResponseDto findByProductId(UUID productId) {
        return inventoryRepository.findByProductId(productId)
                .map(this::toResponse)
                .orElseThrow(() -> new RuntimeException("Inventario no encontrado para el producto con ID: " + productId));
    }

    @Override
    public List<InventoryResponseDto> findBelowMinStock() {
        return inventoryRepository.findBelowMinStock()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<InventoryResponseDto> findAllActive() {
        return inventoryRepository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<InventoryResponseDto> findAll() {
        return inventoryRepository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private Inventory findEntityById(UUID id) {
        return inventoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Inventario no encontrado con ID: " + id));
    }

    private Product findProductById(UUID id) {
        return productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Producto no encontrado con ID: " + id));
    }

    private InventoryResponseDto toResponse(Inventory entity) {
        return InventoryResponseDto.builder()
                .id(entity.getId())
                .productId(entity.getProduct().getId())
                .productName(entity.getProduct().getName())
                .categoryName(entity.getProduct().getCategory().getName())
                .quantity(entity.getQuantity())
                .minStock(entity.getMinStock())
                .maxStock(entity.getMaxStock())
                .belowMinStock(entity.getQuantity().compareTo(entity.getMinStock()) < 0)
                .lastUpdated(entity.getLastUpdated())
                .status(entity.getStatus())
                .build();
    }
}
