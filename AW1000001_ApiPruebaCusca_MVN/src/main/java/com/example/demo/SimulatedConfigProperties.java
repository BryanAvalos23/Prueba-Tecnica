package com.example.demo;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Configuracion simulada leida desde application.yml (archivo local),
 * sobreescribible con variables del sistema.
 */
@ConfigurationProperties(prefix = "app.simulated")
public record SimulatedConfigProperties(String name,
                                        String environment,
                                        String message,
                                        boolean featureEnabled) {
}
