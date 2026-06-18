@API @Product @SF-PRODUCT-005
Feature: Gestion de Productos - Actualizacion de Nombre (SF-PRODUCT-005)
  Como QA Analyst
  Quiero comprobar que el sistema permite actualizar el nombre de un producto
  Para certificar que el endpoint de actualizacion parcial funciona correctamente

  Background:
    Given el usuario tiene un rol valido para actualizar productos

  Scenario: Actualizar el nombre de un producto exitosamente
    Given existe un producto registrado en el sistema
    When envia una solicitud PATCH al endpoint de productos con un nombre valido
    Then el sistema responde con codigo 200
    And el producto refleja el nombre actualizado en el inventario

  Scenario: Fallar al actualizar el nombre de un producto inexistente
    When envia una solicitud PATCH al endpoint de productos con un id que no existe
    Then el sistema responde con codigo 404
    And el sistema informa que el producto no fue encontrado

  Scenario: Fallar al actualizar el nombre sin autorizacion
    Given el usuario no tiene permisos para actualizar productos
    When envia una solicitud PATCH al endpoint de productos
    Then el sistema responde con codigo 403
    And el sistema informa que no esta autorizado
