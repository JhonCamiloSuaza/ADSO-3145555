package com.example.demo.security.dtos;

import lombok.*;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class UserResponseDto {
    private UUID id;
    private UUID personId;
    private String personFullName;
    private String username;
    private Boolean status;
}
