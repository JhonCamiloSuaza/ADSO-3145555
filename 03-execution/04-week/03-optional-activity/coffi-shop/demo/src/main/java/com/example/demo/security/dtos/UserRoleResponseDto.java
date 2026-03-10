package com.example.demo.security.dtos;

import lombok.*;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class UserRoleResponseDto {
    private UUID id;
    private UUID userId;
    private String username;
    private UUID roleId;
    private String roleName;
    private Boolean status;
}
