# Bug encontrado: Race Condition en navegación post-login

**Fecha:** 20/06/2026  
**Test afectado:** `test_admin_users_redirige_guest_a_inventory`  
**Estado:** Corregido

---

## Qué mostró el test

```
AssertionError: Page URL expected to be 're.compile('.*/inventory')'
Actual value: https://demo.g-stockfreezer.com/login
```

Se esperaba que GUEST fuera redirigido a `/inventory` al intentar acceder a `/admin/users`.  
En cambio, la app lo mandó al `/login` — como si no estuviera logueado.

---

## Por qué pasó

El test hacía esto:

```python
page.get_by_role("button", name="Ingresar").click()  # dispara el login
page.goto(f"{base_url}/admin/users")                 # navega INMEDIATAMENTE
```

El `click()` no espera a que el login termine. Dispara el request a la API y sigue.  
Mientras la app procesaba la respuesta y guardaba el JWT, el test ya estaba navegando a `/admin/users`.  
Cuando `ProtectedRoute` revisó si había sesión activa, el JWT todavía no estaba guardado → no login → redirect a `/login`.

Esto se llama **race condition**: dos procesos corriendo en paralelo (el login y la navegación) compitiendo por el mismo recurso (el JWT), con resultado impredecible según cuál termina primero.

---

## Cómo se corrigió

Se agregó una línea de espera entre el login y la navegación:

```python
page.get_by_role("button", name="Ingresar").click()
expect(page).to_have_url(re.compile(".*/inventory"))  # ← espera que el login termine
page.goto(f"{base_url}/admin/users")                  # recién ahora navega
expect(page).to_have_url(re.compile(".*/inventory"))
```

`expect(...).to_have_url(...)` no es solo un assert — también es un **punto de sincronización**.  
Playwright queda bloqueado ahí hasta que la URL cambia a `/inventory` (o pasan 5 segundos y falla).  
Cuando avanza, el JWT ya está guardado y la navegación siguiente funciona correctamente.

---

## Regla general

> Siempre esperá que una acción termine antes de ejecutar la siguiente.

En tests E2E, las acciones son asincrónicas. Un click, un submit, una navegación — todos tardan.  
Si no esperás, estás asumiendo que "ya terminó" cuando en realidad no.

Cualquier vez que un test falle con una URL o estado inesperado justo después de un login o submit,
lo primero que revisás es si falta un punto de sincronización.
