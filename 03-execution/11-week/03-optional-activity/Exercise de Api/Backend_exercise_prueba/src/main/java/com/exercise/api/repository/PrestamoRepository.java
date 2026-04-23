package com.exercise.api.repository;

import com.exercise.api.model.Prestamo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

/**
 * Repositorio de Prestamo.
 * Extiende JpaRepository para operaciones CRUD automáticas.
 * Principio ISP: Interfaz específica para la entidad Prestamo.
 */
@Repository
public interface PrestamoRepository extends JpaRepository<Prestamo, UUID> {

    /**
     * Buscar préstamos por ID de usuario.
     * @param usuarioId ID del usuario
     * @return lista de préstamos del usuario
     */
    List<Prestamo> findByUsuarioId(UUID usuarioId);

    /**
     * Buscar préstamos por ID de libro.
     * @param libroId ID del libro
     * @return lista de préstamos del libro
     */
    List<Prestamo> findByLibroId(UUID libroId);

    /**
     * Buscar préstamos por estado.
     * @param estado estado del préstamo (ACTIVO, DEVUELTO, VENCIDO)
     * @return lista de préstamos con el estado dado
     */
    List<Prestamo> findByEstado(String estado);
}
