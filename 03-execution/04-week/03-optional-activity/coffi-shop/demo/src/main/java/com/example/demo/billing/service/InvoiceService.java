package com.example.demo.Billing.service;

import com.example.demo.Billing.dto.InvoiceRequestDto;
import com.example.demo.Billing.dto.InvoiceResponseDto;

import java.util.List;
import java.util.UUID;

public interface InvoiceService {

    InvoiceResponseDto save(InvoiceRequestDto request);
    InvoiceResponseDto update(UUID id, InvoiceRequestDto request);
    void delete(UUID id);
    InvoiceResponseDto findById(UUID id);
    InvoiceResponseDto findByOrderId(UUID orderId);
    List<InvoiceResponseDto> findByCustomerId(UUID customerId);
    List<InvoiceResponseDto> findByInvoiceStatus(String invoiceStatus);
    List<InvoiceResponseDto> findAllActive();
    List<InvoiceResponseDto> findAll();
}
