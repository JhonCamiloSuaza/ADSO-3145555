package com.sena.test.service.Impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sena.test.dto.UserPasswordDTO;
import com.sena.test.dto.UserQueryDTO;
import com.sena.test.entity.Person;
import com.sena.test.entity.Role;
import com.sena.test.entity.User;
import com.sena.test.repository.IPersonRepository;
import com.sena.test.repository.IRoleRepository;
import com.sena.test.repository.IUserRepository;
import com.sena.test.service.IUserService;

@Service
public class UserServiceimpl implements IUserService {

    @Autowired
    private IUserRepository userRepository;

    @Autowired
    private IPersonRepository personRepository;

    @Autowired
    private IRoleRepository roleRepository;

    // Convierte User -> UserQueryDTO (sin password)
    private UserQueryDTO toDTO(User user) {
        List<String> roles = user.getRoles()
            .stream()
            .map(Role::getRole)
            .collect(Collectors.toList());

        return new UserQueryDTO(
            user.getId(),
            user.getEmail(),
            user.getUserName(),
            user.getPerson().getName(),
            user.getPerson().getEdad(),
            roles
        );
    }

    @Override
    public List<UserQueryDTO> findAll() {
        return userRepository.findAll()
            .stream()
            .map(this::toDTO)
            .collect(Collectors.toList());
    }

    @Override
    public UserQueryDTO findById(Integer id) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Usuario no encontrado con id: " + id));
        return toDTO(user);
    }

    @Override
    public List<UserQueryDTO> findByName(String name) {
        return userRepository.filterByPersonName(name)
            .stream()
            .map(this::toDTO)
            .collect(Collectors.toList());
    }

    @Override
    public List<UserQueryDTO> findByEdad(Integer edad) {
        return userRepository.filterByPersonEdad(edad)
            .stream()
            .map(this::toDTO)
            .collect(Collectors.toList());
    }

    @Override
    public UserQueryDTO save(UserPasswordDTO dto) {
        // Verificar si el email ya existe
        if (userRepository.existsByEmail(dto.getEmail())) {
            throw new RuntimeException("El email ya está registrado: " + dto.getEmail());
        }

        Person person = new Person();
        person.setName(dto.getPersonName());
        person.setEdad(dto.getPersonEdad());
        personRepository.save(person);

   
        List<Role> roles = roleRepository.findAllById(dto.getRoleIds());

     
        User user = new User();
        user.setEmail(dto.getEmail());
        user.setPassword(dto.getPassword());
        user.setUserName(dto.getUserName());
        user.setPerson(person);
        user.setRoles(roles);

        return toDTO(userRepository.save(user));
    }

    @Override
    public UserQueryDTO update(Integer id, UserPasswordDTO dto) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Usuario no encontrado con id: " + id));

        user.setEmail(dto.getEmail());
        user.setUserName(dto.getUserName());

       
        if (dto.getPassword() != null && !dto.getPassword().isBlank()) {
            user.setPassword(dto.getPassword());
        }

        
        Person person = user.getPerson();
        person.setName(dto.getPersonName());
        person.setEdad(dto.getPersonEdad());
        personRepository.save(person);

        
        if (dto.getRoleIds() != null && !dto.getRoleIds().isEmpty()) {
            List<Role> roles = roleRepository.findAllById(dto.getRoleIds());
            user.setRoles(roles);
        }

        return toDTO(userRepository.save(user));
    }

    @Override
    public void delete(Integer id) {
        if (!userRepository.existsById(id)) {
            throw new RuntimeException("Usuario no encontrado con id: " + id);
        }
        userRepository.deleteById(id);
    }
}