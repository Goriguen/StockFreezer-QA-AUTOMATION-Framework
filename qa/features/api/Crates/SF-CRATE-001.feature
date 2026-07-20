@API @Crate @SF-CRATE-001
Feature: Gestion de Cajones - Creacion (SF-CRATE-001)
  Como QA Analyst
  Quiero comprobar que el sistema permite crear cajones
  Para certificar que el endpoint de creacion funciona correctamente

  Background:
    Given el usuario inicio sesion
    and el usuariotiene un rol valido para crear cajones

  Scenario: Crear un cajon exitosamente
    When envia una solicitud POST al endpoint de cajones con nombre, tipo, capacidad y sector validos
    Then el sistema responde con codigo 201
    And el cajon queda registrado en el inventario

  Scenario: Fallar al crear un cajon con nombre duplicado
    Given ya existe un cajon con el mismo nombre en el sistema
    When envia una solicitud POST al endpoint de cajones con ese nombre
    Then el sistema responde con codigo 409
    And el sistema informa que el nombre ya existe

  Scenario: Fallar al crear un cajon sin autorizacion
    Given el usuario no tiene permisos para crear cajones
    When envia una solicitud POST al endpoint de cajones
    Then el sistema responde con codigo 403
    And el sistema informa que no esta autorizado
