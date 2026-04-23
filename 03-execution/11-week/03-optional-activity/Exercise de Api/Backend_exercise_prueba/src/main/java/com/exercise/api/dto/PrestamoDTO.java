package com.exercise.api.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PrestamoDTO {
    private UUID id;

    @NotNull(message = "El usuario es obligatorio")
    private UsuarioDTO usuario;

    @NotNull(message = "El libro es obligatorio")
    private LibroDTO libro;

    private LocalDateTime fechaPrestamo;
    private LocalDateTime fechaDevolucion;

    @NotBlank(message = "El estado es obligatorio")
    @Size(max = 20, message = "El estado no puede exceder 20 caracteres")
    private String estado;
}
