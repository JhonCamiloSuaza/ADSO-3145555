package com.sena.test.controller.inventory;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.sena.test.dto.inventory.InventoryDTO;
import com.sena.test.service.inventory.IInventoryService;

@RestController
@RequestMapping("/api/inventory/inventories")
@CrossOrigin("*")
public class InventoryController {

    @Autowired
    private IInventoryService inventoryService;

    private InventoryDTO toDTO(com.sena.test.entity.inventory.Inventory inventory) {
        return new InventoryDTO(
            inventory.getId(),
            inventory.getProduct().getId(),
            inventory.getProduct().getName(),
            inventory.getQuantityAvailable(),
            inventory.getQuantityReserved(),
            inventory.getLastUpdated()
        );
    }

    private com.sena.test.entity.inventory.Inventory toEntity(InventoryDTO dto) {
        com.sena.test.entity.inventory.Inventory inventory = new com.sena.test.entity.inventory.Inventory();
        com.sena.test.entity.inventory.Product p = new com.sena.test.entity.inventory.Product();
        p.setId(dto.getProductId());
        inventory.setProduct(p);
        inventory.setQuantityAvailable(dto.getQuantityAvailable());
        inventory.setQuantityReserved(dto.getQuantityReserved());
        return inventory;
    }

    @GetMapping
    public ResponseEntity<List<InventoryDTO>> getAll() {
        List<com.sena.test.entity.inventory.Inventory> items = inventoryService.findAll();
        List<InventoryDTO> dtos = items.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    @GetMapping("/{id}")
    public ResponseEntity<InventoryDTO> getById(@PathVariable Integer id) {
        com.sena.test.entity.inventory.Inventory inventory = inventoryService.findById(id);
        return ResponseEntity.ok(toDTO(inventory));
    }

    @GetMapping("/product/{productId}")
    public ResponseEntity<InventoryDTO> getByProductId(@PathVariable Integer productId) {
        com.sena.test.entity.inventory.Inventory inventory = inventoryService.findByProductId(productId);
        return ResponseEntity.ok(toDTO(inventory));
    }

    @GetMapping("/lowinventory/{quantity}")
    public ResponseEntity<List<InventoryDTO>> getLowInventory(@PathVariable Integer quantity) {
        List<com.sena.test.entity.inventory.Inventory> items = inventoryService.findLowInventory(quantity);
        List<InventoryDTO> dtos = items.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    @PostMapping
    public ResponseEntity<InventoryDTO> save(@RequestBody InventoryDTO dto) {
        com.sena.test.entity.inventory.Inventory inventory = toEntity(dto);
        com.sena.test.entity.inventory.Inventory saved = inventoryService.save(inventory);
        return ResponseEntity.status(HttpStatus.CREATED).body(toDTO(saved));
    }

    @PutMapping("/{id}")
    public ResponseEntity<InventoryDTO> update(@PathVariable Integer id, @RequestBody InventoryDTO dto) {
        com.sena.test.entity.inventory.Inventory inventory = toEntity(dto);
        com.sena.test.entity.inventory.Inventory updated = inventoryService.update(id, inventory);
        return ResponseEntity.ok(toDTO(updated));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        boolean ok = inventoryService.delete(id);
        if (!ok) return ResponseEntity.notFound().build();
        return ResponseEntity.noContent().build();
    }
}
