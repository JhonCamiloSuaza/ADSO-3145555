package com.sena.test.dto.security;

import java.util.List;

public class UserQueryDTO {

    private Integer id;
    private String email;
    private String userName;
    private String personName;
    private Integer personEdad;
    private List<String> roles;

    public UserQueryDTO() {}

    public UserQueryDTO(Integer id, String email, String userName,
     String personName, Integer personEdad, List<String> roles) {
        this.id = id;
        this.email = email;
        this.userName = userName;
        this.personName = personName;
        this.personEdad = personEdad;
        this.roles = roles;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getPersonName() { return personName; }
    public void setPersonName(String personName) { this.personName = personName; }

    public Integer getPersonEdad() { return personEdad; }
    public void setPersonEdad(Integer personEdad) { this.personEdad = personEdad; }

    public List<String> getRoles() { return roles; }
    public void setRoles(List<String> roles) { this.roles = roles; }
}
