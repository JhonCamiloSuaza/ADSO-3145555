package com.sena.test.controller.inventory;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.sena.test.dto.inventory.CategoryDTO;
import com.sena.test.service.inventory.ICategoryService;

@RestController
@RequestMapping("/api/inventory/categories")
@CrossOrigin("*")
public class CategoryController {

    @Autowired
    private ICategoryService categoryService;

    // Mapeo entidad <-> DTO
    private CategoryDTO toDTO(com.sena.test.entity.inventory.Category category) {
        return new CategoryDTO(
            category.getId(),
            category.getName(),
            category.getDescription()
        );
    }

    private com.sena.test.entity.inventory.Category toEntity(CategoryDTO dto) {
        com.sena.test.entity.inventory.Category category = new com.sena.test.entity.inventory.Category();
        category.setName(dto.getName());
        category.setDescription(dto.getDescription());
        return category;
    }

    @GetMapping
    public ResponseEntity<List<CategoryDTO>> getAll() {
        List<com.sena.test.entity.inventory.Category> categories = categoryService.findAll();
        List<CategoryDTO> dtos = categories.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    @GetMapping("/{id}")
    public ResponseEntity<CategoryDTO> getById(@PathVariable Integer id) {
        com.sena.test.entity.inventory.Category category = categoryService.findById(id);
        return ResponseEntity.ok(toDTO(category));
    }

    @GetMapping("/name/{name}")
    public ResponseEntity<List<CategoryDTO>> getByName(@PathVariable String name) {
        List<com.sena.test.entity.inventory.Category> categories = categoryService.findByName(name);
        List<CategoryDTO> dtos = categories.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    @PostMapping
    public ResponseEntity<CategoryDTO> save(@RequestBody CategoryDTO dto) {
        com.sena.test.entity.inventory.Category category = toEntity(dto);
        com.sena.test.entity.inventory.Category saved = categoryService.save(category);
        return ResponseEntity.status(HttpStatus.CREATED).body(toDTO(saved));
    }

    @PutMapping("/{id}")
    public ResponseEntity<CategoryDTO> update(@PathVariable Integer id, @RequestBody CategoryDTO dto) {
        com.sena.test.entity.inventory.Category category = toEntity(dto);
        com.sena.test.entity.inventory.Category updated = categoryService.update(id, category);
        return ResponseEntity.ok(toDTO(updated));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        categoryService.delete(id);
        return ResponseEntity.noContent().build();
    }
    // ...existing code...
}
