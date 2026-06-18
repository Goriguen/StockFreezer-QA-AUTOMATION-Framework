@FREEZ-162 @API @SF-API-001
Feature: Gestión de Usuarios - Creación (SF-API-001)

  Background:
    Given existe una sesión de administrador activa

  Scenario: Crear un usuario exitosamente
    Given un administrador que desea registrar un nuevo usuario
    When envía una solicitud POST a "/api/users" con username "<usuario autorizado>", password "<credenciales válidas>" y rol "ADMIN"
    Then el sistema responde con código 201
    And el usuario "<usuario autorizado>" queda registrado con los datos proporcionados

  Scenario: Fallar al crear un usuario con nombre demasiado corto
    Given la regla de integridad de datos RN-12 está activa
    When envía una solicitud POST a "/api/users" con username "<usuario muy corto>", password "<credenciales válidas>" y rol "ADMIN"
    Then el sistema responde con código 400
    And el mensaje de error indica que el nombre debe tener al menos 3 caracteres
