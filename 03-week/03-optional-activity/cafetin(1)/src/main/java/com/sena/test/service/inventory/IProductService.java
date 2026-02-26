package com.sena.test.service.inventory;

import java.util.List;

import com.sena.test.entity.inventory.Product;

public interface IProductService {

    List<Product> findAll();

    Product findById(Integer id);

    List<Product> findByName(String name);

    List<Product> findByCategory(Integer categoryId);

    List<Product> findLowStock(Integer quantity);

    Product save(Product product);

    Product update(Integer id, Product product);

    boolean delete(Integer id);

    Product findByCustom(Integer id);
}
