package com.example.demo.Sales.impl;

import com.example.demo.Method_payment.entity.MethodPayment;
import com.example.demo.Method_payment.repository.MethodPaymentRepository;
import com.example.demo.Sales.dto.OrderRequestDto;
import com.example.demo.Sales.dto.OrderResponseDto;
import com.example.demo.Sales.entity.Customer;
import com.example.demo.Sales.entity.Order;
import com.example.demo.Sales.repository.CustomerRepository;
import com.example.demo.Sales.repository.OrderRepository;
import com.example.demo.Sales.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;
    private final CustomerRepository customerRepository;
    private final MethodPaymentRepository methodPaymentRepository;

    @Override
    public OrderResponseDto save(OrderRequestDto request) {
        Customer customer = findCustomerById(request.getCustomerId());
        MethodPayment methodPayment = findMethodPaymentById(request.getMethodPaymentId());

        Order entity = Order.builder()
                .customer(customer)
                .methodPayment(methodPayment)
                .orderDate(OffsetDateTime.now())
                .total(BigDecimal.ZERO)
                .orderStatus(request.getOrderStatus() != null ? request.getOrderStatus() : "pending")
                .status(true)
                .build();
        return toResponse(orderRepository.save(entity));
    }

    @Override
    public OrderResponseDto update(UUID id, OrderRequestDto request) {
        Order entity = findEntityById(id);
        Customer customer = findCustomerById(request.getCustomerId());
        MethodPayment methodPayment = findMethodPaymentById(request.getMethodPaymentId());

        entity.setCustomer(customer);
        entity.setMethodPayment(methodPayment);
        if (request.getOrderStatus() != null)
            entity.setOrderStatus(request.getOrderStatus());

        return toResponse(orderRepository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        Order entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        orderRepository.save(entity);
    }

    @Override
    public OrderResponseDto findById(UUID id) {
        return toResponse(findEntityById(id));
    }

    @Override
    public List<OrderResponseDto> findByCustomerId(UUID customerId) {
        return orderRepository.findByCustomerId(customerId)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<OrderResponseDto> findByMethodPaymentId(UUID methodPaymentId) {
        return orderRepository.findByMethodPaymentId(methodPaymentId)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<OrderResponseDto> findByOrderStatus(String orderStatus) {
        return orderRepository.findByOrderStatus(orderStatus)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<OrderResponseDto> findAllActive() {
        return orderRepository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<OrderResponseDto> findAll() {
        return orderRepository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private Order findEntityById(UUID id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Orden no encontrada con ID: " + id));
    }

    private Customer findCustomerById(UUID id) {
        return customerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Cliente no encontrado con ID: " + id));
    }

    private MethodPayment findMethodPaymentById(UUID id) {
        return methodPaymentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Método de pago no encontrado con ID: " + id));
    }

    private OrderResponseDto toResponse(Order entity) {
        return OrderResponseDto.builder()
                .id(entity.getId())
                .customerFullName(entity.getCustomer().getPerson().getFirstName() + " " + entity.getCustomer().getPerson().getLastName())
                .methodPaymentName(entity.getMethodPayment().getName())
                .orderDate(entity.getOrderDate())
                .total(entity.getTotal())
                .orderStatus(entity.getOrderStatus())
                .status(entity.getStatus())
                .build();
    }
}
