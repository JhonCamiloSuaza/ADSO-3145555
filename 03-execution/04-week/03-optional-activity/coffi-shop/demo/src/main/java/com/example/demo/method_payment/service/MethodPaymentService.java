package com.example.demo.Method_payment.service;

import com.example.demo.Method_payment.dto.MethodPaymentRequestDto;
import com.example.demo.Method_payment.dto.MethodPaymentResponseDto;

import java.util.List;
import java.util.UUID;

public interface MethodPaymentService {

    MethodPaymentResponseDto save(MethodPaymentRequestDto request);
    MethodPaymentResponseDto update(UUID id, MethodPaymentRequestDto request);
    void delete(UUID id);
    MethodPaymentResponseDto findById(UUID id);
    List<MethodPaymentResponseDto> findByName(String name);
    List<MethodPaymentResponseDto> findAllActive();
    List<MethodPaymentResponseDto> findAll();
}
