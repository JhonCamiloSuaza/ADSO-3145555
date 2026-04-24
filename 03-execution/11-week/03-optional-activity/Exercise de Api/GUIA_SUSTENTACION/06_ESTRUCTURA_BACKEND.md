# ☕ 06. ESTRUCTURA DEL BACKEND (SPRING BOOT)

> 💡 **PARA ALGUIEN QUE NO SABE:** Imagina que el Backend es un **Restaurante de Lujo**. El cliente no entra a la cocina, solo habla con el Mesero. El Mesero revisa que el pedido sea válido y se lo lleva al Chef.

---

## 🏛️ El Patrón de Arquitectura: "Capas"
Nuestro código no está amontonado. Sigue una **Arquitectura de Capas**. Cada carpeta tiene una responsabilidad única y no se mete en el trabajo de la otra. Esto hace que si algo falla, sepamos exactamente en qué carpeta buscar.

### 📂 1. Carpeta `controller` (El Mesero / Recepcionista)
*   **Responsabilidad:** Escuchar a internet. Es el único que tiene permiso de hablar con el mundo exterior.
*   **Lenguaje Sencillo:** Recibe tu pedido y te dice si el restaurante está abierto o cerrado.
*   **Término Técnico:** **REST Controller**. Maneja los verbos HTTP (GET, POST, PUT, DELETE).
*   **🔗 Links de Acción:**
    *   **Swagger Principal:** [http://localhost:8080/swagger-ui/index.html](http://localhost:8080/swagger-ui/index.html)
    *   **Link Crear Usuario:** [http://localhost:8080/swagger-ui/index.html#/Usuarios/create](http://localhost:8080/swagger-ui/index.html#/Usuarios/create)
*   **Ejemplo de Código:**
    ```java
    @PostMapping // Recibe el pedido en la URL /api/v1/usuarios
    public ResponseEntity<UsuarioDTO> create(@Valid @RequestBody UsuarioDTO dto) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.create(dto));
    }
    ```

### 📂 2. Carpeta `dto` (El Guardia de Seguridad / El Filtro)
*   **Responsabilidad:** Validar los datos de entrada. Evita que entren datos dañados o maliciosos.
*   **Lenguaje Sencillo:** Es el que te pide la cédula en la puerta. Si intentas decir que tu género es "Robot", él te frena ahí mismo.
*   **Término Técnico:** **Data Transfer Object**. Implementa anotaciones de **Jakarta Validation**.
*   **🔗 Link para Postman:** [http://localhost:8080/api/v1/usuarios](http://localhost:8080/api/v1/usuarios)
*   **Ejemplo de Código:**
    ```java
    public class UsuarioDTO {
        @NotBlank(message = "El nombre es obligatorio")
        private String nombre;
        
        @Pattern(regexp = "^(Masculino|Femenino|No Binario)$")
        private String genero; // <-- El guardia de seguridad (Validación)
    }
    ```

### 📂 3. Carpeta `service` (El Chef / El Contador / La Lógica)
*   **Responsabilidad:** Procesar la información. Es el que realmente hace el trabajo difícil de la aplicación.
*   **Lenguaje Sencillo:** Es el que sabe cocinar. Sabe cómo guardar un usuario y cómo arreglar errores (como el del género que corregimos).
*   **Término Técnico:** **Business Logic Layer**. Contiene la lógica de negocio pura.
*   **Ejemplo de Código:**
    ```java
    public Usuario update(UUID id, UsuarioDTO usuarioDTO) {
        Usuario usuario = repository.findById(id).orElseThrow();
        usuario.setGenero(usuarioDTO.getGenero()); // <-- La corrección maestra
        return repository.save(usuario);
    }
    ```

### 📂 4. Carpeta `mapper` (El Traductor Internacional)
*   **Responsabilidad:** Convertir objetos. Pasa los datos de un formato de "Internet" a un formato de "Base de Datos".
*   **Lenguaje Sencillo:** Traduce del idioma de la "Web" al idioma de la "Cocina".
*   **Término Técnico:** **Model Mapper**. Mapea Atributos entre clases.
*   **Ejemplo de Código:**
    ```java
    public Usuario toEntity(UsuarioDTO dto) {
        Usuario entity = new Usuario();
        entity.setGenero(dto.getGenero()); // Copia el dato de un lado al otro
        return entity;
    }
    ```

### 📂 5. Carpeta `repository` (La Bóveda / El Archivero)
*   **Responsabilidad:** Comunicación con la Base de Datos. Sabe cómo guardar y sacar cosas del disco duro.
*   **Lenguaje Sencillo:** Es el cajón donde se guardan los archivos. Él sabe exactamente dónde está cada papel.
*   **Término Técnico:** **Persistence Layer / JPA Repository**.
*   **Ejemplo de Código:**
    ```java
    // Spring Data JPA crea automáticamente todas las consultas SQL
    public interface UsuarioRepository extends JpaRepository<Usuario, UUID> {
    }
    ```

### 📂 6. Carpeta `model` (El Formulario Oficial / El Acta)
*   **Responsabilidad:** Representar la tabla. Define cómo se ve el dato guardado en el disco.
*   **Lenguaje Sencillo:** Es el papel oficial firmado donde se anota todo.
*   **Término Técnico:** **JPA Entity**. Es el mapeo Objeto-Relacional (ORM).
*   **Ejemplo de Código:**
    ```java
    @Entity // Esto le dice a Java: "Crea una tabla en Postgres para esto"
    public class Usuario {
        @Id
        private UUID id;
        private String nombre;
        private String genero; // El campo que evolucionamos
    }
    ```
