package com.sena.test.repository.bill;

import java.time.LocalDateTime;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.sena.test.entity.bill.Bill;

@Repository
public interface IBillRepository extends JpaRepository<Bill, Integer> {

    @Query("SELECT b FROM Bill b WHERE b.user.id = ?1")
    List<Bill> findByUserId(Integer userId);

    @Query("SELECT b FROM Bill b WHERE b.billDate >= ?1 AND b.billDate <= ?2")
    List<Bill> findByDateRange(LocalDateTime startDate, LocalDateTime endDate);

    @Query("SELECT b FROM Bill b WHERE b.status = ?1")
    List<Bill> findByStatus(String status);

    @Query("SELECT b FROM Bill b WHERE b.id = ?1")
    Bill findByIdCustom(Integer id);

    @Query("SELECT b FROM Bill b WHERE b.user.email = ?1")
    List<Bill> findByUserEmail(String email);
}
