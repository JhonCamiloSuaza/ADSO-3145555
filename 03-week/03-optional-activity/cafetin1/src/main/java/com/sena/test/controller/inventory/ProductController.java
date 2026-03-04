package com.sena.test.controller.inventory;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sena.test.dto.inventory.ProductDTO;
import com.sena.test.service.inventory.IProductService;

@RestController
@RequestMapping("/api/inventory/products")
@CrossOrigin("*")
public class ProductController {

    @Autowired
    private IProductService productService;

    // ✅ ENTITY → DTO (CORREGIDO NULL)
    private ProductDTO toDTO(com.sena.test.entity.inventory.Product product) {
        return new ProductDTO(
            product.getId(),
            product.getName(),
            product.getDescription(),
            product.getPrice(),
            product.getStock(),
            product.getCategory() != null ? product.getCategory().getId() : null,
            product.getCategory() != null ? product.getCategory().getName() : null
        );
    }

    // ✅ DTO → ENTITY (CORREGIDO)
    private com.sena.test.entity.inventory.Product toEntity(ProductDTO dto) {
        com.sena.test.entity.inventory.Product product = new com.sena.test.entity.inventory.Product();

        product.setId(dto.getId()); // 🔥 IMPORTANTE para update
        product.setName(dto.getName());
        product.setDescription(dto.getDescription());
        product.setPrice(dto.getPrice());
        product.setStock(dto.getStock());

        // ✅ SOLO SI VIENE CATEGORY
        if (dto.getCategoryId() != null) {
            com.sena.test.entity.inventory.Category cat = new com.sena.test.entity.inventory.Category();
            cat.setId(dto.getCategoryId());
            product.setCategory(cat);
        }

        return product;
    }

    @GetMapping
    public ResponseEntity<List<ProductDTO>> getAll() {
        List<com.sena.test.entity.inventory.Product> products = productService.findAll();
        List<ProductDTO> dtos = products.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductDTO> getById(@PathVariable Integer id) {
        com.sena.test.entity.inventory.Product product = productService.findById(id);
        return ResponseEntity.ok(toDTO(product));
    }

    @GetMapping("/name/{name}")
    public ResponseEntity<List<ProductDTO>> getByName(@PathVariable String name) {
        List<com.sena.test.entity.inventory.Product> products = productService.findByName(name);
        List<ProductDTO> dtos = products.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    @GetMapping("/category/{categoryId}")
    public ResponseEntity<List<ProductDTO>> getByCategory(@PathVariable Integer categoryId) {
        List<com.sena.test.entity.inventory.Product> products = productService.findByCategory(categoryId);
        List<ProductDTO> dtos = products.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    @GetMapping("/lowstock/{quantity}")
    public ResponseEntity<List<ProductDTO>> getLowStock(@PathVariable Integer quantity) {
        List<com.sena.test.entity.inventory.Product> products = productService.findLowStock(quantity);
        List<ProductDTO> dtos = products.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    @PostMapping
    public ResponseEntity<ProductDTO> save(@RequestBody ProductDTO dto) {
        com.sena.test.entity.inventory.Product product = toEntity(dto);
        com.sena.test.entity.inventory.Product saved = productService.save(product);
        return ResponseEntity.status(HttpStatus.CREATED).body(toDTO(saved));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ProductDTO> update(@PathVariable Integer id, @RequestBody ProductDTO dto) {
        com.sena.test.entity.inventory.Product product = toEntity(dto);
        com.sena.test.entity.inventory.Product updated = productService.update(id, product);
        return ResponseEntity.ok(toDTO(updated));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        boolean ok = productService.delete(id);
        if (!ok) return ResponseEntity.notFound().build();
        return ResponseEntity.noContent().build();
    }
}