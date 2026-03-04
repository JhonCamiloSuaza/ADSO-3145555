package com.sena.test.service.Impl.security;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.sena.test.entity.security.Person;
import com.sena.test.entity.security.Role;
import com.sena.test.entity.security.User;
import com.sena.test.repository.security.IPersonRepository;
import com.sena.test.repository.security.IRoleRepository;
import com.sena.test.repository.security.IUserRepository;
import com.sena.test.service.security.IUserService;

@Service
public class UserServiceImpl implements IUserService {

    @Autowired
    private IUserRepository userRepository;

    @Autowired
    private IPersonRepository personRepository;

    @Autowired
    private IRoleRepository roleRepository;

    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    public User findById(Integer id) {
        return userRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Usuario no encontrado con id: " + id));
    }

    @Override
    public List<User> findByName(String name) {
        return userRepository.filterByPersonName(name);
    }

    @Override
    public List<User> findByEdad(Integer edad) {
        return userRepository.filterByPersonEdad(edad);
    }

    @Override
    public User save(User user) {
        // Verificar si el email ya existe
        if (userRepository.existsByEmail(user.getEmail())) {
            throw new RuntimeException("El email ya está registrado: " + user.getEmail());
        }

        if (user.getPerson() != null) {
            personRepository.save(user.getPerson());
        }

        if (user.getRoles() != null && !user.getRoles().isEmpty()) {
            List<Integer> ids = user.getRoles().stream().map(Role::getId).toList();
            List<Role> roles = roleRepository.findAllById(ids);
            user.setRoles(roles);
        }

        return userRepository.save(user);
    }

    @Override
    public User update(Integer id, User user) {
        User existing = userRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Usuario no encontrado con id: " + id));

        existing.setEmail(user.getEmail());
        existing.setUserName(user.getUserName());

        if (user.getPassword() != null && !user.getPassword().isBlank()) {
            existing.setPassword(user.getPassword());
        }

        if (user.getPerson() != null) {
            Person person = existing.getPerson();
            if (person == null) {
                person = user.getPerson();
            } else {
                person.setName(user.getPerson().getName());
                person.setEdad(user.getPerson().getEdad());
            }
            personRepository.save(person);
            existing.setPerson(person);
        }

        if (user.getRoles() != null && !user.getRoles().isEmpty()) {
            List<Integer> ids = user.getRoles().stream().map(Role::getId).toList();
            List<Role> roles = roleRepository.findAllById(ids);
            existing.setRoles(roles);
        }

        return userRepository.save(existing);
    }

    
     public boolean delete(Integer id) {
        if (!userRepository.existsById(id)) {
            throw new RuntimeException("Usuario no encontrado con id: " + id);
        }
        userRepository.deleteById(id);
        return true;
    }
}