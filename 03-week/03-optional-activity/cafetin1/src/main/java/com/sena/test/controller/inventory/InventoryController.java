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

import com.sena.test.dto.inventory.InventoryDTO;
import com.sena.test.service.inventory.IInventoryService;

@RestController
@RequestMapping("/api/inventory/inventories")
@CrossOrigin("*")
public class InventoryController {

    @Autowired
    private IInventoryService inventoryService;

    // ✅ Convertir Entity → DTO (con validación null)
    private InventoryDTO toDTO(com.sena.test.entity.inventory.Inventory inventory) {
        return new InventoryDTO(
            inventory.getId(),
            inventory.getProduct() != null ? inventory.getProduct().getId() : null,
            inventory.getProduct() != null ? inventory.getProduct().getName() : null,
            inventory.getQuantityAvailable(),
            inventory.getQuantityReserved(),
            inventory.getLastUpdated()
        );
    }

    // ✅ Convertir DTO → Entity
    private com.sena.test.entity.inventory.Inventory toEntity(InventoryDTO dto) {
        com.sena.test.entity.inventory.Inventory inventory = new com.sena.test.entity.inventory.Inventory();

        if (dto.getProductId() != null) {
            com.sena.test.entity.inventory.Product p = new com.sena.test.entity.inventory.Product();
            p.setId(dto.getProductId());
            inventory.setProduct(p);
        }

        inventory.setQuantityAvailable(dto.getQuantityAvailable());
        inventory.setQuantityReserved(dto.getQuantityReserved());

        return inventory;
    }

    // ✅ Obtener todos
    @GetMapping
    public ResponseEntity<List<InventoryDTO>> getAll() {
        List<com.sena.test.entity.inventory.Inventory> items = inventoryService.findAll();
        List<InventoryDTO> dtos = items.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    // ✅ Obtener por ID (control de null)
    @GetMapping("/{id}")
    public ResponseEntity<InventoryDTO> getById(@PathVariable Integer id) {
        com.sena.test.entity.inventory.Inventory inventory = inventoryService.findById(id);

        if (inventory == null) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(toDTO(inventory));
    }

    // ✅ Obtener por producto
    @GetMapping("/product/{productId}")
    public ResponseEntity<InventoryDTO> getByProductId(@PathVariable Integer productId) {
        com.sena.test.entity.inventory.Inventory inventory = inventoryService.findByProductId(productId);

        if (inventory == null) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(toDTO(inventory));
    }

    // ✅ Inventario bajo
    @GetMapping("/lowinventory/{quantity}")
    public ResponseEntity<List<InventoryDTO>> getLowInventory(@PathVariable Integer quantity) {
        List<com.sena.test.entity.inventory.Inventory> items = inventoryService.findLowInventory(quantity);
        List<InventoryDTO> dtos = items.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    // ✅ Crear
    @PostMapping
    public ResponseEntity<InventoryDTO> save(@RequestBody InventoryDTO dto) {
        com.sena.test.entity.inventory.Inventory inventory = toEntity(dto);
        com.sena.test.entity.inventory.Inventory saved = inventoryService.save(inventory);
        return ResponseEntity.status(HttpStatus.CREATED).body(toDTO(saved));
    }

    // ✅ Actualizar
    @PutMapping("/{id}")
    public ResponseEntity<InventoryDTO> update(@PathVariable Integer id, @RequestBody InventoryDTO dto) {
        com.sena.test.entity.inventory.Inventory inventory = toEntity(dto);
        com.sena.test.entity.inventory.Inventory updated = inventoryService.update(id, inventory);

        if (updated == null) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(toDTO(updated));
    }

    // ✅ Eliminar
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        boolean ok = inventoryService.delete(id);

        if (!ok) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.noContent().build();
    }
}