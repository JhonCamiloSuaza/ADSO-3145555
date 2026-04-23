package com.exercise.api.repository;

import com.exercise.api.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

/**
 * Repositorio de Usuario.
 * Extiende JpaRepository para operaciones CRUD automáticas.
 * Principio ISP: Interfaz específica para la entidad Usuario.
 */
@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, UUID> {

    /**
     * Buscar usuario por email.
     * @param email correo electrónico del usuario
     * @return Optional con el usuario encontrado
     */
    Optional<Usuario> findByEmail(String email);

    /**
     * Verificar si existe un usuario con un email dado.
     * @param email correo electrónico a verificar
     * @return true si existe
     */
    boolean existsByEmail(String email);
}
