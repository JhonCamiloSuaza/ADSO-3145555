package com.example.demo.Method_payment.dto;

import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MethodPaymentResponseDto {

    private UUID id;
    private String name;
    private String description;
    private Boolean status;
}
