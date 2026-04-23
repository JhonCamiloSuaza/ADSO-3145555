package com.exercise.api.exception;

/**
 * Excepción personalizada para recursos no encontrados.
 * Se lanza cuando se intenta acceder a una entidad que no existe.
 */
public class ResourceNotFoundException extends RuntimeException {

    public ResourceNotFoundException(String message) {
        super(message);
    }

    public ResourceNotFoundException(String entityName, Object id) {
        super(String.format("%s no encontrado con id: %s", entityName, id));
    }
}
