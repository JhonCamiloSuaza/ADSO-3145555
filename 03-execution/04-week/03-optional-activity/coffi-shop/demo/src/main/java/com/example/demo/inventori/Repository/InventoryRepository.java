package com.example.demo.Inventory.repository;

import com.example.demo.Inventory.entity.Inventory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface InventoryRepository extends JpaRepository<Inventory, UUID> {

    // Buscar por producto
    Optional<Inventory> findByProductId(UUID productId);

    // Listar productos con stock por debajo del mínimo (alerta)
    @Query("SELECT i FROM Inventory i WHERE i.quantity < i.minStock AND i.status = true")
    List<Inventory> findBelowMinStock();

    // Listar solo activos
    List<Inventory> findByStatusTrue();

    // Verificar si ya existe inventario para el producto
    boolean existsByProductId(UUID productId);
}
