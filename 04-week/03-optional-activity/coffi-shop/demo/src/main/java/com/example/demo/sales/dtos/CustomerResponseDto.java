package com.example.demo.sales.dtos;

import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CustomerResponseDto {

    private UUID id;
    private UUID personId;
    private String personFullName;
    private String documentNumber;
    private String phone;
    private String email;
    private Boolean status;
}
