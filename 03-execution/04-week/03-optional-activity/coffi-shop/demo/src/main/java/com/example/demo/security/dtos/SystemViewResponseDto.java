package com.example.demo.security.dtos;

import lombok.*;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class SystemViewResponseDto {
    private UUID id;
    private String name;
    private String route;
    private String description;
    private Boolean status;
}
