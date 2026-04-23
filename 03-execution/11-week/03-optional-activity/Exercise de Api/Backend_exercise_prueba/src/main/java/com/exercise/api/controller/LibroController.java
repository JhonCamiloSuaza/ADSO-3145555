package com.exercise.api.controller;

import com.exercise.api.dto.LibroDTO;
import com.exercise.api.service.LibroService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/libros")
@Tag(name = "Libros", description = "Operaciones CRUD para la entidad Libro")
public class LibroController {

    private final LibroService libroService;

    public LibroController(LibroService libroService) {
        this.libroService = libroService;
    }

    @GetMapping
    @Operation(summary = "Consultar todos los libros",
               description = "Retorna la lista completa del catálogo de libros")
    @ApiResponse(responseCode = "200", description = "Lista de libros obtenida exitosamente")
    public ResponseEntity<List<LibroDTO>> findAll() {
        return ResponseEntity.ok(libroService.findAll());
    }

    @GetMapping("/{id}")
    @Operation(summary = "Consultar libro por ID",
               description = "Retorna un libro específico según su UUID")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Libro encontrado"),
        @ApiResponse(responseCode = "404", description = "Libro no encontrado")
    })
    public ResponseEntity<LibroDTO> findById(@PathVariable UUID id) {
        return ResponseEntity.ok(libroService.findById(id));
    }

    @PostMapping
    @Operation(summary = "Crear un nuevo libro",
               description = "Registra un nuevo libro en el catálogo")
    @ApiResponses({
        @ApiResponse(responseCode = "201", description = "Libro creado exitosamente"),
        @ApiResponse(responseCode = "400", description = "Datos de entrada inválidos")
    })
    public ResponseEntity<LibroDTO> create(@Valid @RequestBody LibroDTO libroDTO) {
        return ResponseEntity.status(HttpStatus.CREATED).body(libroService.create(libroDTO));
    }

    @PutMapping("/{id}")
    @Operation(summary = "Modificar un libro",
               description = "Actualiza los datos de un libro existente")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Libro modificado exitosamente"),
        @ApiResponse(responseCode = "404", description = "Libro no encontrado"),
        @ApiResponse(responseCode = "400", description = "Datos de entrada inválidos")
    })
    public ResponseEntity<LibroDTO> update(@PathVariable UUID id,
                                        @Valid @RequestBody LibroDTO libroDTO) {
        return ResponseEntity.ok(libroService.update(id, libroDTO));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Eliminar un libro",
               description = "Elimina un libro del catálogo por su ID")
    @ApiResponses({
        @ApiResponse(responseCode = "204", description = "Libro eliminado exitosamente"),
        @ApiResponse(responseCode = "404", description = "Libro no encontrado")
    })
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        libroService.delete(id);
        return ResponseEntity.noContent().build();
    }
}
