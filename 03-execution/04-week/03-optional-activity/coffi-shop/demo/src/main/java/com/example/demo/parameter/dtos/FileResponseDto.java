package com.example.demo.parameter.dtos;

import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FileResponseDto {

    private UUID id;
    private UUID personId;
    private String personFullName;
    private String fileName;
    private String filePath;
    private String fileType;
    private Long fileSize;
    private Boolean status;
}
