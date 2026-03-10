package com.example.demo.Method_payment.repository;

import com.example.demo.Method_payment.entity.MethodPayment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface MethodPaymentRepository extends JpaRepository<MethodPayment, UUID> {

    // Buscar por nombre exacto
    Optional<MethodPayment> findByName(String name);

    // Buscar por nombre (ignorando mayúsculas)
    List<MethodPayment> findByNameContainingIgnoreCase(String name);

    // Listar solo activos
    List<MethodPayment> findByStatusTrue();

    // Verificar si ya existe el nombre
    boolean existsByName(String name);
}
