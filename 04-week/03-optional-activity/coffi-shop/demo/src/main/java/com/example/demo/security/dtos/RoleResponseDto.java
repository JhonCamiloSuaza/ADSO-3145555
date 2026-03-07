package com.example.demo.security.dtos;

import lombok.*;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class RoleResponseDto {
    private UUID id;
    private String name;
    private String description;
    private Boolean status;
}
