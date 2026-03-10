package com.example.demo.parameter.Repository;

import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


import com.example.demo.parameter.entity.File;

@Repository
public interface FileRepository extends JpaRepository<File, UUID> {

    // Buscar archivos por persona
    List<File> findByPersonId(UUID personId);

    // Buscar por nombre de archivo (ignorando mayúsculas)
    List<File> findByFileNameContainingIgnoreCase(String fileName);

    // Buscar por tipo de archivo
    List<File> findByFileType(String fileType);

    // Listar solo los activos
    List<File> findByStatusTrue();

    // Buscar archivos activos de una persona
    @Query("SELECT f FROM File f WHERE f.person.id = :personId AND f.status = true")
    List<File> findActiveFilesByPersonId(@Param("personId") UUID personId);
}
