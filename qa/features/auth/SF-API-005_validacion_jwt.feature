@FREEZ-163 @API @SF-API-005
Feature: Autenticación de Usuarios - Validación de Token JWT (SF-API-005)

  Background:
    Given que existe un usuario registrado con username "<usuario autorizado>", password "<credenciales válidas>" y rol "ADMIN"
    And el usuario ha iniciado sesión y posee un token JWT válido

  Scenario: Acceso a endpoint protegido con token válido
    When se realiza una petición GET a "/api/crates" con el token JWT en el header Authorization
    Then el sistema responde con código 200

  Scenario: Acceso a endpoint protegido sin token retorna 401
    When se realiza una petición GET a "/api/crates" sin header Authorization
    Then el sistema responde con código 401

  Scenario: Acceso a endpoint protegido con token inválido retorna 401
    When se realiza una petición GET a "/api/crates" con el token "token.invalido.fake"
    Then el sistema responde con código 401
