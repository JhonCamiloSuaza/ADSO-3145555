package com.example.demo.Inventory.dto;

import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SupplierResponseDto {

    private UUID id;
    private UUID personId;
    private String personFullName;
    private String documentNumber;
    private String phone;
    private String email;
    private String company;
    private Boolean status;
}
