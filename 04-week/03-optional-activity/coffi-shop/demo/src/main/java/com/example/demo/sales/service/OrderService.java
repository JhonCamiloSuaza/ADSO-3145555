package com.example.demo.Sales.service;

import com.example.demo.Sales.dto.OrderRequestDto;
import com.example.demo.Sales.dto.OrderResponseDto;

import java.util.List;
import java.util.UUID;

public interface OrderService {

    OrderResponseDto save(OrderRequestDto request);
    OrderResponseDto update(UUID id, OrderRequestDto request);
    void delete(UUID id);
    OrderResponseDto findById(UUID id);
    List<OrderResponseDto> findByCustomerId(UUID customerId);
    List<OrderResponseDto> findByMethodPaymentId(UUID methodPaymentId);
    List<OrderResponseDto> findByOrderStatus(String orderStatus);
    List<OrderResponseDto> findAllActive();
    List<OrderResponseDto> findAll();
}
