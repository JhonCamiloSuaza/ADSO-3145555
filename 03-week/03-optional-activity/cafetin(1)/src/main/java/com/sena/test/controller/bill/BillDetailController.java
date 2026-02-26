package com.sena.test.controller.bill;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.sena.test.dto.bill.BillDetailDTO;
import com.sena.test.service.bill.IBillDetailService;

@RestController
@RequestMapping("/api/bill/details")
@CrossOrigin("*")
public class BillDetailController {

    @Autowired
    private IBillDetailService billDetailService;

    @GetMapping
    public ResponseEntity<List<BillDetailDTO>> getAll() {
        return ResponseEntity.ok(billDetailService.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<BillDetailDTO> getById(@PathVariable Integer id) {
        return ResponseEntity.ok(billDetailService.findById(id));
    }

    @GetMapping("/bill/{billId}")
    public ResponseEntity<List<BillDetailDTO>> getByBillId(@PathVariable Integer billId) {
        return ResponseEntity.ok(billDetailService.findByBillId(billId));
    }

    @GetMapping("/product/{productId}")
    public ResponseEntity<List<BillDetailDTO>> getByProductId(@PathVariable Integer productId) {
        return ResponseEntity.ok(billDetailService.findByProductId(productId));
    }

    @PostMapping
    public ResponseEntity<BillDetailDTO> save(@RequestBody BillDetailDTO dto) {
        return ResponseEntity.status(HttpStatus.CREATED).body(billDetailService.save(dto));
    }

    @PutMapping("/{id}")
    public ResponseEntity<BillDetailDTO> update(@PathVariable Integer id, @RequestBody BillDetailDTO dto) {
        return ResponseEntity.ok(billDetailService.update(id, dto));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        billDetailService.delete(id);
        return ResponseEntity.noContent().build();
    }
}
