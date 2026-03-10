package com.sena.test.repository.inventory;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.sena.test.entity.inventory.Inventory;

@Repository
public interface IInventoryRepository extends JpaRepository<Inventory, Integer> {

    @Query("SELECT i FROM Inventory i WHERE i.product.id = ?1")
    Inventory findByProductId(Integer productId);

    @Query("SELECT i FROM Inventory i WHERE i.quantityAvailable < ?1")
    List<Inventory> findLowInventory(Integer quantity);

    @Query("SELECT i FROM Inventory i WHERE i.id = ?1")
    Inventory findByIdCustom(Integer id);
}
