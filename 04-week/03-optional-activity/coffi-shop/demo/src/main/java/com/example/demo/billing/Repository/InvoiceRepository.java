package com.example.demo.Billing.repository;

import com.example.demo.Billing.entity.Invoice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface InvoiceRepository extends JpaRepository<Invoice, UUID> {

    // Buscar por orden
    Optional<Invoice> findByOrderId(UUID orderId);

    // Buscar por cliente
    List<Invoice> findByCustomerId(UUID customerId);

    // Buscar por estado
    List<Invoice> findByInvoiceStatus(String invoiceStatus);

    // Listar solo activas
    List<Invoice> findByStatusTrue();

    // Verificar si ya existe factura para la orden
    boolean existsByOrderId(UUID orderId);
}
