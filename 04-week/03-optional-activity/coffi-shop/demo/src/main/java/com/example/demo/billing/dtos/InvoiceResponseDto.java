package com.example.demo.Billing.dto;

import lombok.*;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InvoiceResponseDto {

    private UUID id;
    private UUID orderId;
    private UUID customerId;
    private String customerFullName;
    private OffsetDateTime invoiceDate;
    private BigDecimal total;
    private String invoiceStatus;
    private Boolean status;
}
