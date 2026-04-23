package com.exercise.api.mapper;

import com.exercise.api.dto.PrestamoDTO;
import com.exercise.api.model.Prestamo;
import org.springframework.stereotype.Component;

@Component
public class PrestamoMapper {
    private final UsuarioMapper usuarioMapper;
    private final LibroMapper libroMapper;

    public PrestamoMapper(UsuarioMapper usuarioMapper, LibroMapper libroMapper) {
        this.usuarioMapper = usuarioMapper;
        this.libroMapper = libroMapper;
    }

    public PrestamoDTO toDTO(Prestamo entity) {
        if (entity == null) return null;
        return PrestamoDTO.builder()
                .id(entity.getId())
                .usuario(usuarioMapper.toDTO(entity.getUsuario()))
                .libro(libroMapper.toDTO(entity.getLibro()))
                .fechaPrestamo(entity.getFechaPrestamo())
                .fechaDevolucion(entity.getFechaDevolucion())
                .estado(entity.getEstado())
                .build();
    }

    public Prestamo toEntity(PrestamoDTO dto) {
        if (dto == null) return null;
        return Prestamo.builder()
                .id(dto.getId())
                .usuario(usuarioMapper.toEntity(dto.getUsuario()))
                .libro(libroMapper.toEntity(dto.getLibro()))
                .fechaPrestamo(dto.getFechaPrestamo())
                .fechaDevolucion(dto.getFechaDevolucion())
                .estado(dto.getEstado())
                .build();
    }
}
