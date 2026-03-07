package com.example.demo.Sales.controller;

import com.example.demo.Sales.dto.OrderItemRequestDto;
import com.example.demo.Sales.dto.OrderItemResponseDto;
import com.example.demo.Sales.service.OrderItemService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/order-item")
@RequiredArgsConstructor
public class OrderItemController {

    private final OrderItemService service;

    @PostMapping
    public ResponseEntity<OrderItemResponseDto> save(@Valid @RequestBody OrderItemRequestDto request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<OrderItemResponseDto> update(
            @PathVariable UUID id,
            @Valid @RequestBody OrderItemRequestDto request) {
        return ResponseEntity.ok(service.update(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderItemResponseDto> findById(@PathVariable UUID id) {
        return ResponseEntity.ok(service.findById(id));
    }

    @GetMapping("/order/{orderId}")
    public ResponseEntity<List<OrderItemResponseDto>> findByOrderId(@PathVariable UUID orderId) {
        return ResponseEntity.ok(service.findByOrderId(orderId));
    }

    @GetMapping("/product/{productId}")
    public ResponseEntity<List<OrderItemResponseDto>> findByProductId(@PathVariable UUID productId) {
        return ResponseEntity.ok(service.findByProductId(productId));
    }

    @GetMapping("/active")
    public ResponseEntity<List<OrderItemResponseDto>> findAllActive() {
        return ResponseEntity.ok(service.findAllActive());
    }

    @GetMapping
    public ResponseEntity<List<OrderItemResponseDto>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }
}
