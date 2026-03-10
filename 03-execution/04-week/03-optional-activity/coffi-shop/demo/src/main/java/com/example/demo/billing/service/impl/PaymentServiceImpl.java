package com.example.demo.Billing.impl;

import com.example.demo.Billing.dto.PaymentRequestDto;
import com.example.demo.Billing.dto.PaymentResponseDto;
import com.example.demo.Billing.entity.Invoice;
import com.example.demo.Billing.entity.Payment;
import com.example.demo.Billing.repository.InvoiceRepository;
import com.example.demo.Billing.repository.PaymentRepository;
import com.example.demo.Billing.service.PaymentService;
import com.example.demo.Method_payment.entity.MethodPayment;
import com.example.demo.Method_payment.repository.MethodPaymentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PaymentServiceImpl implements PaymentService {

    private final PaymentRepository paymentRepository;
    private final InvoiceRepository invoiceRepository;
    private final MethodPaymentRepository methodPaymentRepository;

    @Override
    public PaymentResponseDto save(PaymentRequestDto request) {
        Invoice invoice = findInvoiceById(request.getInvoiceId());
        MethodPayment methodPayment = findMethodPaymentById(request.getMethodPaymentId());

        Payment entity = Payment.builder()
                .invoice(invoice)
                .methodPayment(methodPayment)
                .amount(request.getAmount())
                .paymentDate(OffsetDateTime.now())
                .status(true)
                .build();
        return toResponse(paymentRepository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        Payment entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        paymentRepository.save(entity);
    }

    @Override
    public PaymentResponseDto findById(UUID id) {
        return toResponse(findEntityById(id));
    }

    @Override
    public List<PaymentResponseDto> findByInvoiceId(UUID invoiceId) {
        return paymentRepository.findByInvoiceId(invoiceId)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<PaymentResponseDto> findByMethodPaymentId(UUID methodPaymentId) {
        return paymentRepository.findByMethodPaymentId(methodPaymentId)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<PaymentResponseDto> findAllActive() {
        return paymentRepository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<PaymentResponseDto> findAll() {
        return paymentRepository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private Payment findEntityById(UUID id) {
        return paymentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Pago no encontrado con ID: " + id));
    }

    private Invoice findInvoiceById(UUID id) {
        return invoiceRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Factura no encontrada con ID: " + id));
    }

    private MethodPayment findMethodPaymentById(UUID id) {
        return methodPaymentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Método de pago no encontrado con ID: " + id));
    }

    private PaymentResponseDto toResponse(Payment entity) {
        return PaymentResponseDto.builder()
                .id(entity.getId())
                .invoiceId(entity.getInvoice().getId())
                .methodPaymentName(entity.getMethodPayment().getName())
                .amount(entity.getAmount())
                .paymentDate(entity.getPaymentDate())
                .status(entity.getStatus())
                .build();
    }
}
