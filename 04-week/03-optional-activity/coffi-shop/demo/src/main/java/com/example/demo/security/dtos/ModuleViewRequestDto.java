package com.example.demo.security.dtos;

import jakarta.validation.constraints.NotNull;
import lombok.*;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ModuleViewRequestDto {
    @NotNull(message = "El módulo es obligatorio")
    private UUID moduleId;
    @NotNull(message = "La vista es obligatoria")
    private UUID systemViewId;
}
