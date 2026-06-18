@Alerts @Stock @SF-STOCK-002
Feature: Umbral de Alerta - Consulta de umbrales configurados (SF-STOCK-002)
  Como QA Analyst
  Quiero comprobar que el sistema permite consultar los umbrales de stock configurados
  Para certificar que el endpoint de lectura de alertas funciona correctamente

  Background:
    Given el usuario tiene un rol valido para consultar alertas de stock

  Scenario: Listar todos los umbrales configurados exitosamente
    Given existen umbrales de stock configurados en el sistema
    When envia una solicitud GET al endpoint de alertas de stock
    Then el sistema responde con codigo 200
    And la respuesta contiene la lista de umbrales configurados

  Scenario: Listar umbrales cuando no hay ninguno configurado
    Given no existen umbrales de stock configurados en el sistema
    When envia una solicitud GET al endpoint de alertas de stock
    Then el sistema responde con codigo 200
    And la respuesta contiene una lista vacia
