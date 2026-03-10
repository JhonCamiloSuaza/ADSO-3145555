package com.example.demo.Billing.controller;

import com.example.demo.Billing.dto.InvoiceRequestDto;
import com.example.demo.Billing.dto.InvoiceResponseDto;
import com.example.demo.Billing.service.InvoiceService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/invoice")
@RequiredArgsConstructor
public class InvoiceController {

    private final InvoiceService service;

    @PostMapping
    public ResponseEntity<InvoiceResponseDto> save(@Valid @RequestBody InvoiceRequestDto request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<InvoiceResponseDto> update(
            @PathVariable UUID id,
            @Valid @RequestBody InvoiceRequestDto request) {
        return ResponseEntity.ok(service.update(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<InvoiceResponseDto> findById(@PathVariable UUID id) {
        return ResponseEntity.ok(service.findById(id));
    }

    @GetMapping("/order/{orderId}")
    public ResponseEntity<InvoiceResponseDto> findByOrderId(@PathVariable UUID orderId) {
        return ResponseEntity.ok(service.findByOrderId(orderId));
    }

    @GetMapping("/customer/{customerId}")
    public ResponseEntity<List<InvoiceResponseDto>> findByCustomerId(@PathVariable UUID customerId) {
        return ResponseEntity.ok(service.findByCustomerId(customerId));
    }

    @GetMapping("/status/{invoiceStatus}")
    public ResponseEntity<List<InvoiceResponseDto>> findByInvoiceStatus(@PathVariable String invoiceStatus) {
        return ResponseEntity.ok(service.findByInvoiceStatus(invoiceStatus));
    }

    @GetMapping("/active")
    public ResponseEntity<List<InvoiceResponseDto>> findAllActive() {
        return ResponseEntity.ok(service.findAllActive());
    }

    @GetMapping
    public ResponseEntity<List<InvoiceResponseDto>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }
}
