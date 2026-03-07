package com.example.demo.sales.dtos;

import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderRequestDto {

    @NotNull(message = "El cliente es obligatorio")
    private UUID customerId;

    @NotNull(message = "El método de pago es obligatorio")
    private UUID methodPaymentId;

    private String orderStatus;
}
