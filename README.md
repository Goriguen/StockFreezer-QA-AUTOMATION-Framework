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
| Postman + Newman CLI | Colección de API tests ejecutable por CLI |
| Gherkin | Especificación BDD de escenarios de negocio |

---

## Estructura del proyecto

```
StockFreezer-QA-AUTOMATION-Framework/
│
├── tests/
│   └── api/                        # Tests de API con pytest + requests
│       ├── test_auth.py
│       └── test_cajones.py
│
├── qa/
│   ├── features/                   # Especificaciones BDD en Gherkin
│   │   ├── api/                    # Cajones y Productos
│   │   ├── auth/                   # Autenticación y usuarios
│   │   ├── alerts/                 # Alertas y umbrales de stock
│   │   ├── ia/                     # Validación semántica con IA
│   │   └── security/               # RBAC y seguridad
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
```

---

## Ejecución

### API tests con pytest

```bash
pytest -v
```

### Colección Newman

```bash
newman run "qa/postman/StockFreezer QA Automation.postman_collection.json" -e "qa/postman/StockFreezer QA.postman_environment.json"
```

> El environment file con credenciales no está incluido en el repositorio (`.gitignore`). Configurar las variables localmente antes de ejecutar.

---

## Enfoque metodológico

Dos capas de testing complementarias:

**1. Especificación BDD (Gherkin)** — escenarios en lenguaje de negocio que describen el comportamiento esperado del sistema. Independientes de la implementación técnica.

**2. Automatización de API (pytest + Newman)** — ejecución automatizada contra el entorno demo real. Cada suite corre de forma independiente desde un estado limpio.

---

## Autor

Gabriel Origüen
QA Automation · IA Analyst
LinkedIn: [gabriel-origuen](https://www.linkedin.com/in/gabriel-origuen)
