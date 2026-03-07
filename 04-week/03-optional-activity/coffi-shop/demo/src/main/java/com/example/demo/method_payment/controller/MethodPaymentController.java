package com.example.demo.Method_payment.controller;

import com.example.demo.Method_payment.dto.MethodPaymentRequestDto;
import com.example.demo.Method_payment.dto.MethodPaymentResponseDto;
import com.example.demo.Method_payment.service.MethodPaymentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/method-payment")
@RequiredArgsConstructor
public class MethodPaymentController {

    private final MethodPaymentService service;

    @PostMapping
    public ResponseEntity<MethodPaymentResponseDto> save(@Valid @RequestBody MethodPaymentRequestDto request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<MethodPaymentResponseDto> update(
            @PathVariable UUID id,
            @Valid @RequestBody MethodPaymentRequestDto request) {
        return ResponseEntity.ok(service.update(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<MethodPaymentResponseDto> findById(@PathVariable UUID id) {
        return ResponseEntity.ok(service.findById(id));
    }

    @GetMapping("/search")
    public ResponseEntity<List<MethodPaymentResponseDto>> findByName(@RequestParam String name) {
        return ResponseEntity.ok(service.findByName(name));
    }

    @GetMapping("/active")
    public ResponseEntity<List<MethodPaymentResponseDto>> findAllActive() {
        return ResponseEntity.ok(service.findAllActive());
    }

    @GetMapping
    public ResponseEntity<List<MethodPaymentResponseDto>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }
}
