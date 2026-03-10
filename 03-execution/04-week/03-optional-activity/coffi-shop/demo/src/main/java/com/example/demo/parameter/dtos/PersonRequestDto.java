package com.example.demo.parameter.dtos;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PersonRequestDto {

    @NotNull(message = "El tipo de documento es obligatorio")
    private UUID typeDocumentId;

    @NotBlank(message = "El número de documento es obligatorio")
    @Size(max = 20, message = "El número de documento no puede superar 20 caracteres")
    private String documentNumber;

    @NotBlank(message = "El nombre es obligatorio")
    @Size(max = 80, message = "El nombre no puede superar 80 caracteres")
    private String firstName;

    @NotBlank(message = "El apellido es obligatorio")
    @Size(max = 80, message = "El apellido no puede superar 80 caracteres")
    private String lastName;

    @Size(max = 20, message = "El teléfono no puede superar 20 caracteres")
    private String phone;

    @Email(message = "El email no tiene un formato válido")
    @Size(max = 120, message = "El email no puede superar 120 caracteres")
    private String email;
}
