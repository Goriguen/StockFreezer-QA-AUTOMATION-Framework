@FREEZ-162 @API @SF-API-003
Feature: Gestión de Usuarios - Seguridad y Roles (SF-API-003)

  Background:
    Given existe una sesión de administrador activa

  Scenario: Asignación de roles según la jerarquía RN-10
    Given el sistema de roles configurado según la RN-10
    When se crea un usuario con username "<usuario CHEF>", password "<credenciales válidas>" y rol "CHEF"
    Then el sistema asigna el rol y el usuario es registrado con código 201
    And el usuario posee el rol "CHEF" en su perfil

  Scenario: La contraseña debe almacenarse hasheada
    Given un usuario registrado con username "<usuario COCINERO>", password "<password en texto plano>" y rol "COCINERO"
    When se consulta el registro del usuario directamente en el sistema de persistencia
    Then el campo password almacenado muestra una cadena cifrada con BCrypt
    And no existe rastro del texto plano "<password en texto plano>" en el almacenamiento
