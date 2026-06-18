@FREEZ-162 @API @SF-API-002
Feature: Gestión de Usuarios - Identidad Única (SF-API-002)

  Background:
    Given existe una sesión de administrador activa
    And que ya existe un usuario registrado con username "<usuario autorizado>" y password "<credenciales válidas>" y rol "ADMIN"

  Scenario: Fallar al crear un usuario con nombre duplicado
    When envía una solicitud POST a "/api/users" con username "<usuario autorizado>", password "<otra password válida>" y rol "CHEF"
    Then el sistema responde con código 409
    And el registro no es duplicado en la base de datos
