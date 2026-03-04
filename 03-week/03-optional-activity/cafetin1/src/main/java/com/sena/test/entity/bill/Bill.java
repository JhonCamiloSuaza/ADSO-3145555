package com.sena.test.entity.bill;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import com.sena.test.entity.security.User;

@Entity
@Table(name = "bill")
public class Bill {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_bill")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_user", nullable = false)
    private User user;

    @Column(name = "bill_date", nullable = false)
    private LocalDateTime billDate;

    @Column(nullable = false)
    private BigDecimal totalAmount;

    @Column(length = 500)
    private String notes;

    @Column(nullable = false, length = 20)
    private String status; // Ej: PENDING, PAID, CANCELLED

    @OneToMany(mappedBy = "bill", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<BillDetail> billDetails;

    public Bill() {
        this.billDate = LocalDateTime.now();
        this.status = "PENDING";
        this.totalAmount = BigDecimal.ZERO;
    }

    public Bill(Integer id, User user, LocalDateTime billDate, BigDecimal totalAmount, String notes, String status) {
        this.id = id;
        this.user = user;
        this.billDate = billDate;
        this.totalAmount = totalAmount;
        this.notes = notes;
        this.status = status;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public LocalDateTime getBillDate() { return billDate; }
    public void setBillDate(LocalDateTime billDate) { this.billDate = billDate; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public List<BillDetail> getBillDetails() { return billDetails; }
    public void setBillDetails(List<BillDetail> billDetails) { this.billDetails = billDetails; }
}
