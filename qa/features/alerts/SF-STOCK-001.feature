@Alerts @Stock @SF-STOCK-001
Feature: Umbral de Alerta - Configurar stock minimo de un producto (SF-STOCK-001)
  Como QA Analyst
  Quiero comprobar que el sistema permite configurar un umbral de stock minimo
  Para certificar que el endpoint de gestion de alertas funciona correctamente

  Background:
    Given el usuario tiene un rol valido para configurar alertas de stock

  Scenario: Configurar un umbral de stock minimo exitosamente
    When envia una solicitud POST al endpoint de alertas con nombre de producto y cantidad minima validos
    Then el sistema responde con codigo 201
    And el umbral queda registrado en la lista de alertas de stock minimo

  Scenario: Fallar al configurar un umbral sin autorizacion
    Given el usuario no tiene permisos para configurar alertas
    When envia una solicitud POST al endpoint de alertas
    Then el sistema responde con codigo 403
    And el sistema informa que no esta autorizado
