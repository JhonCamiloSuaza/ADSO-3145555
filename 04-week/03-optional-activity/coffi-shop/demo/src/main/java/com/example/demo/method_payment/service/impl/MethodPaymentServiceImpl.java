package com.example.demo.Method_payment.impl;

import com.example.demo.Method_payment.dto.MethodPaymentRequestDto;
import com.example.demo.Method_payment.dto.MethodPaymentResponseDto;
import com.example.demo.Method_payment.entity.MethodPayment;
import com.example.demo.Method_payment.repository.MethodPaymentRepository;
import com.example.demo.Method_payment.service.MethodPaymentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MethodPaymentServiceImpl implements MethodPaymentService {

    private final MethodPaymentRepository repository;

    @Override
    public MethodPaymentResponseDto save(MethodPaymentRequestDto request) {
        if (repository.existsByName(request.getName()))
            throw new RuntimeException("Ya existe un método de pago con el nombre: " + request.getName());

        MethodPayment entity = MethodPayment.builder()
                .name(request.getName())
                .description(request.getDescription())
                .status(true)
                .build();
        return toResponse(repository.save(entity));
    }

    @Override
    public MethodPaymentResponseDto update(UUID id, MethodPaymentRequestDto request) {
        MethodPayment entity = findEntityById(id);
        entity.setName(request.getName());
        entity.setDescription(request.getDescription());
        return toResponse(repository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        MethodPayment entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        repository.save(entity);
    }

    @Override
    public MethodPaymentResponseDto findById(UUID id) {
        return toResponse(findEntityById(id));
    }

    @Override
    public List<MethodPaymentResponseDto> findByName(String name) {
        return repository.findByNameContainingIgnoreCase(name)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<MethodPaymentResponseDto> findAllActive() {
        return repository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<MethodPaymentResponseDto> findAll() {
        return repository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private MethodPayment findEntityById(UUID id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Método de pago no encontrado con ID: " + id));
    }

    private MethodPaymentResponseDto toResponse(MethodPayment entity) {
        return MethodPaymentResponseDto.builder()
                .id(entity.getId())
                .name(entity.getName())
                .description(entity.getDescription())
                .status(entity.getStatus())
                .build();
    }
}
