package com.example.demo.security.dtos;

import jakarta.validation.constraints.NotNull;
import lombok.*;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class UserRoleRequestDto {
    @NotNull(message = "El usuario es obligatorio")
    private UUID userId;
    @NotNull(message = "El rol es obligatorio")
    private UUID roleId;
}
