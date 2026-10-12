package com.example.demo;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

@SpringBootTest(properties = "app.secret.value=mi-secreto-de-prueba")
@AutoConfigureMockMvc
class InfoControllerTest {

    @Autowired
    MockMvc mvc;

    @Test
    void secretEndpointReturnsInjectedValue() throws Exception {
        mvc.perform(get("/api/secret"))
           .andExpect(status().isOk())
           .andExpect(jsonPath("$.value").value("mi-secreto-de-prueba"));
    }

    @Test
    void configEndpointReturnsSimulatedConfig() throws Exception {
        mvc.perform(get("/api/config"))
           .andExpect(status().isOk())
           .andExpect(jsonPath("$.environment").value("development"));
    }
}
