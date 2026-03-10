package com.example.demo.parameter.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import com.example.demo.parameter.entity.TypeDocument;

@Repository
public interface TypeDocumentRepository extends JpaRepository<TypeDocument, UUID> {

    // Buscar por código
    Optional<TypeDocument> findByCode(String code);

    // Buscar por nombre (ignorando mayúsculas)
    List<TypeDocument> findByNameContainingIgnoreCase(String name);

    // Listar solo los activos
    List<TypeDocument> findByStatusTrue();

    // Verificar si ya existe el código
    boolean existsByCode(String code);
}
