package com.sena.test.repository.bill;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.sena.test.entity.bill.BillDetail;

@Repository
public interface IBillDetailRepository extends JpaRepository<BillDetail, Integer> {

    @Query("SELECT bd FROM BillDetail bd WHERE bd.bill.id = ?1")
    List<BillDetail> findByBillId(Integer billId);

    @Query("SELECT bd FROM BillDetail bd WHERE bd.product.id = ?1")
    List<BillDetail> findByProductId(Integer productId);

    @Query("SELECT bd FROM BillDetail bd WHERE bd.id = ?1")
    BillDetail findByIdCustom(Integer id);
}
