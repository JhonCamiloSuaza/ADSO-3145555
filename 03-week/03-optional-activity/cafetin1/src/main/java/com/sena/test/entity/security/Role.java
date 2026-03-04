package com.sena.test.entity.security;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "role")
public class Role {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_role")
    private Integer id;

    @Column(nullable = false, length = 50)
    private String role;

    @JsonIgnore 
    @ManyToMany(mappedBy = "roles")
    private List<User> users;

    public Role() {}

    public Role(Integer id, String role) {
        this.id = id;
        this.role = role;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public List<User> getUsers() { return users; }
    public void setUsers(List<User> users) { this.users = users; }
}