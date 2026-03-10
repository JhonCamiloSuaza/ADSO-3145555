package com.example.demo.Billing.dto;

import lombok.*;

import java.math.BigDecimal;
<parameter name="file_text">import java.time.OffsetDateTime;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PaymentResponseDto {

    private UUID id;
    private UUID invoiceId;
    private String methodPaymentName;
    private BigDecimal amount;
    private OffsetDateTime paymentDate;
    private Boolean status;
}
