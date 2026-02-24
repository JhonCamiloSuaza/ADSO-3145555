package com.sena.test.dto;

import java.util.List;

public class UserPasswordDTO {

    private String email;
    private String password;
    private String userName;
    private String personName;
    private Integer personEdad;
    private List<Integer> roleIds;

    public UserPasswordDTO() {}

    public UserPasswordDTO(String email, String password, String userName,
        String personName, Integer personEdad, List<Integer> roleIds) {
        this.email = email;
        this.password = password;
        this.userName = userName;
        this.personName = personName;
        this.personEdad = personEdad;
        this.roleIds = roleIds;
    }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getPersonName() { return personName; }
    public void setPersonName(String personName) { this.personName = personName; }

    public Integer getPersonEdad() { return personEdad; }
    public void setPersonEdad(Integer personEdad) { this.personEdad = personEdad; }

    public List<Integer> getRoleIds() { return roleIds; }
    public void setRoleIds(List<Integer> roleIds) { this.roleIds = roleIds; }
}