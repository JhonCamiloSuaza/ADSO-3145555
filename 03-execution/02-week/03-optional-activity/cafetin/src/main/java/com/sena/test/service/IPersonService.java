package com.sena.test.service;

import java.util.List;
import com.sena.test.dto.PersonDTO;

public interface IPersonService {

    List<PersonDTO> findAll();

    PersonDTO findById(Integer id);

    List<PersonDTO> findByName(String name);

    List<PersonDTO> findByEdad(Integer edad);

    PersonDTO save(PersonDTO dto);

    PersonDTO update(Integer id, PersonDTO dto);

    void delete(Integer id);
}