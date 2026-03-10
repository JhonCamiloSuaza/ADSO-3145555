package com.sena.test.controller.bill;

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
import org.springframework.web.bind.annotation.RestController;

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
        List<BillDetailDTO> list = billDetailService.findAll();
        return ResponseEntity.ok(list);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getById(@PathVariable Integer id) {
        BillDetailDTO dto = billDetailService.findById(id);
        if (dto == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("Detalle no encontrado");
        }
        return ResponseEntity.ok(dto);
    }

    @GetMapping("/bill/{billId}")
    public ResponseEntity<List<BillDetailDTO>> getByBillId(@PathVariable Integer billId) {
        List<BillDetailDTO> list = billDetailService.findByBillId(billId);
        return ResponseEntity.ok(list);
    }

    @GetMapping("/product/{productId}")
    public ResponseEntity<List<BillDetailDTO>> getByProductId(@PathVariable Integer productId) {
        List<BillDetailDTO> list = billDetailService.findByProductId(productId);
        return ResponseEntity.ok(list);
    }

    @PostMapping
    public ResponseEntity<?> save(@RequestBody BillDetailDTO dto) {
        try {
            BillDetailDTO saved = billDetailService.save(dto);
            return ResponseEntity.status(HttpStatus.CREATED).body(saved);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error al guardar detalle");
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@PathVariable Integer id, @RequestBody BillDetailDTO dto) {
        try {
            BillDetailDTO updated = billDetailService.update(id, dto);
            return ResponseEntity.ok(updated);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error al actualizar detalle");
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable Integer id) {
        try {
            billDetailService.delete(id);
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("No se pudo eliminar, no existe");
        }
    }
}