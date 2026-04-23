package com.exercise.api.controller;

import com.exercise.api.dto.PrestamoDTO;
import com.exercise.api.service.PrestamoService;
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
@RequestMapping("/api/v1/prestamos")
@Tag(name = "Préstamos", description = "Operaciones CRUD para la entidad Préstamo")
public class PrestamoController {

    private final PrestamoService prestamoService;

    public PrestamoController(PrestamoService prestamoService) {
        this.prestamoService = prestamoService;
    }

    @GetMapping
    @Operation(summary = "Consultar todos los préstamos",
               description = "Retorna la lista completa de préstamos con datos de usuario y libro")
    @ApiResponse(responseCode = "200", description = "Lista de préstamos obtenida exitosamente")
    public ResponseEntity<List<PrestamoDTO>> findAll() {
        return ResponseEntity.ok(prestamoService.findAll());
    }

    @GetMapping("/{id}")
    @Operation(summary = "Consultar préstamo por ID",
               description = "Retorna un préstamo específico según su UUID")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Préstamo encontrado"),
        @ApiResponse(responseCode = "404", description = "Préstamo no encontrado")
    })
    public ResponseEntity<PrestamoDTO> findById(@PathVariable UUID id) {
        return ResponseEntity.ok(prestamoService.findById(id));
    }

    @PostMapping
    @Operation(summary = "Crear un nuevo préstamo",
               description = "Registra un nuevo préstamo vinculando un usuario con un libro")
    @ApiResponses({
        @ApiResponse(responseCode = "201", description = "Préstamo creado exitosamente"),
        @ApiResponse(responseCode = "400", description = "Datos de entrada inválidos"),
        @ApiResponse(responseCode = "404", description = "Usuario o Libro no encontrado")
    })
    public ResponseEntity<PrestamoDTO> create(@Valid @RequestBody PrestamoDTO prestamoDTO) {
        return ResponseEntity.status(HttpStatus.CREATED).body(prestamoService.create(prestamoDTO));
    }

    @PutMapping("/{id}")
    @Operation(summary = "Modificar un préstamo",
               description = "Actualiza los datos de un préstamo existente")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Préstamo modificado exitosamente"),
        @ApiResponse(responseCode = "404", description = "Préstamo no encontrado"),
        @ApiResponse(responseCode = "400", description = "Datos de entrada inválidos")
    })
    public ResponseEntity<PrestamoDTO> update(@PathVariable UUID id,
                                           @Valid @RequestBody PrestamoDTO prestamoDTO) {
        return ResponseEntity.ok(prestamoService.update(id, prestamoDTO));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Eliminar un préstamo",
               description = "Elimina un préstamo del sistema por su ID")
    @ApiResponses({
        @ApiResponse(responseCode = "204", description = "Préstamo eliminado exitosamente"),
        @ApiResponse(responseCode = "404", description = "Préstamo no encontrado")
    })
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        prestamoService.delete(id);
        return ResponseEntity.noContent().build();
    }
}
