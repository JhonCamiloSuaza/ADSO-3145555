package com.exercise.api.repository;

import com.exercise.api.model.Libro;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

/**
 * Repositorio de Libro.
 * Extiende JpaRepository para operaciones CRUD automáticas.
 * Principio ISP: Interfaz específica para la entidad Libro.
 */
@Repository
public interface LibroRepository extends JpaRepository<Libro, UUID> {

    /**
     * Buscar libro por ISBN.
     * @param isbn código ISBN del libro
     * @return Optional con el libro encontrado
     */
    Optional<Libro> findByIsbn(String isbn);

    /**
     * Verificar si existe un libro con un ISBN dado.
     * @param isbn código ISBN a verificar
     * @return true si existe
     */
    boolean existsByIsbn(String isbn);
}
