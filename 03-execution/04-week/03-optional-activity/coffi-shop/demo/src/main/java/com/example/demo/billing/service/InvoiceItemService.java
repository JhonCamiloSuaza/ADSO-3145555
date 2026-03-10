package com.example.demo.Billing.service;

import com.example.demo.Billing.dto.InvoiceItemRequestDto;
import com.example.demo.Billing.dto.InvoiceItemResponseDto;

import java.util.List;
import java.util.UUID;

public interface InvoiceItemService {

    InvoiceItemResponseDto save(InvoiceItemRequestDto request);
    InvoiceItemResponseDto update(UUID id, InvoiceItemRequestDto request);
    void delete(UUID id);
    InvoiceItemResponseDto findById(UUID id);
    List<InvoiceItemResponseDto> findByInvoiceId(UUID invoiceId);
    List<InvoiceItemResponseDto> findByProductId(UUID productId);
    List<InvoiceItemResponseDto> findAllActive();
    List<InvoiceItemResponseDto> findAll();
}
