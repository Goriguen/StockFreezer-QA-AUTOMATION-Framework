@FREEZ-164 @API @SEC @SF-SEC-001
Feature: Autorización por Roles (RBAC) - RN-10 (SF-SEC-001)

  Background:
    Given que existe un usuario registrado con username "<usuario ADMIN>", password "<credenciales válidas>" y rol "ADMIN"
    And que existe un usuario registrado con username "<usuario CHEF>", password "<credenciales válidas>" y rol "CHEF"
    And que existe un usuario registrado con username "<usuario AYUDANTE>", password "<credenciales válidas>" y rol "AYUDANTE"

  Scenario: ADMIN puede acceder a la gestión de usuarios
    Given el usuario "<usuario ADMIN>" ha iniciado sesión con password "<credenciales válidas>"
    When se realiza una petición POST a "/api/users" creando un nuevo usuario con el token JWT
    Then el sistema responde con código 201

  Scenario: CHEF no puede gestionar usuarios
    Given el usuario "<usuario CHEF>" ha iniciado sesión con password "<credenciales válidas>"
    When se realiza una petición POST a "/api/users" creando un nuevo usuario con el token JWT
    Then el sistema responde con código 403

  Scenario: AYUDANTE puede ver el inventario de productos
    Given el usuario "<usuario AYUDANTE>" ha iniciado sesión con password "<credenciales válidas>"
    When se realiza una petición GET a "/api/productos" con el token JWT en el header Authorization
    Then el sistema responde con código 200

  Scenario: AYUDANTE no puede borrar productos
    Given el usuario "<usuario AYUDANTE>" ha iniciado sesión con password "<credenciales válidas>"
    When se realiza un DELETE a un endpoint de productos con el token JWT
    Then el sistema responde con código 403

  Scenario: CHEF puede ejecutar operaciones destructivas (autorización aprobada)
    Given el usuario "<usuario CHEF>" ha iniciado sesión con password "<credenciales válidas>"
    When se realiza un DELETE a un endpoint de productos con un id inexistente con el token JWT
    Then el sistema responde con código 404

  Scenario: Acceso anónimo es rechazado con 401
    When se realiza una petición GET a "/api/productos" sin header Authorization
    Then el sistema responde con código 401
