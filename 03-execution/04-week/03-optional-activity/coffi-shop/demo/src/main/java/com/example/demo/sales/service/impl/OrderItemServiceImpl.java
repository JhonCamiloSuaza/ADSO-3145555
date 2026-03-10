package com.example.demo.Sales.impl;

import com.example.demo.Inventory.entity.Product;
import com.example.demo.Inventory.repository.ProductRepository;
import com.example.demo.Sales.dto.OrderItemRequestDto;
import com.example.demo.Sales.dto.OrderItemResponseDto;
import com.example.demo.Sales.entity.Order;
import com.example.demo.Sales.entity.OrderItem;
import com.example.demo.Sales.repository.OrderItemRepository;
import com.example.demo.Sales.repository.OrderRepository;
import com.example.demo.Sales.service.OrderItemService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderItemServiceImpl implements OrderItemService {

    private final OrderItemRepository orderItemRepository;
    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;

    @Override
    public OrderItemResponseDto save(OrderItemRequestDto request) {
        if (orderItemRepository.existsByOrderIdAndProductId(request.getOrderId(), request.getProductId()))
            throw new RuntimeException("El producto ya existe en esta orden");

        Order order = findOrderById(request.getOrderId());
        Product product = findProductById(request.getProductId());

        OrderItem entity = OrderItem.builder()
                .order(order)
                .product(product)
                .quantity(request.getQuantity())
                .unitPrice(request.getUnitPrice())
                .status(true)
                .build();
        return toResponse(orderItemRepository.save(entity));
    }

    @Override
    public OrderItemResponseDto update(UUID id, OrderItemRequestDto request) {
        OrderItem entity = findEntityById(id);
        entity.setQuantity(request.getQuantity());
        entity.setUnitPrice(request.getUnitPrice());
        return toResponse(orderItemRepository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        OrderItem entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        orderItemRepository.save(entity);
    }

    @Override
    public OrderItemResponseDto findById(UUID id) {
        return toResponse(findEntityById(id));
    }

    @Override
    public List<OrderItemResponseDto> findByOrderId(UUID orderId) {
        return orderItemRepository.findByOrderId(orderId)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<OrderItemResponseDto> findByProductId(UUID productId) {
        return orderItemRepository.findByProductId(productId)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<OrderItemResponseDto> findAllActive() {
        return orderItemRepository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<OrderItemResponseDto> findAll() {
        return orderItemRepository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private OrderItem findEntityById(UUID id) {
        return orderItemRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Item de orden no encontrado con ID: " + id));
    }

    private Order findOrderById(UUID id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Orden no encontrada con ID: " + id));
    }

    private Product findProductById(UUID id) {
        return productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Producto no encontrado con ID: " + id));
    }

    private OrderItemResponseDto toResponse(OrderItem entity) {
        return OrderItemResponseDto.builder()
                .id(entity.getId())
                .orderId(entity.getOrder().getId())
                .productId(entity.getProduct().getId())
                .productName(entity.getProduct().getName())
                .quantity(entity.getQuantity())
                .unitPrice(entity.getUnitPrice())
                .subtotal(entity.getSubtotal())
                .status(entity.getStatus())
                .build();
    }
}
