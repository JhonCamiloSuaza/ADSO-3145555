package com.exercise.api.service;

import com.exercise.api.dto.PrestamoDTO;
import com.exercise.api.exception.ResourceNotFoundException;
import com.exercise.api.mapper.PrestamoMapper;
import com.exercise.api.model.Libro;
import com.exercise.api.model.Prestamo;
import com.exercise.api.model.Usuario;
import com.exercise.api.repository.LibroRepository;
import com.exercise.api.repository.PrestamoRepository;
import com.exercise.api.repository.UsuarioRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@Transactional
public class PrestamoService {

    private final PrestamoRepository prestamoRepository;
    private final UsuarioRepository usuarioRepository;
    private final LibroRepository libroRepository;
    private final PrestamoMapper prestamoMapper;

    public PrestamoService(PrestamoRepository prestamoRepository,
                           UsuarioRepository usuarioRepository,
                           LibroRepository libroRepository,
                           PrestamoMapper prestamoMapper) {
        this.prestamoRepository = prestamoRepository;
        this.usuarioRepository = usuarioRepository;
        this.libroRepository = libroRepository;
        this.prestamoMapper = prestamoMapper;
    }

    @Transactional(readOnly = true)
    public List<PrestamoDTO> findAll() {
        return prestamoRepository.findAll().stream()
                .map(prestamoMapper::toDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public PrestamoDTO findById(UUID id) {
        Prestamo prestamo = prestamoRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Prestamo", id));
        return prestamoMapper.toDTO(prestamo);
    }

    public PrestamoDTO create(PrestamoDTO prestamoDTO) {
        UUID usuarioId = prestamoDTO.getUsuario().getId();
        Usuario usuario = usuarioRepository.findById(usuarioId)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario", usuarioId));

        UUID libroId = prestamoDTO.getLibro().getId();
        Libro libro = libroRepository.findById(libroId)
                .orElseThrow(() -> new ResourceNotFoundException("Libro", libroId));

        Prestamo prestamo = prestamoMapper.toEntity(prestamoDTO);
        prestamo.setUsuario(usuario);
        prestamo.setLibro(libro);

        Prestamo saved = prestamoRepository.save(prestamo);
        return prestamoMapper.toDTO(saved);
    }

    public PrestamoDTO update(UUID id, PrestamoDTO prestamoDTO) {
        Prestamo prestamo = prestamoRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Prestamo", id));

        if (prestamoDTO.getUsuario() != null && prestamoDTO.getUsuario().getId() != null) {
            UUID usuarioId = prestamoDTO.getUsuario().getId();
            Usuario usuario = usuarioRepository.findById(usuarioId)
                    .orElseThrow(() -> new ResourceNotFoundException("Usuario", usuarioId));
            prestamo.setUsuario(usuario);
        }

        if (prestamoDTO.getLibro() != null && prestamoDTO.getLibro().getId() != null) {
            UUID libroId = prestamoDTO.getLibro().getId();
            Libro libro = libroRepository.findById(libroId)
                    .orElseThrow(() -> new ResourceNotFoundException("Libro", libroId));
            prestamo.setLibro(libro);
        }

        prestamo.setFechaPrestamo(prestamoDTO.getFechaPrestamo() != null ? prestamoDTO.getFechaPrestamo() : prestamo.getFechaPrestamo());
        prestamo.setFechaDevolucion(prestamoDTO.getFechaDevolucion());
        prestamo.setEstado(prestamoDTO.getEstado());

        Prestamo updated = prestamoRepository.save(prestamo);
        return prestamoMapper.toDTO(updated);
    }

    public void delete(UUID id) {
        Prestamo prestamo = prestamoRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Prestamo", id));
        prestamoRepository.delete(prestamo);
    }
}
