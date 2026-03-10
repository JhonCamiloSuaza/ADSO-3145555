package com.example.demo.security.dtos;

import jakarta.validation.constraints.NotNull;
import lombok.*;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class RoleModuleRequestDto {
    @NotNull(message = "El rol es obligatorio")
    private UUID roleId;
    @NotNull(message = "El módulo es obligatorio")
    private UUID moduleId;
}
