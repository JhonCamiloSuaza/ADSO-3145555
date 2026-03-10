package com.example.demo.Inventory.controller;

import com.example.demo.Inventory.dto.InventoryRequestDto;
import com.example.demo.Inventory.dto.InventoryResponseDto;
import com.example.demo.Inventory.service.InventoryService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/inventory")
@RequiredArgsConstructor
public class InventoryController {

    private final InventoryService service;

    @PostMapping
    public ResponseEntity<InventoryResponseDto> save(@Valid @RequestBody InventoryRequestDto request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<InventoryResponseDto> update(
            @PathVariable UUID id,
            @Valid @RequestBody InventoryRequestDto request) {
        return ResponseEntity.ok(service.update(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<InventoryResponseDto> findById(@PathVariable UUID id) {
        return ResponseEntity.ok(service.findById(id));
    }

    @GetMapping("/product/{productId}")
    public ResponseEntity<InventoryResponseDto> findByProductId(@PathVariable UUID productId) {
        return ResponseEntity.ok(service.findByProductId(productId));
    }

    // Alerta: productos con stock por debajo del mínimo
    @GetMapping("/alerts/below-min-stock")
    public ResponseEntity<List<InventoryResponseDto>> findBelowMinStock() {
        return ResponseEntity.ok(service.findBelowMinStock());
    }

    @GetMapping("/active")
    public ResponseEntity<List<InventoryResponseDto>> findAllActive() {
        return ResponseEntity.ok(service.findAllActive());
    }

    @GetMapping
    public ResponseEntity<List<InventoryResponseDto>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }
}
