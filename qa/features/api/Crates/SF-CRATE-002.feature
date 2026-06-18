@API @Crate @SF-CRATE-002
Feature: Gestion de Cajones - Consulta (SF-CRATE-002)
  Como QA Analyst
  Quiero comprobar que el sistema permite consultar cajones
  Para certificar que los endpoints de lectura funcionan correctamente

  Background:
    Given el usuario tiene un rol valido para consultar cajones

  Scenario: Listar todos los cajones exitosamente
    Given existen cajones registrados en el sistema
    When envia una solicitud GET al endpoint de cajones
    Then el sistema responde con codigo 200
    And la respuesta contiene la lista de cajones registrados

  Scenario: Listar cajones cuando no hay ninguno registrado
    Given no existen cajones registrados en el sistema
    When envia una solicitud GET al endpoint de cajones
    Then el sistema responde con codigo 200
    And la respuesta contiene una lista vacia

  Scenario: Ver el detalle de un cajon existente
    Given existe un cajon registrado en el sistema
    When envia una solicitud GET al endpoint de cajones con un id valido
    Then el sistema responde con codigo 200
    And la respuesta contiene el detalle del cajon con sus productos

  Scenario: Fallar al consultar un cajon inexistente
    When envia una solicitud GET al endpoint de cajones con un id que no existe
    Then el sistema responde con codigo 404
    And el sistema informa que el cajon no fue encontrado
