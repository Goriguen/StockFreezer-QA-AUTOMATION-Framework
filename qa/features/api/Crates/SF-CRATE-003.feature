@API @Crate @SF-CRATE-003
Feature: Gestion de Cajones - Actualizacion (SF-CRATE-003)
  Como QA Analyst
  Quiero comprobar que el sistema permite actualizar un cajon existente
  Para certificar que el endpoint de actualizacion funciona correctamente

  Background:
    Given el usuario tiene un rol valido para actualizar cajones

  Scenario: Actualizar un cajon exitosamente
    Given existe un cajon registrado en el sistema
    When envia una solicitud PUT al endpoint de cajones con datos validos
    Then el sistema responde con codigo 200
    And la respuesta contiene el cajon con los datos actualizados

  Scenario: Fallar al actualizar un cajon inexistente
    When envia una solicitud PUT al endpoint de cajones con un id que no existe
    Then el sistema responde con codigo 404
    And el sistema informa que el cajon no fue encontrado

  Scenario: Fallar al actualizar un cajon sin autorizacion
    Given el usuario no tiene permisos para actualizar cajones
    When envia una solicitud PUT al endpoint de cajones
    Then el sistema responde con codigo 403
    And el sistema informa que no esta autorizado
