package com.example.demo.sales.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import com.example.demo.Sales.entity.Customer;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, UUID> {

    // Buscar por person_id
    Optional<Customer> findByPersonId(UUID personId);

    // Buscar por nombre o apellido de la persona
    @Query("SELECT c FROM Customer c WHERE " +
           "LOWER(c.person.firstName) LIKE LOWER(CONCAT('%', :name, '%')) OR " +
           "LOWER(c.person.lastName)  LIKE LOWER(CONCAT('%', :name, '%'))")
    List<Customer> findByPersonName(@Param("name") String name);

    // Buscar por número de documento
    @Query("SELECT c FROM Customer c WHERE c.person.documentNumber = :documentNumber")
    Optional<Customer> findByDocumentNumber(@Param("documentNumber") String documentNumber);

    // Listar solo activos
    List<Customer> findByStatusTrue();

    // Verificar si ya existe cliente para la persona
    boolean existsByPersonId(UUID personId);
}
