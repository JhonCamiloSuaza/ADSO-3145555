package com.example.demo.Inventory.repository;

import com.example.demo.Inventory.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface ProductRepository extends JpaRepository<Product, UUID> {

    // Buscar por nombre (ignorando mayúsculas)
    List<Product> findByNameContainingIgnoreCase(String name);

    // Buscar por categoría
    List<Product> findByCategoryId(UUID categoryId);

    // Buscar por proveedor
    List<Product> findBySupplierId(UUID supplierId);

    // Buscar por unidad
    List<Product> findByUnit(String unit);

    // Listar solo activos
    List<Product> findByStatusTrue();

    // Verificar si ya existe el nombre
    boolean existsByName(String name);
}
