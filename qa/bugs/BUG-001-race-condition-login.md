# BUG-001 — Race condition en redireccion post-login (GUEST)

| Campo | Valor |
|---|---|
| Resumen | Usuario GUEST es redirigido a `/login` en vez de permanecer en `/inventory` al intentar acceder a `/admin/users`. |
| Pasos para reproducir | 1) Iniciar sesion como usuario GUEST. 2) Inmediatamente despues de hacer click en "Ingresar", sin esperar a que la sesion termine de cargar, navegar a `/admin/users`. 3) Observar la URL resultante. |
| Resultado esperado | El login termina de procesarse (JWT guardado) antes de la siguiente navegacion; un GUEST que intenta acceder a `/admin/users` es redirigido a `/inventory` por no tener permisos de admin. |
| Resultado actual | La navegacion a `/admin/users` ocurre antes de que el JWT se guarde. Al no detectar sesion activa, la app redirige a `/login`, como si el usuario nunca se hubiera autenticado. |
| Entorno | demo.g-stockfreezer.com — detectado via test automatizado Playwright (`tests/e2e/test_inventory.py::test_admin_users_redirige_guest_a_inventory`) |
| Severidad | Baja-Media — es una condicion de carrera dependiente del timing exacto entre el click de login y la navegacion siguiente. En uso manual normal es poco probable que se dispare (un humano tiene latencia natural entre acciones); se detecto porque un test automatizado puede disparar ambos eventos sin esa latencia. |
| Prioridad | Baja — ya fue corregida el mismo dia que se detecto. |
| Estado | Corregido (20/06/2026) — se agrego un punto de sincronizacion (`expect(page).to_have_url(...)`) entre el login y la navegacion siguiente. |

## Causa raiz

Race condition: el `click()` en el boton de login dispara la peticion de autenticacion pero no espera su resolucion. El test continuaba con la navegacion siguiente antes de que el JWT quedara guardado, generando un resultado inconsistente segun cual de los dos procesos terminaba primero.

## Regla general aprendida

Siempre esperar que una accion asincronica (login, submit, navegacion) termine antes de ejecutar la siguiente. En Playwright, `expect(...).to_have_url(...)` no es solo un assert — tambien es un punto de sincronizacion.
