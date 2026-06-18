@API @Product @SF-PRODUCT-002
Feature: Gestion de Productos - Retirar un Producto del Cajon (SF-PRODUCT-002)
  Como QA Analyst
  Quiero comprobar que el sistema permite retirar productos de un cajon
  Para certificar que el endpoint de egreso funciona correctamente y respeta el orden FIFO

  Background:
    Given el usuario tiene un rol valido para retirar productos

  Scenario: Retirar un producto exitosamente respetando FIFO
    Given existe un cajon con al menos un producto disponible
    When envia una solicitud DELETE al endpoint de productos del cajon
    Then el sistema responde con codigo 200
    And el producto retirado es el que tiene la fecha de ingreso mas antigua
    And el producto ya no figura en el inventario del cajon
