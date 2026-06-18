@API @Product @SF-PRODUCT-001
Feature: Gestion de Productos - Agregar un Producto al Cajon (SF-PRODUCT-001)
  Como QA Analyst
  Quiero comprobar que el sistema permite agregar productos a un cajon
  Para certificar que el endpoint de creacion de productos funciona correctamente

  Background:
    Given el usuario tiene un rol valido para agregar productos

  Scenario: Agregar un producto exitosamente
    Given existe un cajon con capacidad disponible
    When envia una solicitud POST al endpoint de productos con nombre, tipo, cantidad y sector validos
    Then el sistema responde con codigo 201
    And el producto queda registrado dentro del cajon elegido

  Scenario: Fallar al agregar un producto con cantidad negativa
    When envia una solicitud POST al endpoint de productos con cantidad negativa
    Then el sistema responde con codigo 400
    And el sistema informa que la cantidad debe ser un numero entero positivo

  Scenario: Fallar al agregar un producto a un cajon lleno
    Given el cajon elegido no tiene capacidad disponible
    When envia una solicitud POST al endpoint de productos
    Then el sistema responde con codigo 400
    And el sistema informa que el cajon no tiene capacidad disponible
