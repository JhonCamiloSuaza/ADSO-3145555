package com.example.demo.sales.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface OrderRepository extends JpaRepository<Order, UUID> {

    // Buscar órdenes por cliente
    List<Order> findByCustomerId(UUID customerId);

    // Buscar órdenes por método de pago
    List<Order> findByMethodPaymentId(UUID methodPaymentId);

    // Buscar órdenes por estado
    List<Order> findByOrderStatus(String orderStatus);

    // Listar solo activas
    List<Order> findByStatusTrue();
}
