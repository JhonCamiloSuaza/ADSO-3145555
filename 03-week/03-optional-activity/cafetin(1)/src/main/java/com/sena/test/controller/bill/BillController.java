package com.sena.test.controller.bill;

import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sena.test.dto.bill.BillDTO;
import com.sena.test.service.bill.IBillService;

@RestController
@RequestMapping("/api/bill/bills")
@CrossOrigin("*")
public class BillController {

    @Autowired
    private IBillService billService;

    private BillDTO toDTO(com.sena.test.entity.bill.Bill bill) {
        return new BillDTO(
            bill.getId(),
            bill.getUser().getId(),
            bill.getUser().getUserName(),
            bill.getBillDate(),
            bill.getTotalAmount(),
            bill.getNotes(),
            bill.getStatus()
        );
    }

    private com.sena.test.entity.bill.Bill toEntity(BillDTO dto) {
        com.sena.test.entity.bill.Bill bill = new com.sena.test.entity.bill.Bill();
        com.sena.test.entity.security.User u = new com.sena.test.entity.security.User();
        u.setId(dto.getUserId());
        bill.setUser(u);
        bill.setBillDate(dto.getBillDate());
        bill.setTotalAmount(dto.getTotalAmount());
        bill.setNotes(dto.getNotes());
        bill.setStatus(dto.getStatus());
        return bill;
    }

    @GetMapping
    public ResponseEntity<List<BillDTO>> getAll() {
        List<com.sena.test.entity.bill.Bill> bills = billService.findAll();
        List<BillDTO> dtos = bills.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    @GetMapping("/{id}")
    public ResponseEntity<BillDTO> getById(@PathVariable Integer id) {
        com.sena.test.entity.bill.Bill bill = billService.findById(id);
        return ResponseEntity.ok(toDTO(bill));
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<BillDTO>> getByUserId(@PathVariable Integer userId) {
        List<com.sena.test.entity.bill.Bill> bills = billService.findByUserId(userId);
        List<BillDTO> dtos = bills.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    @GetMapping("/user/email/{email}")
    public ResponseEntity<List<BillDTO>> getByUserEmail(@PathVariable String email) {
        List<com.sena.test.entity.bill.Bill> bills = billService.findByUserEmail(email);
        List<BillDTO> dtos = bills.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    @GetMapping("/status/{status}")
    public ResponseEntity<List<BillDTO>> getByStatus(@PathVariable String status) {
        List<com.sena.test.entity.bill.Bill> bills = billService.findByStatus(status);
        List<BillDTO> dtos = bills.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    @GetMapping("/date")
    public ResponseEntity<?> getByDateRange(@RequestParam String start, @RequestParam String end) {
        try {
            LocalDateTime s = LocalDateTime.parse(start);
            LocalDateTime e = LocalDateTime.parse(end);
            List<com.sena.test.entity.bill.Bill> bills = billService.findByDateRange(s, e);
            List<BillDTO> dtos = bills.stream().map(this::toDTO).toList();
            return ResponseEntity.ok(dtos);
        } catch (DateTimeParseException ex) {
            return ResponseEntity.badRequest().body("Fechas inválidas. Use formato ISO_LOCAL_DATE_TIME: yyyy-MM-ddTHH:mm:ss");
        }
    }

    @PostMapping
    public ResponseEntity<BillDTO> save(@RequestBody BillDTO dto) {
        com.sena.test.entity.bill.Bill bill = toEntity(dto);
        com.sena.test.entity.bill.Bill saved = billService.save(bill);
        return ResponseEntity.status(HttpStatus.CREATED).body(toDTO(saved));
    }

    @PutMapping("/{id}")
    public ResponseEntity<BillDTO> update(@PathVariable Integer id, @RequestBody BillDTO dto) {
        com.sena.test.entity.bill.Bill bill = toEntity(dto);
        com.sena.test.entity.bill.Bill updated = billService.update(id, bill);
        return ResponseEntity.ok(toDTO(updated));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        boolean ok = billService.delete(id);
        if (!ok) return ResponseEntity.notFound().build();
        return ResponseEntity.noContent().build();
    }
}
