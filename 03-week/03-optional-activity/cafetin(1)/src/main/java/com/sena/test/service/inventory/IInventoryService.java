package com.sena.test.service.inventory;

import java.util.List;
import com.sena.test.entity.inventory.Inventory;

public interface IInventoryService {

    List<Inventory> findAll();

    Inventory findById(Integer id);

    Inventory findByProductId(Integer productId);

    List<Inventory> findLowInventory(Integer quantity);

    Inventory save(Inventory inventory);

    Inventory update(Integer id, Inventory inventory);

    boolean delete(Integer id);

    Inventory findByCustom(Integer id);
}
