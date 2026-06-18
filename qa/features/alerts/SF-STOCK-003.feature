@Alerts @Stock @SF-STOCK-003
Feature: Umbral de Alerta - Eliminacion de umbral (SF-STOCK-003)
  Como QA Analyst
  Quiero comprobar que el sistema permite eliminar un umbral de stock configurado
  Para certificar que el endpoint de eliminacion de alertas funciona correctamente

  Background:
    Given el usuario tiene un rol valido para eliminar alertas de stock

  Scenario: Eliminar un umbral de stock exitosamente
    Given existe un umbral de stock configurado en el sistema
    When envia una solicitud DELETE al endpoint de alertas de stock con un id valido
    Then el sistema responde con codigo 200
    And el umbral ya no figura en la lista de alertas configuradas

  Scenario: Fallar al eliminar un umbral inexistente
    When envia una solicitud DELETE al endpoint de alertas de stock con un id que no existe
    Then el sistema responde con codigo 404
    And el sistema informa que el umbral no fue encontrado

  Scenario: Fallar al eliminar un umbral sin autorizacion
    Given el usuario no tiene permisos para eliminar alertas de stock
    When envia una solicitud DELETE al endpoint de alertas de stock
    Then el sistema responde con codigo 403
    And el sistema informa que no esta autorizado
