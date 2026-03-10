package com.sena.test.service.Impl.bill;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sena.test.dto.bill.BillDetailDTO;
import com.sena.test.entity.bill.Bill;
import com.sena.test.entity.bill.BillDetail;
import com.sena.test.entity.inventory.Product;
import com.sena.test.repository.bill.IBillDetailRepository;
import com.sena.test.repository.bill.IBillRepository;
import com.sena.test.repository.inventory.IProductRepository;
import com.sena.test.service.bill.IBillDetailService;

@Service
public class BillDetailServiceImpl implements IBillDetailService {

    @Autowired
    private IBillDetailRepository billDetailRepository;

    @Autowired
    private IBillRepository billRepository;

    @Autowired
    private IProductRepository productRepository;

    private BillDetailDTO toDTO(BillDetail billDetail) {
        return new BillDetailDTO(
            billDetail.getId(),
            billDetail.getBill().getId(),
            billDetail.getProduct().getId(),
            billDetail.getProduct().getName(),
            billDetail.getQuantity(),
            billDetail.getUnitPrice(),
            billDetail.getSubtotal()
        );
    }

    private BillDetail toEntity(BillDetailDTO dto) {
        BillDetail billDetail = new BillDetail();
        
        Bill bill = billRepository.findById(dto.getBillId())
            .orElseThrow(() -> new RuntimeException("Factura no encontrada con id: " + dto.getBillId()));
        billDetail.setBill(bill);
        
        Product product = productRepository.findById(dto.getProductId())
            .orElseThrow(() -> new RuntimeException("Producto no encontrado con id: " + dto.getProductId()));
        billDetail.setProduct(product);
        
        billDetail.setQuantity(dto.getQuantity());
        billDetail.setUnitPrice(dto.getUnitPrice());
        billDetail.setSubtotal(dto.getSubtotal());
        
        return billDetail;
    }

    @Override
    public List<BillDetailDTO> findAll() {
        return billDetailRepository.findAll()
            .stream()
            .map(this::toDTO)
            .collect(Collectors.toList());
    }

    @Override
    public BillDetailDTO findById(Integer id) {
        BillDetail billDetail = billDetailRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Detalle de factura no encontrado con id: " + id));
        return toDTO(billDetail);
    }

    @Override
    public List<BillDetailDTO> findByBillId(Integer billId) {
        return billDetailRepository.findByBillId(billId)
            .stream()
            .map(this::toDTO)
            .collect(Collectors.toList());
    }

    @Override
    public List<BillDetailDTO> findByProductId(Integer productId) {
        return billDetailRepository.findByProductId(productId)
            .stream()
            .map(this::toDTO)
            .collect(Collectors.toList());
    }

    @Override
    public BillDetailDTO save(BillDetailDTO dto) {
        BillDetail billDetail = toEntity(dto);
        return toDTO(billDetailRepository.save(billDetail));
    }

    @Override
    public BillDetailDTO update(Integer id, BillDetailDTO dto) {
        BillDetail billDetail = billDetailRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Detalle de factura no encontrado con id: " + id));
        
        if (dto.getBillId() != null) {
            Bill bill = billRepository.findById(dto.getBillId())
                .orElseThrow(() -> new RuntimeException("Factura no encontrada con id: " + dto.getBillId()));
            billDetail.setBill(bill);
        }
        
        if (dto.getProductId() != null) {
            Product product = productRepository.findById(dto.getProductId())
                .orElseThrow(() -> new RuntimeException("Producto no encontrado con id: " + dto.getProductId()));
            billDetail.setProduct(product);
        }
        
        billDetail.setQuantity(dto.getQuantity());
        billDetail.setUnitPrice(dto.getUnitPrice());
        billDetail.setSubtotal(dto.getSubtotal());
        
        return toDTO(billDetailRepository.save(billDetail));
    }

    @Override
    public void delete(Integer id) {
        if (!billDetailRepository.existsById(id)) {
            throw new RuntimeException("Detalle de factura no encontrado con id: " + id);
        }
        billDetailRepository.deleteById(id);
    }
}
