package com.example.demo.Inventory.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SupplierRequestDto {

    @NotNull(message = "La persona es obligatoria")
    private UUID personId;

    @Size(max = 120, message = "El nombre de la empresa no puede superar 120 caracteres")
    private String company;
}
