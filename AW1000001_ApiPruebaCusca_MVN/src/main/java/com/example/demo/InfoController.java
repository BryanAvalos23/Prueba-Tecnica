package com.example.demo;

import java.net.InetAddress;
import java.time.Instant;
import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class InfoController {

    private final SecretProperties secret;
    private final SimulatedConfigProperties config;

    public InfoController(SecretProperties secret, SimulatedConfigProperties config) {
        this.secret = secret;
        this.config = config;
    }

    /** Endpoint 1: retorna el valor de la variable de entorno inyectada (APP_SECRET). */
    @GetMapping("/secret")
    public Map<String, Object> secret() {
        Map<String, Object> body = base();
        body.put("variable", "APP_SECRET");
        body.put("value", secret.mask() ? mask(secret.value()) : secret.value());
        body.put("masked", secret.mask());
        return body;
    }

    /** Endpoint 2: expone la configuracion simulada leida del archivo local. */
    @GetMapping("/config")
    public Map<String, Object> config() {
        Map<String, Object> body = base();
        body.put("name", config.name());
        body.put("environment", config.environment());
        body.put("message", config.message());
        body.put("featureEnabled", config.featureEnabled());
        return body;
    }

    // El hostname (nombre del pod) permite ver el balanceo entre las 2 replicas.
    private Map<String, Object> base() {
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("pod", hostname());
        body.put("timestamp", Instant.now().toString());
        return body;
    }

    private static String hostname() {
        try {
            return InetAddress.getLocalHost().getHostName();
        } catch (Exception e) {
            return "unknown";
        }
    }

    private static String mask(String value) {
        if (value.length() <= 2) {
            return "****";
        }
        return value.substring(0, 2) + "*".repeat(value.length() - 2);
    }
}
