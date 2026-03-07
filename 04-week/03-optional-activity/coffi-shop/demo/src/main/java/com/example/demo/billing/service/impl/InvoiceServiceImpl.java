package com.example.demo.Billing.impl;

import com.example.demo.Billing.dto.InvoiceRequestDto;
import com.example.demo.Billing.dto.InvoiceResponseDto;
import com.example.demo.Billing.entity.Invoice;
import com.example.demo.Billing.repository.InvoiceRepository;
import com.example.demo.Billing.service.InvoiceService;
import com.example.demo.Sales.entity.Customer;
import com.example.demo.Sales.entity.Order;
import com.example.demo.Sales.repository.CustomerRepository;
import com.example.demo.Sales.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class InvoiceServiceImpl implements InvoiceService {

    private final InvoiceRepository invoiceRepository;
    private final OrderRepository orderRepository;
    private final CustomerRepository customerRepository;

    @Override
    public InvoiceResponseDto save(InvoiceRequestDto request) {
        if (invoiceRepository.existsByOrderId(request.getOrderId()))
            throw new RuntimeException("Ya existe una factura para la orden con ID: " + request.getOrderId());

        Order order = findOrderById(request.getOrderId());
        Customer customer = findCustomerById(request.getCustomerId());

        Invoice entity = Invoice.builder()
                .order(order)
                .customer(customer)
                .invoiceDate(OffsetDateTime.now())
                .total(order.getTotal())
                .invoiceStatus(request.getInvoiceStatus() != null ? request.getInvoiceStatus() : "pending")
                .status(true)
                .build();
        return toResponse(invoiceRepository.save(entity));
    }

    @Override
    public InvoiceResponseDto update(UUID id, InvoiceRequestDto request) {
        Invoice entity = findEntityById(id);
        if (request.getInvoiceStatus() != null)
            entity.setInvoiceStatus(request.getInvoiceStatus());
        return toResponse(invoiceRepository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        Invoice entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        invoiceRepository.save(entity);
    }

    @Override
    public InvoiceResponseDto findById(UUID id) {
        return toResponse(findEntityById(id));
    }

    @Override
    public InvoiceResponseDto findByOrderId(UUID orderId) {
        return invoiceRepository.findByOrderId(orderId)
                .map(this::toResponse)
                .orElseThrow(() -> new RuntimeException("Factura no encontrada para la orden con ID: " + orderId));
    }

    @Override
    public List<InvoiceResponseDto> findByCustomerId(UUID customerId) {
        return invoiceRepository.findByCustomerId(customerId)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<InvoiceResponseDto> findByInvoiceStatus(String invoiceStatus) {
        return invoiceRepository.findByInvoiceStatus(invoiceStatus)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<InvoiceResponseDto> findAllActive() {
        return invoiceRepository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<InvoiceResponseDto> findAll() {
        return invoiceRepository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private Invoice findEntityById(UUID id) {
        return invoiceRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Factura no encontrada con ID: " + id));
    }

    private Order findOrderById(UUID id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Orden no encontrada con ID: " + id));
    }

    private Customer findCustomerById(UUID id) {
        return customerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Cliente no encontrado con ID: " + id));
    }

    private InvoiceResponseDto toResponse(Invoice entity) {
        return InvoiceResponseDto.builder()
                .id(entity.getId())
                .orderId(entity.getOrder().getId())
                .customerId(entity.getCustomer().getId())
                .customerFullName(entity.getCustomer().getPerson().getFirstName() + " " + entity.getCustomer().getPerson().getLastName())
                .invoiceDate(entity.getInvoiceDate())
                .total(entity.getTotal())
                .invoiceStatus(entity.getInvoiceStatus())
                .status(entity.getStatus())
                .build();
    }
}
