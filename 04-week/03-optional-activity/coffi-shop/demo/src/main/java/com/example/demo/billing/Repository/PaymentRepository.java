package com.example.demo.Billing.repository;

import com.example.demo.Billing.entity.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, UUID> {

    // Buscar pagos por factura
    List<Payment> findByInvoiceId(UUID invoiceId);

    // Buscar pagos por método de pago
    List<Payment> findByMethodPaymentId(UUID methodPaymentId);

    // Listar solo activos
    List<Payment> findByStatusTrue();
}
