package com.example.demo.security.dtos;

import lombok.*;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class RoleModuleResponseDto {
    private UUID id;
    private UUID roleId;
    private String roleName;
    private UUID moduleId;
    private String moduleName;
    private Boolean status;
}
