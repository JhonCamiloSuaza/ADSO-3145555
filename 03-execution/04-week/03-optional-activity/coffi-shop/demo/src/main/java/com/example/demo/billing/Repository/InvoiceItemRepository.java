package com.example.demo.billing.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface InvoiceItemRepository extends JpaRepository<InvoiceItem, UUID> {

    // Buscar items por factura
    List<InvoiceItem> findByInvoiceId(UUID invoiceId);

    // Buscar items por producto
    List<InvoiceItem> findByProductId(UUID productId);

    // Listar solo activos
    List<InvoiceItem> findByStatusTrue();

    // Verificar si ya existe el producto en la factura
    boolean existsByInvoiceIdAndProductId(UUID invoiceId, UUID productId);
}
