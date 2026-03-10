package com.example.demo.security.dtos;

import lombok.*;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ModuleViewResponseDto {
    private UUID id;
    private UUID moduleId;
    private String moduleName;
    private UUID systemViewId;
    private String systemViewName;
    private Boolean status;
}
