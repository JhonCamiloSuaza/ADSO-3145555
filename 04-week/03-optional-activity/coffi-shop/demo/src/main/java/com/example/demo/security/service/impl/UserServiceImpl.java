package com.example.demo.security.service.impl;
import com.example.demo.parameter.entity.Person;
import com.example.demo.parameter.Repository.PersonRepository;
import com.example.demo.security.dtos.UserRequestDto;
import com.example.demo.security.dtos.UserResponseDto;
import com.example.demo.security.entity.User;
import com.example.demo.security.Repository.UserRepository;
import com.example.demo.security.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final PersonRepository personRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public UserResponseDto save(UserRequestDto request) {
        if (userRepository.existsByUsername(request.getUsername()))
            throw new RuntimeException("Ya existe un usuario con el username: " + request.getUsername());
        Person person = findPersonById(request.getPersonId());
        User entity = User.builder()
                .person(person).username(request.getUsername())
                .password(passwordEncoder.encode(request.getPassword()))
                .status(true).build();
        return toResponse(userRepository.save(entity));
    }

    @Override
    public UserResponseDto update(UUID id, UserRequestDto request) {
        User entity = findEntityById(id);
        entity.setUsername(request.getUsername());
        if (request.getPassword() != null && !request.getPassword().isBlank())
            entity.setPassword(passwordEncoder.encode(request.getPassword()));
        return toResponse(userRepository.save(entity));
    }

    @Override
    public void delete(UUID id) {
        User entity = findEntityById(id);
        entity.setDeletedAt(OffsetDateTime.now());
        entity.setStatus(false);
        userRepository.save(entity);
    }

    @Override
    public UserResponseDto findById(UUID id) { return toResponse(findEntityById(id)); }

    @Override
    public UserResponseDto findByUsername(String username) {
        return userRepository.findByUsername(username)
                .map(this::toResponse)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado: " + username));
    }

    @Override
    public List<UserResponseDto> findByName(String name) {
        return userRepository.findByPersonName(name)
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<UserResponseDto> findAllActive() {
        return userRepository.findByStatusTrue()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public List<UserResponseDto> findAll() {
        return userRepository.findAll()
                .stream().map(this::toResponse).collect(Collectors.toList());
    }

    private User findEntityById(UUID id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado con ID: " + id));
    }

    private Person findPersonById(UUID id) {
        return personRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Persona no encontrada con ID: " + id));
    }

    private UserResponseDto toResponse(User entity) {
        return UserResponseDto.builder()
                .id(entity.getId()).personId(entity.getPerson().getId())
                .personFullName(entity.getPerson().getFirstName() + " " + entity.getPerson().getLastName())
                .username(entity.getUsername()).status(entity.getStatus()).build();
    }
}