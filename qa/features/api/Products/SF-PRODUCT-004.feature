@API @Product @SF-PRODUCT-004
Feature: Gestion de Productos - Agregar Lote al Cajon (SF-PRODUCT-004)
  Como QA Analyst
  Quiero comprobar que el sistema permite agregar multiples productos en una sola operacion
  Para certificar que el endpoint de ingreso por lote funciona correctamente

  Background:
    Given el usuario tiene un rol valido para agregar productos

  Scenario: Agregar un lote de productos exitosamente
    Given existe un cajon con capacidad suficiente para el lote
    When envia una solicitud POST al endpoint de lote con una lista de productos validos
    Then el sistema responde con codigo 201
    And todos los productos del lote quedan registrados dentro del cajon elegido

  Scenario: Fallar al agregar un lote vacio
    When envia una solicitud POST al endpoint de lote con una lista vacia
    Then el sistema responde con codigo 400
    And el sistema informa que el lote no puede estar vacio

  Scenario: Fallar al agregar un lote sin autorizacion
    Given el usuario no tiene permisos para agregar productos
    When envia una solicitud POST al endpoint de lote
    Then el sistema responde con codigo 403
    And el sistema informa que no esta autorizado
