package com.exercise.api.service;

import com.exercise.api.dto.LibroDTO;
import com.exercise.api.exception.ResourceNotFoundException;
import com.exercise.api.mapper.LibroMapper;
import com.exercise.api.model.Libro;
import com.exercise.api.repository.LibroRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@Transactional
public class LibroService {

    private final LibroRepository libroRepository;
    private final LibroMapper libroMapper;

    public LibroService(LibroRepository libroRepository, LibroMapper libroMapper) {
        this.libroRepository = libroRepository;
        this.libroMapper = libroMapper;
    }

    @Transactional(readOnly = true)
    public List<LibroDTO> findAll() {
        return libroRepository.findAll().stream()
                .map(libroMapper::toDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public LibroDTO findById(UUID id) {
        Libro libro = libroRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Libro", id));
        return libroMapper.toDTO(libro);
    }

    public LibroDTO create(LibroDTO libroDTO) {
        Libro libro = libroMapper.toEntity(libroDTO);
        Libro saved = libroRepository.save(libro);
        return libroMapper.toDTO(saved);
    }

    public LibroDTO update(UUID id, LibroDTO libroDTO) {
        Libro libro = libroRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Libro", id));

        libro.setTitulo(libroDTO.getTitulo());
        libro.setAutor(libroDTO.getAutor());
        libro.setIsbn(libroDTO.getIsbn());
        libro.setGenero(libroDTO.getGenero());
        libro.setFechaPublicacion(libroDTO.getFechaPublicacion());
        libro.setDisponible(libroDTO.getDisponible());

        Libro updated = libroRepository.save(libro);
        return libroMapper.toDTO(updated);
    }

    public void delete(UUID id) {
        Libro libro = libroRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Libro", id));
        libroRepository.delete(libro);
    }
}
