
package com.sena.test.entity.security;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "person")
public class Person {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(nullable = false)
    private Integer edad;

    @JsonIgnore  
    @OneToOne(mappedBy = "person", cascade = CascadeType.ALL)
    private User user;

    public Person() {}

    public Person(Integer id, String name, Integer edad) {
        this.id = id;
        this.name = name;
        this.edad = edad;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Integer getEdad() { return edad; }
    public void setEdad(Integer edad) { this.edad = edad; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
}