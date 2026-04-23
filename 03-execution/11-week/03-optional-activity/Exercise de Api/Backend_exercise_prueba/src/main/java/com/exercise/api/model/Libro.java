package com.exercise.api.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.time.LocalDate;
import java.util.UUID;

/**
 * Entidad Primaria: Libro
 * Representa un libro del catálogo de la biblioteca.
 */
@Entity
@Table(name = "libro")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Libro {

    /** Identificador único del libro (UUID generado automáticamente) */
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    /** Título del libro */
    @NotBlank(message = "El título es obligatorio")
    @Size(max = 200, message = "El título no puede exceder 200 caracteres")
    @Column(name = "titulo", nullable = false, length = 200)
    private String titulo;

    /** Autor del libro */
    @NotBlank(message = "El autor es obligatorio")
    @Size(max = 150, message = "El autor no puede exceder 150 caracteres")
    @Column(name = "autor", nullable = false, length = 150)
    private String autor;

    /** Código ISBN único del libro */
    @NotBlank(message = "El ISBN es obligatorio")
    @Size(max = 20, message = "El ISBN no puede exceder 20 caracteres")
    @Column(name = "isbn", nullable = false, unique = true, length = 20)
    private String isbn;

    /** Género literario */
    @Size(max = 80, message = "El género no puede exceder 80 caracteres")
    @Column(name = "genero", length = 80)
    private String genero;

    /** Fecha de publicación del libro */
    @Column(name = "fecha_publicacion")
    private LocalDate fechaPublicacion;

    /** Indica si el libro está disponible para préstamo */
    @Column(name = "disponible", nullable = false)
    private Boolean disponible;

    /** Asignar valores por defecto antes de persistir */
    @PrePersist
    protected void onCreate() {
        if (this.disponible == null) {
            this.disponible = true;
        }
    }
}
