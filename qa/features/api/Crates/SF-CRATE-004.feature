@API @Crate @SF-CRATE-004
Feature: Gestion de Cajones - Eliminacion (SF-CRATE-004)
  Como QA Analyst
  Quiero comprobar que el sistema permite eliminar cajones vacios
  Para certificar que el endpoint de eliminacion funciona correctamente y respeta las reglas de negocio

  Background:
    Given el usuario tiene un rol valido para eliminar cajones

  Scenario: Eliminar un cajon vacio exitosamente
    Given existe un cajon registrado en el sistema sin productos
    When envia una solicitud DELETE al endpoint de cajones con un id valido
    Then el sistema responde con codigo 200
    And el cajon ya no figura en el inventario

  Scenario: Fallar al eliminar un cajon que contiene productos
    Given existe un cajon registrado en el sistema con productos en su interior
    When envia una solicitud DELETE al endpoint de cajones con ese id
    Then el sistema responde con codigo 409
    And el sistema informa que no se puede eliminar un cajon con productos

  Scenario: Fallar al eliminar un cajon inexistente
    When envia una solicitud DELETE al endpoint de cajones con un id que no existe
    Then el sistema responde con codigo 404
    And el sistema informa que el cajon no fue encontrado

  Scenario: Fallar al eliminar un cajon sin autorizacion
    Given el usuario no tiene permisos para eliminar cajones
    When envia una solicitud DELETE al endpoint de cajones
    Then el sistema responde con codigo 403
    And el sistema informa que no esta autorizado
