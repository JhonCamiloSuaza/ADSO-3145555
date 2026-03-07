package com.example.demo.security.dtos;

import lombok.*;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ModuleResponseDto {
    private UUID id;
    private String name;
    private String description;
    private String icon;
    private String route;
    private Integer sortOrder;
    private Boolean status;
}
