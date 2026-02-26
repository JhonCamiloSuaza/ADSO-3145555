package com.sena.test.controller.security;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.sena.test.dto.security.UserPasswordDTO;
import com.sena.test.dto.security.UserQueryDTO;
import com.sena.test.entity.security.User;
import com.sena.test.entity.security.Person;
import com.sena.test.entity.security.Role;
import com.sena.test.service.security.IUserService;

@RestController
@RequestMapping("/api/users")
@CrossOrigin("*")
public class UserController {

    @Autowired
    private IUserService userService;

    
    private UserQueryDTO toDTO(User user) {
        List<String> roles = user.getRoles() == null ? List.of() : user.getRoles().stream().map(Role::getRole).toList();
        return new UserQueryDTO(
            user.getId(),
            user.getEmail(),
            user.getUserName(),
            user.getPerson() != null ? user.getPerson().getName() : null,
            user.getPerson() != null ? user.getPerson().getEdad() : null,
            roles
        );
    }

    private User toEntity(UserPasswordDTO dto) {
        User u = new User();
        u.setEmail(dto.getEmail());
        u.setPassword(dto.getPassword());
        u.setUserName(dto.getUserName());
        Person p = new Person();
        p.setName(dto.getPersonName());
        p.setEdad(dto.getPersonEdad());
        u.setPerson(p);
        if (dto.getRoleIds() != null) {
            List<Role> roles = dto.getRoleIds().stream().map(id -> { Role r = new Role(); r.setId(id); return r; }).toList();
            u.setRoles(roles);
        }
        return u;
    }

    @GetMapping
    public ResponseEntity<List<UserQueryDTO>> getAll() {
        List<User> list = userService.findAll();
        List<UserQueryDTO> dtos = list.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    
    @GetMapping("/{id}")
    public ResponseEntity<UserQueryDTO> getById(@PathVariable Integer id) {
        User u = userService.findById(id);
        return ResponseEntity.ok(toDTO(u));
    }

    
    @GetMapping("/nombre/{name}")
    public ResponseEntity<List<UserQueryDTO>> getByName(@PathVariable String name) {
        List<User> list = userService.findByName(name);
        List<UserQueryDTO> dtos = list.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    
    @GetMapping("/edad/{edad}")
    public ResponseEntity<List<UserQueryDTO>> getByEdad(@PathVariable Integer edad) {
        List<User> list = userService.findByEdad(edad);
        List<UserQueryDTO> dtos = list.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    
    @PostMapping
    public ResponseEntity<UserQueryDTO> save(@RequestBody UserPasswordDTO dto) {
        User u = toEntity(dto);
        User saved = userService.save(u);
        return ResponseEntity.status(HttpStatus.CREATED).body(toDTO(saved));
    }

    
    @PutMapping("/{id}")
    public ResponseEntity<UserQueryDTO> update(@PathVariable Integer id,     @RequestBody UserPasswordDTO dto) {
        User u = toEntity(dto);
        User updated = userService.update(id, u);
        return ResponseEntity.ok(toDTO(updated));
    }

    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        userService.delete(id);
        return ResponseEntity.noContent().build();
    }
}