package com.example.demo.parameter.dtos;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TypeDocumentRequestDto {

    @NotBlank(message = "El nombre es obligatorio")
    @Size(max = 50, message = "El nombre no puede superar 50 caracteres")
    private String name;

    @NotBlank(message = "El código es obligatorio")
    @Size(max = 10, message = "El código no puede superar 10 caracteres")
    private String code;

    private String description;
}
