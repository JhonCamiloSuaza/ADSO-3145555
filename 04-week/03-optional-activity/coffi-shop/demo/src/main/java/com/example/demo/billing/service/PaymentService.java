package com.example.demo.Billing.service;

import com.example.demo.Billing.dto.PaymentRequestDto;
import com.example.demo.Billing.dto.PaymentResponseDto;

import java.util.List;
import java.util.UUID;

public interface PaymentService {

    PaymentResponseDto save(PaymentRequestDto request);
    void delete(UUID id);
    PaymentResponseDto findById(UUID id);
    List<PaymentResponseDto> findByInvoiceId(UUID invoiceId);
    List<PaymentResponseDto> findByMethodPaymentId(UUID methodPaymentId);
    List<PaymentResponseDto> findAllActive();
    List<PaymentResponseDto> findAll();
}
