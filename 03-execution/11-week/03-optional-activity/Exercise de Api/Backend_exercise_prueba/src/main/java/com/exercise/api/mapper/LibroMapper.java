package com.exercise.api.mapper;

import com.exercise.api.dto.LibroDTO;
import com.exercise.api.model.Libro;
import org.springframework.stereotype.Component;

@Component
public class LibroMapper {
    public LibroDTO toDTO(Libro entity) {
        if (entity == null) return null;
        return LibroDTO.builder()
                .id(entity.getId())
                .titulo(entity.getTitulo())
                .autor(entity.getAutor())
                .isbn(entity.getIsbn())
                .genero(entity.getGenero())
                .fechaPublicacion(entity.getFechaPublicacion())
                .disponible(entity.getDisponible())
                .build();
    }

    public Libro toEntity(LibroDTO dto) {
        if (dto == null) return null;
        return Libro.builder()
                .id(dto.getId())
                .titulo(dto.getTitulo())
                .autor(dto.getAutor())
                .isbn(dto.getIsbn())
                .genero(dto.getGenero())
                .fechaPublicacion(dto.getFechaPublicacion())
                .disponible(dto.getDisponible())
                .build();
    }
}
