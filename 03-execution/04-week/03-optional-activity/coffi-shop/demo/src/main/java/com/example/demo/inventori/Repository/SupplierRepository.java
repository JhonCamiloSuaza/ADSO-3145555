package com.example.demo.Inventory.repository;

import com.example.demo.Inventory.entity.Supplier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface SupplierRepository extends JpaRepository<Supplier, UUID> {

    // Buscar por nombre de empresa (ignorando mayúsculas)
    List<Supplier> findByCompanyContainingIgnoreCase(String company);

    // Buscar por nombre o apellido de la persona
    @Query("SELECT s FROM Supplier s WHERE " +
           "LOWER(s.person.firstName) LIKE LOWER(CONCAT('%', :name, '%')) OR " +
           "LOWER(s.person.lastName)  LIKE LOWER(CONCAT('%', :name, '%'))")
    List<Supplier> findByPersonName(@Param("name") String name);

    // Buscar por person_id
    List<Supplier> findByPersonId(UUID personId);

    // Listar solo activos
    List<Supplier> findByStatusTrue();
}
