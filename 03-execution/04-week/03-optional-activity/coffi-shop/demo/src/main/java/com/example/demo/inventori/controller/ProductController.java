package com.example.demo.Inventory.controller;

import com.example.demo.Inventory.dto.ProductRequestDto;
import com.example.demo.Inventory.dto.ProductResponseDto;
import com.example.demo.Inventory.service.ProductService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/product")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService service;

    @PostMapping
    public ResponseEntity<ProductResponseDto> save(@Valid @RequestBody ProductRequestDto request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ProductResponseDto> update(
            @PathVariable UUID id,
            @Valid @RequestBody ProductRequestDto request) {
        return ResponseEntity.ok(service.update(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductResponseDto> findById(@PathVariable UUID id) {
        return ResponseEntity.ok(service.findById(id));
    }

    @GetMapping("/search")
    public ResponseEntity<List<ProductResponseDto>> findByName(@RequestParam String name) {
        return ResponseEntity.ok(service.findByName(name));
    }

    @GetMapping("/category/{categoryId}")
    public ResponseEntity<List<ProductResponseDto>> findByCategoryId(@PathVariable UUID categoryId) {
        return ResponseEntity.ok(service.findByCategoryId(categoryId));
    }

    @GetMapping("/supplier/{supplierId}")
    public ResponseEntity<List<ProductResponseDto>> findBySupplierId(@PathVariable UUID supplierId) {
        return ResponseEntity.ok(service.findBySupplierId(supplierId));
    }

    @GetMapping("/unit/{unit}")
    public ResponseEntity<List<ProductResponseDto>> findByUnit(@PathVariable String unit) {
        return ResponseEntity.ok(service.findByUnit(unit));
    }

    @GetMapping("/active")
    public ResponseEntity<List<ProductResponseDto>> findAllActive() {
        return ResponseEntity.ok(service.findAllActive());
    }

    @GetMapping
    public ResponseEntity<List<ProductResponseDto>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }
}
