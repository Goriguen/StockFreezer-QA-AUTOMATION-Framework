# Convenciones del proyecto — StockFreezer QA Automation Framework

## Commits

Formato obligatorio: `tipo: descripción en español, lenguaje técnico de nivel Junior`

### Tipos permitidos

| Tipo | Cuándo usarlo |
|------|---------------|
| `update:` | Agregar o modificar algo (tests, config, docs, features) |
| `fix:` | Corregir algo que estaba mal |
| `delete:` | Eliminar archivos o contenido |

### Reglas
- Descripción en **español**
- Lenguaje técnico claro, sin jerga avanzada
- Agregar ticket al final si aplica: `update: tests de login con pytest (SF-AUTH-001)`
- Sin Co-Authored-By ni atribución a IA
- Sin conventional commits estilo Angular (`feat(scope):`, `chore:`, etc.)

### Ejemplos correctos
```
update: tests de API para autenticación y cajones con pytest
update: colección Postman con assertions para Auth, Cajones y Productos
update: README con stack real y estructura actual del proyecto
delete: features de infraestructura con datos sensibles
fix: método incorrecto en test de listar productos
update: configuración inicial del proyecto - pytest, gitignore y fixtures
```
