@FREEZ-163 @API @SF-API-004
Feature: Autenticación de Usuarios - Login (SF-API-004)

  Background:
    Given que existe un usuario registrado con username "<usuario autorizado>", password "<credenciales válidas>" y rol "ADMIN"

  Scenario: Login exitoso retorna token JWT
    When se envía una solicitud de login con username "<usuario autorizado>" y password "<credenciales válidas>"
    Then el sistema responde con código 200
    And la respuesta contiene un token JWT en el campo "data.token"

  Scenario: Login con contraseña incorrecta retorna 401
    When se envía una solicitud de login con username "<usuario autorizado>" y password "<password incorrecta>"
    Then el sistema responde con código 401
    And la respuesta no contiene token JWT

  Scenario: Login con usuario inexistente retorna 401
    When se envía una solicitud de login con username "usuario_inexistente" y password "<credenciales válidas>"
    Then el sistema responde con código 401
    And la respuesta no contiene token JWT
