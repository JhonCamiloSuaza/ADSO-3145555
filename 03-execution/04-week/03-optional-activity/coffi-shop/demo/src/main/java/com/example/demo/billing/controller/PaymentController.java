package com.example.demo.Billing.controller;

import com.example.demo.Billing.dto.PaymentRequestDto;
import com.example.demo.Billing.dto.PaymentResponseDto;
import com.example.demo.Billing.service.PaymentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/payment")
@RequiredArgsConstructor
public class PaymentController {

    private final PaymentService service;

    @PostMapping
    public ResponseEntity<PaymentResponseDto> save(@Valid @RequestBody PaymentRequestDto request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<PaymentResponseDto> findById(@PathVariable UUID id) {
        return ResponseEntity.ok(service.findById(id));
    }

    @GetMapping("/invoice/{invoiceId}")
    public ResponseEntity<List<PaymentResponseDto>> findByInvoiceId(@PathVariable UUID invoiceId) {
        return ResponseEntity.ok(service.findByInvoiceId(invoiceId));
    }

    @GetMapping("/method-payment/{methodPaymentId}")
    public ResponseEntity<List<PaymentResponseDto>> findByMethodPaymentId(@PathVariable UUID methodPaymentId) {
        return ResponseEntity.ok(service.findByMethodPaymentId(methodPaymentId));
    }

    @GetMapping("/active")
    public ResponseEntity<List<PaymentResponseDto>> findAllActive() {
        return ResponseEntity.ok(service.findAllActive());
    }

    @GetMapping
    public ResponseEntity<List<PaymentResponseDto>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }
}
