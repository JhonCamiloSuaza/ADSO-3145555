package com.example.demo.Sales.service;

import com.example.demo.Sales.dto.OrderItemRequestDto;
import com.example.demo.Sales.dto.OrderItemResponseDto;

import java.util.List;
import java.util.UUID;

public interface OrderItemService {

    OrderItemResponseDto save(OrderItemRequestDto request);
    OrderItemResponseDto update(UUID id, OrderItemRequestDto request);
    void delete(UUID id);
    OrderItemResponseDto findById(UUID id);
    List<OrderItemResponseDto> findByOrderId(UUID orderId);
    List<OrderItemResponseDto> findByProductId(UUID productId);
    List<OrderItemResponseDto> findAllActive();
    List<OrderItemResponseDto> findAll();
}
