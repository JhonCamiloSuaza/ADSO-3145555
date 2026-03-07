package com.example.demo.security.dtos;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class UserRequestDto {
    @NotNull(message = "La persona es obligatoria")
    private UUID personId;
    @NotBlank(message = "El username es obligatorio")
    @Size(max = 60)
    private String username;
    @NotBlank(message = "La contraseña es obligatoria")
    private String password;
}
