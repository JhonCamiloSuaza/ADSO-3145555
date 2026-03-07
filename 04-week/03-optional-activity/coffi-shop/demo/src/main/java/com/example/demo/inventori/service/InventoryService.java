package com.example.demo.Inventory.service;

import com.example.demo.Inventory.dto.InventoryRequestDto;
import com.example.demo.Inventory.dto.InventoryResponseDto;

import java.util.List;
import java.util.UUID;

public interface InventoryService {

    InventoryResponseDto save(InventoryRequestDto request);
    InventoryResponseDto update(UUID id, InventoryRequestDto request);
    void delete(UUID id);
    InventoryResponseDto findById(UUID id);
    InventoryResponseDto findByProductId(UUID productId);
    List<InventoryResponseDto> findBelowMinStock();
    List<InventoryResponseDto> findAllActive();
    List<InventoryResponseDto> findAll();
}
