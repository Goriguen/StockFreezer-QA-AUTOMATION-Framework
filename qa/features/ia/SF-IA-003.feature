@AI @Validation @FREEZ-135
Feature: Validación Semántica de Productos (IA)
  Como QA Tester,
  Quiero verificar que la IA valida correctamente los productos,
  Para garantizar la integridad del inventario y evitar ingresos erróneos.

  Background:
    Given que la API de validación inteligente está disponible

  Scenario Outline: Validación de coherencia entre nombre y tipo
    When envío a validar un producto con nombre "<nombre>" y tipo "<tipo>"
    Then la respuesta de la IA debe indicar que el resultado es <valido>
    And el nivel de confianza debe ser superior a 0.8

    Examples:
      | nombre              | tipo     | valido |
      | Milanesas de Pollo  | POLLO    | true   |
      | Filete de Merluza   | PESCADO  | true   |
      | Milanesas de Pollo  | CARNE    | false  |

  Scenario: Rechazo de productos sin sentido semántico
    When envío a validar un producto con nombre "Aire comprimido comestible" y tipo "OTRO"
    Then la respuesta de la IA debe indicar que el resultado es false
    And el motivo debe mencionar que no es un producto alimenticio coherente
