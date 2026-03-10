package com.example.demo.Billing.controller;

import com.example.demo.Billing.dto.InvoiceItemRequestDto;
import com.example.demo.Billing.dto.InvoiceItemResponseDto;
import com.example.demo.Billing.service.InvoiceItemService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/invoice-item")
@RequiredArgsConstructor
public class InvoiceItemController {

    private final InvoiceItemService service;

    @PostMapping
    public ResponseEntity<InvoiceItemResponseDto> save(@Valid @RequestBody InvoiceItemRequestDto request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<InvoiceItemResponseDto> update(
            @PathVariable UUID id,
            @Valid @RequestBody InvoiceItemRequestDto request) {
        return ResponseEntity.ok(service.update(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<InvoiceItemResponseDto> findById(@PathVariable UUID id) {
        return ResponseEntity.ok(service.findById(id));
    }

    @GetMapping("/invoice/{invoiceId}")
    public ResponseEntity<List<InvoiceItemResponseDto>> findByInvoiceId(@PathVariable UUID invoiceId) {
        return ResponseEntity.ok(service.findByInvoiceId(invoiceId));
    }

    @GetMapping("/product/{productId}")
    public ResponseEntity<List<InvoiceItemResponseDto>> findByProductId(@PathVariable UUID productId) {
        return ResponseEntity.ok(service.findByProductId(productId));
    }

    @GetMapping("/active")
    public ResponseEntity<List<InvoiceItemResponseDto>> findAllActive() {
        return ResponseEntity.ok(service.findAllActive());
    }

    @GetMapping
    public ResponseEntity<List<InvoiceItemResponseDto>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }
}
