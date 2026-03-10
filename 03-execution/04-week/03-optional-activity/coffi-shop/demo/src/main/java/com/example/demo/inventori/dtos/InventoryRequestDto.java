package com.example.demo.Inventory.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.math.BigDecimal;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InventoryRequestDto {

    @NotNull(message = "El producto es obligatorio")
    private UUID productId;

    @NotNull(message = "La cantidad es obligatoria")
    @DecimalMin(value = "0.0", message = "La cantidad no puede ser negativa")
    private BigDecimal quantity;

    @NotNull(message = "El stock mínimo es obligatorio")
    @DecimalMin(value = "0.0", message = "El stock mínimo no puede ser negativo")
    private BigDecimal minStock;

    @DecimalMin(value = "0.0", message = "El stock máximo no puede ser negativo")
    private BigDecimal maxStock;
}
