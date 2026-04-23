package com.exercise.api.mapper;

import com.exercise.api.dto.UsuarioDTO;
import com.exercise.api.model.Usuario;
import org.springframework.stereotype.Component;

@Component
public class UsuarioMapper {
    public UsuarioDTO toDTO(Usuario entity) {
        if (entity == null) return null;
        return UsuarioDTO.builder()
                .id(entity.getId())
                .nombre(entity.getNombre())
                .apellido(entity.getApellido())
                .email(entity.getEmail())
                .telefono(entity.getTelefono())
                .fechaRegistro(entity.getFechaRegistro())
                .activo(entity.getActivo())
                .build();
    }

    public Usuario toEntity(UsuarioDTO dto) {
        if (dto == null) return null;
        return Usuario.builder()
                .id(dto.getId())
                .nombre(dto.getNombre())
                .apellido(dto.getApellido())
                .email(dto.getEmail())
                .telefono(dto.getTelefono())
                .fechaRegistro(dto.getFechaRegistro())
                .activo(dto.getActivo())
                .build();
    }
}
