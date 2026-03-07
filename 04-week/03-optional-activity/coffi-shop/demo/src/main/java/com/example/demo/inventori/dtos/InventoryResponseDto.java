package com.example.demo.Inventory.dto;

import lombok.*;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InventoryResponseDto {

    private UUID id;
    private UUID productId;
    private String productName;
    private String categoryName;
    private BigDecimal quantity;
    private BigDecimal minStock;
    private BigDecimal maxStock;
    private Boolean belowMinStock;   // alerta si está por debajo del mínimo
    private OffsetDateTime lastUpdated;
    private Boolean status;
}
