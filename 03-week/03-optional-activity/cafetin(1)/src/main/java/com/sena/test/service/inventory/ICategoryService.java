package com.sena.test.service.inventory;

import java.util.List;

import com.sena.test.entity.inventory.Category;

public interface ICategoryService {

    List<Category> findAll();

    Category findById(Integer id);

    List<Category> findByName(String name);

    Category save(Category category);

    Category update(Integer id, Category category);

    boolean delete(Integer id);

    Category findByCustom(Integer id);
}
