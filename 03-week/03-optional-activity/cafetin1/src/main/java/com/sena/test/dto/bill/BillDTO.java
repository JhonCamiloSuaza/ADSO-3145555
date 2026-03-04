package com.sena.test.dto.bill;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class BillDTO {

    private Integer id;
    private Integer userId;
    private String userName;
    private LocalDateTime billDate;
    private BigDecimal totalAmount;
    private String notes;
    private String status;

    public BillDTO() {}

    public BillDTO(Integer id, Integer userId, String userName, LocalDateTime billDate, 
                  BigDecimal totalAmount, String notes, String status) {
        this.id = id;
        this.userId = userId;
        this.userName = userName;
        this.billDate = billDate;
        this.totalAmount = totalAmount;
        this.notes = notes;
        this.status = status;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public LocalDateTime getBillDate() { return billDate; }
    public void setBillDate(LocalDateTime billDate) { this.billDate = billDate; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
