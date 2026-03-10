package com.example.demo.Inventory.dto;

import jakarta.validation.constraints.*;
import lombok.*;

import java.math.BigDecimal;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductRequestDto {

    @NotNull(message = "La categoría es obligatoria")
    private UUID categoryId;

    private UUID supplierId;

    @NotBlank(message = "El nombre es obligatorio")
    @Size(max = 120, message = "El nombre no puede superar 120 caracteres")
    private String name;

    @NotNull(message = "El precio es obligatorio")
    @DecimalMin(value = "0.0", message = "El precio no puede ser negativo")
    private BigDecimal unitPrice;

    @NotBlank(message = "La unidad es obligatoria")
    private String unit;

    private String imageUrl;
}
