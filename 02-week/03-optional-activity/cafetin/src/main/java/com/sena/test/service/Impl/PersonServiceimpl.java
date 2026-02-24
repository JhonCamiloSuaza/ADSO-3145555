package com.sena.test.service.Impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sena.test.dto.PersonDTO;
import com.sena.test.entity.Person;
import com.sena.test.repository.IPersonRepository;
import com.sena.test.service.IPersonService;

@Service
public class PersonServiceimpl implements IPersonService {

    @Autowired
    private IPersonRepository personRepository;

    
    private PersonDTO toDTO(Person person) {
        return new PersonDTO(
            person.getId(),
            person.getName(),
            person.getEdad()
        );
    }

    
    private Person toEntity(PersonDTO dto) {
        Person person = new Person();
        person.setName(dto.getName());
        person.setEdad(dto.getEdad());
        return person;
    }

    @Override
    public List<PersonDTO> findAll() {
        return personRepository.findAll()
            .stream()
            .map(this::toDTO)
            .collect(Collectors.toList());
    }

    @Override
    public PersonDTO findById(Integer id) {
        Person person = personRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Persona no encontrada con id: " + id));
        return toDTO(person);
    }

    @Override
    public List<PersonDTO> findByName(String name) {
        return personRepository.filterByName(name)
            .stream()
            .map(this::toDTO)
            .collect(Collectors.toList());
    }

    @Override
    public List<PersonDTO> findByEdad(Integer edad) {
        return personRepository.filterByAge(edad)
            .stream()
            .map(this::toDTO)
            .collect(Collectors.toList());
    }

    @Override
    public PersonDTO save(PersonDTO dto) {
        Person person = toEntity(dto);
        return toDTO(personRepository.save(person));
    }

    @Override
    public PersonDTO update(Integer id, PersonDTO dto) {
        Person person = personRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Persona no encontrada con id: " + id));
        person.setName(dto.getName());
        person.setEdad(dto.getEdad());
        return toDTO(personRepository.save(person));
    }

    @Override
    public void delete(Integer id) {
        if (!personRepository.existsById(id)) {
            throw new RuntimeException("Persona no encontrada con id: " + id);
        }
        personRepository.deleteById(id);
    }
}