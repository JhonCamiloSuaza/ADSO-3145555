package com.sena.test.dto.inventory;

import java.time.LocalDateTime;

public class InventoryDTO {

    private Integer id;
    private Integer productId;
    private String productName;
    private Integer quantityAvailable;
    private Integer quantityReserved;
    private LocalDateTime lastUpdated;

    public InventoryDTO() {}

    public InventoryDTO(Integer id, Integer productId, String productName, Integer quantityAvailable, 
                       Integer quantityReserved, LocalDateTime lastUpdated) {
        this.id = id;
        this.productId = productId;
        this.productName = productName;
        this.quantityAvailable = quantityAvailable;
        this.quantityReserved = quantityReserved;
        this.lastUpdated = lastUpdated;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getProductId() { return productId; }
    public void setProductId(Integer productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public Integer getQuantityAvailable() { return quantityAvailable; }
    public void setQuantityAvailable(Integer quantityAvailable) { this.quantityAvailable = quantityAvailable; }

    public Integer getQuantityReserved() { return quantityReserved; }
    public void setQuantityReserved(Integer quantityReserved) { this.quantityReserved = quantityReserved; }

    public LocalDateTime getLastUpdated() { return lastUpdated; }
    public void setLastUpdated(LocalDateTime lastUpdated) { this.lastUpdated = lastUpdated; }
}
