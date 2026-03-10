package com.example.demo.Inventory.repository;

import com.example.demo.Inventory.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface CategoryRepository extends JpaRepository<Category, UUID> {

    // Buscar por nombre exacto
    Optional<Category> findByName(String name);

    // Buscar por nombre (ignorando mayúsculas)
    List<Category> findByNameContainingIgnoreCase(String name);

    // Listar solo activos
    List<Category> findByStatusTrue();

    // Verificar si ya existe el nombre
    boolean existsByName(String name);
}
