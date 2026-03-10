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
import com.sena.test.entity.UserRole;
import com.sena.test.repository.IPersonRepository;
import com.sena.test.repository.IRoleRepository;
import com.sena.test.repository.IUserRepository;
import com.sena.test.repository.IUserRoleRepository;
import com.sena.test.service.IUserService;

@Service
public class UserServiceImpl implements IUserService {

    @Autowired
    private IUserRepository userRepository;

    @Autowired
    private IPersonRepository personRepository;

    @Autowired
    private IRoleRepository roleRepository;

    @Autowired
    private IUserRoleRepository userRoleRepository;

    private UserQueryDTO toDTO(User user) {

        List<String> roles = user.getUserRoles()
                .stream()
                .map(ur -> ur.getRole().getRole())
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

        if (userRepository.existsByEmail(dto.getEmail())) {
            throw new RuntimeException("El email ya está registrado: " + dto.getEmail());
        }

        // Crear Person
        Person person = new Person();
        person.setName(dto.getPersonName());
        person.setEdad(dto.getPersonEdad());
        person = personRepository.save(person);

        // Crear User
        User user = new User();
        user.setEmail(dto.getEmail());
        user.setPassword(dto.getPassword());
        user.setUserName(dto.getUserName());
        user.setPerson(person);

        user = userRepository.save(user);

        // Crear relaciones UserRole
        List<Role> roles = roleRepository.findAllById(dto.getRoleIds());

        for (Role role : roles) {
            UserRole userRole = new UserRole();
            userRole.setUser(user);
            userRole.setRole(role);
            userRoleRepository.save(userRole);
        }

        return toDTO(userRepository.findById(user.getId()).get());
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

        // Actualizar Person
        Person person = user.getPerson();
        person.setName(dto.getPersonName());
        person.setEdad(dto.getPersonEdad());
        personRepository.save(person);

        // Eliminar roles actuales
        userRoleRepository.deleteAll(user.getUserRoles());

        // Agregar nuevos roles
        List<Role> roles = roleRepository.findAllById(dto.getRoleIds());

        for (Role role : roles) {
            UserRole userRole = new UserRole();
            userRole.setUser(user);
            userRole.setRole(role);
            userRoleRepository.save(userRole);
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