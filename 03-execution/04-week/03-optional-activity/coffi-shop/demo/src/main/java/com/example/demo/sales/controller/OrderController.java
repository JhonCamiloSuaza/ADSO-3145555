package com.example.demo.Sales.controller;

import com.example.demo.Sales.dto.OrderRequestDto;
import com.example.demo.Sales.dto.OrderResponseDto;
import com.example.demo.Sales.service.OrderService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/order")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService service;

    @PostMapping
    public ResponseEntity<OrderResponseDto> save(@Valid @RequestBody OrderRequestDto request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<OrderResponseDto> update(
            @PathVariable UUID id,
            @Valid @RequestBody OrderRequestDto request) {
        return ResponseEntity.ok(service.update(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderResponseDto> findById(@PathVariable UUID id) {
        return ResponseEntity.ok(service.findById(id));
    }

    @GetMapping("/customer/{customerId}")
    public ResponseEntity<List<OrderResponseDto>> findByCustomerId(@PathVariable UUID customerId) {
        return ResponseEntity.ok(service.findByCustomerId(customerId));
    }

    @GetMapping("/method-payment/{methodPaymentId}")
    public ResponseEntity<List<OrderResponseDto>> findByMethodPaymentId(@PathVariable UUID methodPaymentId) {
        return ResponseEntity.ok(service.findByMethodPaymentId(methodPaymentId));
    }

    @GetMapping("/status/{orderStatus}")
    public ResponseEntity<List<OrderResponseDto>> findByOrderStatus(@PathVariable String orderStatus) {
        return ResponseEntity.ok(service.findByOrderStatus(orderStatus));
    }

    @GetMapping("/active")
    public ResponseEntity<List<OrderResponseDto>> findAllActive() {
        return ResponseEntity.ok(service.findAllActive());
    }

    @GetMapping
    public ResponseEntity<List<OrderResponseDto>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }
}
