# StockFreezer QA Automation Framework

[![E2E Tests](https://github.com/Goriguen/StockFreezer-QA-AUTOMATION-Framework/actions/workflows/e2e.yml/badge.svg?branch=main)](https://github.com/Goriguen/StockFreezer-QA-AUTOMATION-Framework/actions/workflows/e2e.yml)

Framework de automatización de pruebas para [G-StockFreezer](https://demo.g-stockfreezer.com) — sistema de gestión de inventario gastronómico con integración de IA.

Desarrollado por **Gabriel Origüen** · [LinkedIn](https://www.linkedin.com/in/gabriel-origuen)

---

## Stack tecnológico

| Herramienta | Rol |
|-------------|-----|
| Python 3.12 | Lenguaje del framework |
| pytest + requests | API testing automatizado |
| pytest + Playwright | E2E testing automatizado a través de navegador real |
| Postman + Newman CLI | Colección de API tests ejecutable por CLI |
| Gherkin | Especificación BDD de escenarios de negocio |

---

## Estructura del proyecto

```
StockFreezer-QA-AUTOMATION-Framework/
│
├── tests/
│   ├── api/                        # Tests de API con pytest + requests, por dominio
│   │   ├── auth/
│   │   │   └── test_auth.py
│   │   └── Crates/
│   │       └── test_cajones.py
│   └── e2e/                        # Tests E2E con Playwright (a través del navegador), por dominio
│       ├── auth/
│       │   └── test_login.py
│       ├── alerts/
│       │   └── test_alerts.py
│       └── security/
│           └── test_inventory.py
│
├── qa/
│   ├── features/                   # Especificaciones BDD en Gherkin
│   │   ├── api/                    # Cajones y Productos
│   │   ├── auth/                   # Autenticación y usuarios
│   │   ├── alerts/                 # Alertas y umbrales de stock
│   │   ├── ia/                     # Validación semántica con IA
│   │   └── security/               # RBAC y seguridad
│   ├── test-cases/                 # Test Cases manuales (CSV), un archivo por ticket
│   │   └── api/crate/
│   ├── bugs/                       # Reportes de bugs encontrados
│   ├── postman/                    # Colección Postman (Newman)
│   └── reports/
│       └── newman/                 # Evidencia de ejecución
│
├── conftest.py                     # Fixtures globales de pytest
├── pytest.ini
└── requirements.txt
```

---

## Áreas cubiertas

- Autenticación y control de acceso por roles (RBAC)
- Gestión de inventario (cajones y productos)
- Validación semántica asistida por IA (DeepSeek)
- Configuración de alertas de stock mínimo

---

## Instalación

```bash
git clone https://github.com/Goriguen/StockFreezer-QA-AUTOMATION-Framework.git
cd StockFreezer-QA-AUTOMATION-Framework

pip install -r requirements.txt
```

Creá un archivo `.env` en la raíz con las credenciales del entorno de prueba:

```
BASE_URL=https://demo.g-stockfreezer.com
TEST_USER=<usuario de prueba>
TEST_PASS=<password>
TEST_USER_GUEST=<usuario de prueba con rol GUEST>
TEST_PASS_GUEST=<password>
```

---

## Ejecución

### Tests de API (pytest + requests)

```bash
pytest tests/api/ -v
```

### Tests E2E (pytest + Playwright)

```bash
playwright install --with-deps chromium
pytest tests/e2e/ -v
```

> En el pipeline de CI (GitHub Actions, `.github/workflows/e2e.yml`) solo corren los tests de `tests/e2e/`. Los de `tests/api/` existen y corren bien en local, pero todavía no están integrados al workflow.

### Colección Newman

```bash
newman run "qa/postman/StockFreezer QA Automation.postman_collection.json" -e "qa/postman/StockFreezer QA.postman_environment.json"
```

> El environment file con credenciales no está incluido en el repositorio (`.gitignore`). Configurar las variables localmente antes de ejecutar.

---

## Enfoque metodológico

Capas de testing complementarias, con más pruebas rápidas y baratas abajo y menos pruebas lentas y costosas arriba (pirámide de testing):

**1. Especificación BDD (Gherkin)** — escenarios en lenguaje de negocio que describen el comportamiento esperado del sistema. Independientes de la implementación técnica.

**2. Automatización de API (pytest + requests, con colección Postman/Newman equivalente)** — tests rápidos, sin interfaz, contra el backend directo. Ideal para validaciones y casos de error puntuales.

**3. Automatización E2E (pytest + Playwright)** — tests a través del navegador real, para validar UI y permisos visibles por rol que no se pueden verificar solo con la API.

**4. Test Cases manuales (`qa/test-cases/`, CSV)** — casos todavía sin automatizar, documentados para ejecución manual y como registro de qué falta cubrir.

Cada suite automatizada corre de forma independiente contra el entorno demo real, desde un estado limpio.

---

## Autor

Gabriel Origüen
QA Automation · IA Analyst
LinkedIn: [gabriel-origuen](https://www.linkedin.com/in/gabriel-origuen)
