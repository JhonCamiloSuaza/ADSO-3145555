package com.example.demo.Inventory.dto;

import lombok.*;

import java.math.BigDecimal;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductResponseDto {

    private UUID id;
    private String categoryName;
    private String supplierCompany;
    private String name;
    private BigDecimal unitPrice;
    private String unit;
    private String imageUrl;
    private Boolean status;
}
