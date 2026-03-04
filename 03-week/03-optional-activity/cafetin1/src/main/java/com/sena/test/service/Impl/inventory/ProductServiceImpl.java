package com.sena.test.service.Impl.inventory;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sena.test.entity.inventory.Category;
import com.sena.test.entity.inventory.Product;
import com.sena.test.repository.inventory.ICategoryRepository;
import com.sena.test.repository.inventory.IProductRepository;
import com.sena.test.service.inventory.IProductService;

@Service
public class ProductServiceImpl implements IProductService {

    @Autowired
    private IProductRepository productRepository;

    @Autowired
    private ICategoryRepository categoryRepository;

    @Override
    public List<Product> findAll() {
        return productRepository.findAll();
    }

    @Override
    public Product findById(Integer id) {
        return productRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Producto no encontrado con id: " + id));
    }

    @Override
    public List<Product> findByName(String name) {
        return productRepository.filterByName(name);
    }

    @Override
    public List<Product> findByCategory(Integer categoryId) {
        return productRepository.filterByCategory(categoryId);
    }

    @Override
    public List<Product> findLowStock(Integer quantity) {
        return productRepository.findLowStock(quantity);
    }

    @Override
    public Product save(Product product) {
        // verify category exists
        Category category = categoryRepository.findById(product.getCategory().getId())
            .orElseThrow(() -> new RuntimeException("Categoría no encontrada con id: " + product.getCategory().getId()));
        product.setCategory(category);
        return productRepository.save(product);
    }

    @Override
    public Product update(Integer id, Product product) {
        Product existing = productRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Producto no encontrado con id: " + id));
        existing.setName(product.getName());
        existing.setDescription(product.getDescription());
        existing.setPrice(product.getPrice());
        existing.setStock(product.getStock());
        Category category = categoryRepository.findById(product.getCategory().getId())
            .orElseThrow(() -> new RuntimeException("Categoría no encontrada con id: " + product.getCategory().getId()));
        existing.setCategory(category);
        return productRepository.save(existing);
    }

    @Override
    public boolean delete(Integer id) {
        if (!productRepository.existsById(id)) {
            return false;
        }
        productRepository.deleteById(id);
        return true;
    }

    @Override
    public Product findByCustom(Integer id) {
        return productRepository.findByIdCustom(id);
    }
}
