package com.example.demo.sales.dtos;

import lombok.*;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderResponseDto {

    private UUID id;
    private String customerFullName;
    private String methodPaymentName;
    private OffsetDateTime orderDate;
    private BigDecimal total;
    private String orderStatus;
    private Boolean status;
}
