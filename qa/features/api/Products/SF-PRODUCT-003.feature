@API @Product @SF-PRODUCT-003
Feature: Gestion de Productos - Consulta (SF-PRODUCT-003)
  Como QA Analyst
  Quiero comprobar que el sistema permite consultar los productos del inventario
  Para certificar que el endpoint de lectura de productos funciona correctamente

  Background:
    Given el usuario tiene un rol valido para consultar productos

  Scenario: Listar todos los productos exitosamente
    Given existen productos registrados en el sistema
    When envia una solicitud GET al endpoint de productos
    Then el sistema responde con codigo 200
    And la respuesta contiene la lista de productos registrados

  Scenario: Listar productos cuando no hay ninguno registrado
    Given no existen productos registrados en el sistema
    When envia una solicitud GET al endpoint de productos
    Then el sistema responde con codigo 200
    And la respuesta contiene una lista vacia
