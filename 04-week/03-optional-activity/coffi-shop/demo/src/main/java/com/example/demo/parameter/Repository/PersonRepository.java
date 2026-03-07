package com.example.demo.parameter.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import com.example.demo.parameter.entity.Person;

@Repository
public interface PersonRepository extends JpaRepository<Person, UUID> {

    // Buscar por número de documento
    Optional<Person> findByDocumentNumber(String documentNumber);

    // Buscar por email
    Optional<Person> findByEmail(String email);

    // Buscar por nombre o apellido (ignorando mayúsculas)
    List<Person> findByFirstNameContainingIgnoreCaseOrLastNameContainingIgnoreCase(
            String firstName, String lastName);

    // Listar solo los activos
    List<Person> findByStatusTrue();

    // Verificar si ya existe el documento
    boolean existsByDocumentNumber(String documentNumber);

    // Verificar si ya existe el email
    boolean existsByEmail(String email);

    // Buscar por tipo de documento
    @Query("SELECT p FROM Person p WHERE p.typeDocument.id = :typeDocumentId AND p.status = true")
    List<Person> findByTypeDocumentId(@Param("typeDocumentId") UUID typeDocumentId);
}
