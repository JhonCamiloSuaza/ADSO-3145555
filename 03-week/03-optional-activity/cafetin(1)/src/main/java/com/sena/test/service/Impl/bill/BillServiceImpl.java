package com.sena.test.service.Impl.bill;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sena.test.entity.bill.Bill;
import com.sena.test.entity.security.User;
import com.sena.test.repository.bill.IBillRepository;
import com.sena.test.repository.security.IUserRepository;
import com.sena.test.service.bill.IBillService;

@Service
public class BillServiceImpl implements IBillService {

    @Autowired
    private IBillRepository billRepository;

    @Autowired
    private IUserRepository userRepository;

    @Override
    public List<Bill> findAll() {
        return billRepository.findAll();
    }

    @Override
    public Bill findById(Integer id) {
        return billRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Factura no encontrada con id: " + id));
    }

    @Override
    public List<Bill> findByUserId(Integer userId) {
        return billRepository.findByUserId(userId);
    }

    @Override
    public List<Bill> findByUserEmail(String email) {
        return billRepository.findByUserEmail(email);
    }

    @Override
    public List<Bill> findByDateRange(LocalDateTime startDate, LocalDateTime endDate) {
        return billRepository.findByDateRange(startDate, endDate);
    }

    @Override
    public List<Bill> findByStatus(String status) {
        return billRepository.findByStatus(status);
    }

    @Override
    public Bill save(Bill bill) {
        User user = userRepository.findById(bill.getUser().getId())
            .orElseThrow(() -> new RuntimeException("Usuario no encontrado con id: " + bill.getUser().getId()));
        bill.setUser(user);
        if (bill.getBillDate() == null) bill.setBillDate(LocalDateTime.now());
        if (bill.getStatus() == null) bill.setStatus("PENDING");
        return billRepository.save(bill);
    }

    @Override
    public Bill update(Integer id, Bill bill) {
        Bill existing = billRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Factura no encontrada con id: " + id));
        if (bill.getUser() != null && bill.getUser().getId() != null) {
            User user = userRepository.findById(bill.getUser().getId())
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado con id: " + bill.getUser().getId()));
            existing.setUser(user);
        }
        if (bill.getBillDate() != null) existing.setBillDate(bill.getBillDate());
        if (bill.getTotalAmount() != null) existing.setTotalAmount(bill.getTotalAmount());
        existing.setNotes(bill.getNotes());
        existing.setStatus(bill.getStatus() != null ? bill.getStatus() : existing.getStatus());
        return billRepository.save(existing);
    }

    @Override
    public boolean delete(Integer id) {
        Bill existing = billRepository.findById(id).orElse(null);
        if (existing == null) return false;
        existing.setStatus("CANCELLED");
        billRepository.save(existing);
        return true;
    }

    @Override
    public Bill findByCustom(Integer id) {
        return billRepository.findByIdCustom(id);
    }
}
