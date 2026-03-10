package com.example.demo.Billing.impl;

import com.example.demo.Billing.dto.InvoiceItemRequestDto;
import com.example.demo.Billing.dto.InvoiceItemResponseDto;
import com.example.demo.Billing.entity.Invoice;
import com.example.demo.Billing.entity.InvoiceItem;
import com.example.demo.Billing.repository.InvoiceItemRepository;
import com.example.demo.Billing.repository.InvoiceRepository;
import com.example.demo.Billing.service.InvoiceItemService;
import com.example.demo.Inventory.entity.Product;
import com.example.demo.Inventory.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class InvoiceItemServiceImpl implements InvoiceItemService {

    private final InvoiceItemRepository invoiceItemRepository;
    private final InvoiceRepository invoiceRepository;
    private final ProductRepository productRepository;

    @Override
    public InvoiceItemResponseDto save(InvoiceItemRequestDto request) {
        if (invoiceItemRepository.existsByInvoiceIdAndProductId(request.getInvoiceId(), request.getProductId()))
            throw new RuntimeException("El producto ya existe en esta factura");

        Invoice invoice = findInvoiceById(request.getInvoiceId());
        Product product = findProductById(request.getProductId());

        InvoiceItem entity = InvoiceItem.builder()
                .invoice(invoice)
                .product(product)
                .quantity(request.getQuantity())
                .unitPrice(request.getUnitPrice())
                .status(true)
                .build();
        return toResponse(invoiceItemRepository.save(entity));
    }

    @Override
    public InvoiceItemResponseDto update(UUID id, InvoiceItemRequestDto request) {
        InvoiceItem entity = findEntityById(id);
        entity.setQuantity(request.getQuantity());
        entity.setUnitPrice(request.getUnitPrice());
        return toResponse(invoiceItemRepository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        InvoiceItem entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        invoiceItemRepository.save(entity);
    }

    @Override
    public InvoiceItemResponseDto findById(UUID id) {
        return toResponse(findEntityById(id));
    }

    @Override
    public List<InvoiceItemResponseDto> findByInvoiceId(UUID invoiceId) {
        return invoiceItemRepository.findByInvoiceId(invoiceId)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<InvoiceItemResponseDto> findByProductId(UUID productId) {
        return invoiceItemRepository.findByProductId(productId)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<InvoiceItemResponseDto> findAllActive() {
        return invoiceItemRepository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<InvoiceItemResponseDto> findAll() {
        return invoiceItemRepository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private InvoiceItem findEntityById(UUID id) {
        return invoiceItemRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Item de factura no encontrado con ID: " + id));
    }

    private Invoice findInvoiceById(UUID id) {
        return invoiceRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Factura no encontrada con ID: " + id));
    }

    private Product findProductById(UUID id) {
        return productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Producto no encontrado con ID: " + id));
    }

    private InvoiceItemResponseDto toResponse(InvoiceItem entity) {
        return InvoiceItemResponseDto.builder()
                .id(entity.getId())
                .invoiceId(entity.getInvoice().getId())
                .productId(entity.getProduct().getId())
                .productName(entity.getProduct().getName())
                .quantity(entity.getQuantity())
                .unitPrice(entity.getUnitPrice())
                .subtotal(entity.getSubtotal())
                .status(entity.getStatus())
                .build();
    }
}
