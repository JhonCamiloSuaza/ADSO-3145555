package com.example.demo.parameter.dtos;

import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TypeDocumentResponseDto {

    private UUID id;
    private String name;
    private String code;
    private String description;
    private Boolean status;
}
