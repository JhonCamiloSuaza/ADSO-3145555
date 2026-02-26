package com.sena.test.repository.inventory;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.sena.test.entity.inventory.Category;

@Repository
public interface ICategoryRepository extends JpaRepository<Category, Integer> {

    @Query("SELECT c FROM Category c WHERE c.name LIKE %?1%")
    List<Category> filterByName(String name);

    @Query("SELECT c FROM Category c WHERE c.id = ?1")
    Category findByIdCustom(Integer id);
}
