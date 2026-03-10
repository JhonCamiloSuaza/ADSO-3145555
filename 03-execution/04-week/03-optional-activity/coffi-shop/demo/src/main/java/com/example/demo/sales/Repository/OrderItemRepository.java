package com.example.demo.sales.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

import com.example.demo.sales.entity.OrderItem;

@Repository
public interface OrderItemRepository extends JpaRepository<OrderItem, UUID> {

    // Buscar items por orden
    List<OrderItem> findByOrderId(UUID orderId);

    // Buscar items por producto
    List<OrderItem> findByProductId(UUID productId);

    // Listar solo activos
    List<OrderItem> findByStatusTrue();

    // Verificar si ya existe el producto en la orden
    boolean existsByOrderIdAndProductId(UUID orderId, UUID productId);
}
