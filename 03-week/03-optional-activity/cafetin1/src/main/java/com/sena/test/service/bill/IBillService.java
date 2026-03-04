package com.sena.test.service.bill;

import java.time.LocalDateTime;
import java.util.List;

import com.sena.test.entity.bill.Bill;

public interface IBillService {

    List<Bill> findAll();

    Bill findById(Integer id);

    List<Bill> findByUserId(Integer userId);

    List<Bill> findByUserEmail(String email);

    List<Bill> findByDateRange(LocalDateTime startDate, LocalDateTime endDate);

    List<Bill> findByStatus(String status);

    Bill save(Bill bill);

    Bill update(Integer id, Bill bill);

    boolean delete(Integer id);

    Bill findByCustom(Integer id);
}
