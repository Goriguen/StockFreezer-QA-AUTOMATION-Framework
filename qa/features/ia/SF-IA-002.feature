    @AI @EdgeCases @SF-IA-002
Feature: Validación de Casos Frontera (SF-IA-002)
  Como QA Analyst,
  Quiero verificar el criterio de la IA ante productos que están en el límite de la seguridad alimentaria,
  Para ajustar la sensibilidad del motor de validación.

  Scenario Outline: Validación de productos frontera (casos difíciles)
    When envío una solicitud de validación con el producto "<producto>" y la categoría "<categoria>"
    Then el resultado de validación debe ser "<resultado>"

    Examples:
      | producto            | categoria | resultado |
      | Hielo seco          | HIELO     | false     |
      | Agua Destilada      | BEBIDA    | false     |
      | Sal de mesa         | OTRO      | true      |
      | Esencia de Vainilla | OTRO      | true      |
