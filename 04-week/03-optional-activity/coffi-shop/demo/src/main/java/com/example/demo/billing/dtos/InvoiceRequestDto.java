package com.example.demo.Billing.dto;

import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InvoiceRequestDto {

    @NotNull(message = "La orden es obligatoria")
    private UUID orderId;

    @NotNull(message = "El cliente es obligatorio")
    private UUID customerId;

    private String invoiceStatus;
}
