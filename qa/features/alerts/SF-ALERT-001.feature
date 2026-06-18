@Alerts @SF-ALERT-001
Feature: Barrido Programado - Deteccion de productos bajo umbral (SF-ALERT-001)
  Como QA Analyst
  Quiero comprobar que el sistema detecta productos por debajo del stock minimo configurado
  Para certificar que el barrido programado funciona correctamente

  Background:
    Given existe al menos un umbral de stock minimo configurado en el sistema

  Scenario: El barrido detecta un producto bajo umbral y genera la alerta
    Given existe un producto cuya cantidad actual es menor al umbral configurado
    When se ejecuta el barrido programado
    Then el sistema identifica el producto como bajo stock
    And genera una alerta visible para el usuario autorizado a recibirla
