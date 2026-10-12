package com.example.demo;

import jakarta.validation.constraints.NotBlank;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.validation.annotation.Validated;

/**
 * Secreto inyectado por el pipeline (Vault -> variable de entorno APP_SECRET).
 * Si la variable no existe o esta vacia, la app NO arranca (fail-fast).
 */
@Validated
@ConfigurationProperties(prefix = "app.secret")
public record SecretProperties(@NotBlank String value, boolean mask) {
}
