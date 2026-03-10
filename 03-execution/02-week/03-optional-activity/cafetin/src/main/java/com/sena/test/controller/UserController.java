package com.sena.test.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.sena.test.dto.UserPasswordDTO;
import com.sena.test.dto.UserQueryDTO;
import com.sena.test.service.IUserService;

@RestController
@RequestMapping("/api/users")
@CrossOrigin("*")
public class UserController {

    @Autowired
    private IUserService userService;

    
    @GetMapping
    public ResponseEntity<List<UserQueryDTO>> getAll() {
        return ResponseEntity.ok(userService.findAll());
    }

    
    @GetMapping("/{id}")
    public ResponseEntity<UserQueryDTO> getById(@PathVariable Integer id) {
        return ResponseEntity.ok(userService.findById(id));
    }

    
    @GetMapping("/nombre/{name}")
    public ResponseEntity<List<UserQueryDTO>> getByName(@PathVariable String name) {
        return ResponseEntity.ok(userService.findByName(name));
    }

    
    @GetMapping("/edad/{edad}")
    public ResponseEntity<List<UserQueryDTO>> getByEdad(@PathVariable Integer edad) {
        return ResponseEntity.ok(userService.findByEdad(edad));
    }

    
    @PostMapping
    public ResponseEntity<UserQueryDTO> save(@RequestBody UserPasswordDTO dto) {
        return ResponseEntity.status(HttpStatus.CREATED).body(userService.save(dto));
    }

    
    @PutMapping("/{id}")
    public ResponseEntity<UserQueryDTO> update(@PathVariable Integer id,     @RequestBody UserPasswordDTO dto) {
        return ResponseEntity.ok(userService.update(id, dto));
    }

    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        userService.delete(id);
        return ResponseEntity.noContent().build();
    }
}