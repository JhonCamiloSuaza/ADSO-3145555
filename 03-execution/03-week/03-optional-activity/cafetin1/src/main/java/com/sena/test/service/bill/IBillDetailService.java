package com.sena.test.service.bill;

import java.util.List;
import com.sena.test.dto.bill.BillDetailDTO;

public interface IBillDetailService {

    List<BillDetailDTO> findAll();

    BillDetailDTO findById(Integer id);

    List<BillDetailDTO> findByBillId(Integer billId);

    List<BillDetailDTO> findByProductId(Integer productId);

    BillDetailDTO save(BillDetailDTO dto);

    BillDetailDTO update(Integer id, BillDetailDTO dto);

    void delete(Integer id);
}
