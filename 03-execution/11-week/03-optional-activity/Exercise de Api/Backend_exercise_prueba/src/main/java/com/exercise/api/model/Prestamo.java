package com.exercise.api.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Entidad Secundaria: Prestamo
 * Representa la relación entre un Usuario y un Libro.
 * Contiene las claves foráneas (FK) a ambas entidades primarias.
 */
@Entity
@Table(name = "prestamo")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Prestamo {

    /** Identificador único del préstamo (UUID generado automáticamente) */
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    /** Usuario que solicita el préstamo (FK) */
    @NotNull(message = "El usuario es obligatorio")
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "usuario_id", nullable = false,
                foreignKey = @ForeignKey(name = "fk_prestamo_usuario"))
    private Usuario usuario;

    /** Libro que se presta (FK) */
    @NotNull(message = "El libro es obligatorio")
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "libro_id", nullable = false,
                foreignKey = @ForeignKey(name = "fk_prestamo_libro"))
    private Libro libro;

    /** Fecha en que se realizó el préstamo */
    @Column(name = "fecha_prestamo", nullable = false)
    private LocalDateTime fechaPrestamo;

    /** Fecha de devolución del libro (null si aún no se devuelve) */
    @Column(name = "fecha_devolucion")
    private LocalDateTime fechaDevolucion;

    /** Estado del préstamo: ACTIVO, DEVUELTO, VENCIDO */
    @NotBlank(message = "El estado es obligatorio")
    @Size(max = 20, message = "El estado no puede exceder 20 caracteres")
    @Column(name = "estado", nullable = false, length = 20)
    private String estado;

    /** Asignar valores por defecto antes de persistir */
    @PrePersist
    protected void onCreate() {
        if (this.fechaPrestamo == null) {
            this.fechaPrestamo = LocalDateTime.now();
        }
        if (this.estado == null) {
            this.estado = "ACTIVO";
        }
    }
}
