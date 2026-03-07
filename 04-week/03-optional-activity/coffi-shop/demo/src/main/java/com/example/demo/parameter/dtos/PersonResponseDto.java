package com.example.demo.parameter.dtos;

import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PersonResponseDto {

    private UUID id;
    private String typeDocumentName;
    private String typeDocumentCode;
    private String documentNumber;
    private String firstName;
    private String lastName;
    private String phone;
    private String email;
    private Boolean status;
}
