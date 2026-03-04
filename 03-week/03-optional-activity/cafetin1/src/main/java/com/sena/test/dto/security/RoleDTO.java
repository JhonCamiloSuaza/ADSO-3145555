package com.sena.test.dto.security;

public class RoleDTO {

    private Integer id;
    private String role;

    public RoleDTO() {}

    public RoleDTO(Integer id, String role) {
        this.id = id;
        this.role = role;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}
