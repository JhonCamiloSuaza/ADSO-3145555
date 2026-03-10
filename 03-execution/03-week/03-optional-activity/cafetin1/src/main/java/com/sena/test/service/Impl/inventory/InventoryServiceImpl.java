package com.sena.test.service.Impl.inventory;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sena.test.entity.inventory.Inventory;
import com.sena.test.entity.inventory.Product;
import com.sena.test.repository.inventory.IInventoryRepository;
import com.sena.test.repository.inventory.IProductRepository;
import com.sena.test.service.inventory.IInventoryService;

@Service

public class InventoryServiceImpl implements IInventoryService {

    @Autowired
    private IInventoryRepository inventoryRepository;

    @Autowired
    private IProductRepository productRepository;

    @Override
    public List<Inventory> findAll() {
        return inventoryRepository.findAll();
    }

    @Override
    public Inventory findById(Integer id) {
        return inventoryRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Inventario no encontrado con id: " + id));
    }

    @Override
    public Inventory findByProductId(Integer productId) {
        Inventory inventory = inventoryRepository.findByProductId(productId);
        if (inventory == null) {
            throw new RuntimeException("Inventario no encontrado para el producto: " + productId);
        }
        return inventory;
    }

    @Override
    public List<Inventory> findLowInventory(Integer quantity) {
        return inventoryRepository.findLowInventory(quantity);
    }

    @Override
    public Inventory save(Inventory inventory) {
        Product product = productRepository.findById(inventory.getProduct().getId())
            .orElseThrow(() -> new RuntimeException("Producto no encontrado con id: " + inventory.getProduct().getId()));
        inventory.setProduct(product);
        inventory.setLastUpdated(LocalDateTime.now());
        return inventoryRepository.save(inventory);
    }

    @Override
    public Inventory update(Integer id, Inventory inventory) {
        Inventory existing = inventoryRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Inventario no encontrado con id: " + id));
        existing.setQuantityAvailable(inventory.getQuantityAvailable());
        existing.setQuantityReserved(inventory.getQuantityReserved());
        existing.setLastUpdated(LocalDateTime.now());
        return inventoryRepository.save(existing);
    }

    @Override
    public boolean delete(Integer id) {
        if (!inventoryRepository.existsById(id)) {
            return false;
        }
        inventoryRepository.deleteById(id);
        return true;
    }

    @Override
    public Inventory findByCustom(Integer id) {
        return inventoryRepository.findByIdCustom(id);
    }
}
