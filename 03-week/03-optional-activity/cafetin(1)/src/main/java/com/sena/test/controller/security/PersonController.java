package com.sena.test.controller.security;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.sena.test.dto.security.PersonDTO;
import com.sena.test.entity.security.Person;
import com.sena.test.service.security.IPersonService;

@RestController
@RequestMapping("/api/persons")
@CrossOrigin("*")
public class PersonController {

    @Autowired
    private IPersonService personService;

    
    private PersonDTO toDTO(Person person) {
        return new PersonDTO(person.getId(), person.getName(), person.getEdad());
    }

    private Person toEntity(PersonDTO dto) {
        Person p = new Person();
        p.setId(dto.getId());
        p.setName(dto.getName());
        p.setEdad(dto.getEdad());
        return p;
    }

    @GetMapping
    public ResponseEntity<List<PersonDTO>> getAll() {
        List<Person> list = personService.findAll();
        List<PersonDTO> dtos = list.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }


    @GetMapping("/{id}")
    public ResponseEntity<PersonDTO> getById(@PathVariable Integer id) {
        Person p = personService.findById(id);
        return ResponseEntity.ok(toDTO(p));
    }

    
    @GetMapping("/nombre/{name}")
    public ResponseEntity<List<PersonDTO>> getByName(@PathVariable String name) {
        List<Person> list = personService.findByName(name);
        List<PersonDTO> dtos = list.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }

    
    @GetMapping("/edad/{edad}")
    public ResponseEntity<List<PersonDTO>> getByEdad(@PathVariable Integer edad) {
        List<Person> list = personService.findByEdad(edad);
        List<PersonDTO> dtos = list.stream().map(this::toDTO).toList();
        return ResponseEntity.ok(dtos);
    }


    @PostMapping
    public ResponseEntity<PersonDTO> save(@RequestBody PersonDTO dto) {
        Person p = toEntity(dto);
        Person saved = personService.save(p);
        return ResponseEntity.status(HttpStatus.CREATED).body(toDTO(saved));
    }

    
    @PutMapping("/{id}")
    public ResponseEntity<PersonDTO> update(@PathVariable Integer id, @RequestBody PersonDTO dto) {
        Person p = toEntity(dto);
        Person updated = personService.update(id, p);
        return ResponseEntity.ok(toDTO(updated));
    }

    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        personService.delete(id);
        return ResponseEntity.noContent().build();
    }
}