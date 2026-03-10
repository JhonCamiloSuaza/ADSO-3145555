package com.example.demo.parameter.dtos;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FileRequestDto {

    @NotNull(message = "La persona es obligatoria")
    private UUID personId;

    @NotBlank(message = "El nombre del archivo es obligatorio")
    private String fileName;

    @NotBlank(message = "La ruta del archivo es obligatoria")
    private String filePath;

    private String fileType;
    private Long fileSize;
}
