package com.sena.test.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.sena.test.dto.PersonDTO;
import com.sena.test.service.IPersonService;

@RestController
@RequestMapping("/api/persons")
@CrossOrigin("*")
public class PersonController {

    @Autowired
    private IPersonService personService;

    
    @GetMapping
    public ResponseEntity<List<PersonDTO>> getAll() {
        return ResponseEntity.ok(personService.findAll());
    }


    @GetMapping("/{id}")
    public ResponseEntity<PersonDTO> getById(@PathVariable Integer id) {
        return ResponseEntity.ok(personService.findById(id));
    }

    
    @GetMapping("/nombre/{name}")
    public ResponseEntity<List<PersonDTO>> getByName(@PathVariable String name) {
        return ResponseEntity.ok(personService.findByName(name));
    }

    
    @GetMapping("/edad/{edad}")
    public ResponseEntity<List<PersonDTO>> getByEdad(@PathVariable Integer edad) {
        return ResponseEntity.ok(personService.findByEdad(edad));
    }


    @PostMapping
    public ResponseEntity<PersonDTO> save(@RequestBody PersonDTO dto) {
        return ResponseEntity.status(HttpStatus.CREATED).body(personService.save(dto));
    }

    
    @PutMapping("/{id}")
    public ResponseEntity<PersonDTO> update(@PathVariable Integer id, @RequestBody PersonDTO dto) {
        return ResponseEntity.ok(personService.update(id, dto));
    }

    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        personService.delete(id);
        return ResponseEntity.noContent().build();
    }
}