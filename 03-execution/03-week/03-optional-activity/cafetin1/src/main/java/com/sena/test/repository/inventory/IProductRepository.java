package com.sena.test.repository.inventory;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.sena.test.entity.inventory.Product;

@Repository
public interface IProductRepository extends JpaRepository<Product, Integer> {

    @Query("SELECT p FROM Product p WHERE p.name LIKE %?1%")
    List<Product> filterByName(String name);

    @Query("SELECT p FROM Product p WHERE p.category.id = ?1")
    List<Product> filterByCategory(Integer categoryId);

    @Query("SELECT p FROM Product p WHERE p.stock < ?1")
    List<Product> findLowStock(Integer quantity);

    @Query("SELECT p FROM Product p WHERE p.id = ?1")
    Product findByIdCustom(Integer id);
}
