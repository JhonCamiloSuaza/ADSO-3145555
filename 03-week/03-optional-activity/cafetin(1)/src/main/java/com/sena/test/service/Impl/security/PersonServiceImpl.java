package com.sena.test.service.Impl.security;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.sena.test.entity.security.Person;
import com.sena.test.repository.security.IPersonRepository;
import com.sena.test.service.security.IPersonService;

@Service
public class PersonServiceImpl implements IPersonService {

    @Autowired
    private IPersonRepository personRepository;

    
    @Override
    public List<Person> findAll() {
        return personRepository.findAll();
    }

    @Override
    public Person findById(Integer id) {
        return personRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Persona no encontrada con id: " + id));
    }

    @Override
    public List<Person> findByName(String name) {
        return personRepository.filterByName(name);
    }

    @Override
    public List<Person> findByEdad(Integer edad) {
        return personRepository.filterByAge(edad);
    }

    @Override
    public Person save(Person person) {
        return personRepository.save(person);
    }

    @Override
    public Person update(Integer id, Person person) {
        Person existing = personRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Persona no encontrada con id: " + id));
        existing.setName(person.getName());
        existing.setEdad(person.getEdad());
        return personRepository.save(existing);
    }

    @Override
    public void delete(Integer id) {
        if (!personRepository.existsById(id)) {
            throw new RuntimeException("Persona no encontrada con id: " + id);
        }
        personRepository.deleteById(id);
    }
}