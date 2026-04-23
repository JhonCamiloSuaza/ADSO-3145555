package com.exercise.api.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Configuración de Swagger / OpenAPI 3.0
 * Acceder a la documentación en: http://localhost:8080/swagger-ui.html
 */
@Configuration
public class SwaggerConfig {

    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("📚 Exercise API - Gestión de Préstamos de Libros")
                        .version("1.0.0")
                        .description("API REST para gestionar usuarios, libros y préstamos. "
                                + "Implementa operaciones CRUD completas para las 3 entidades.")
                        .contact(new Contact()
                                .name("Exercise Team")
                                .email("exercise@email.com"))
                        .license(new License()
                                .name("MIT License")
                                .url("https://opensource.org/licenses/MIT")));
    }
}
