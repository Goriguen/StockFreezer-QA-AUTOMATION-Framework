import re
from playwright.sync_api import expect


def test_login_exitoso(page, base_url, credenciales):
    page.goto(base_url)
    page.get_by_label("Usuario").fill(credenciales["username"])
    page.get_by_label("Contraseña").fill(credenciales["password"])
    page.get_by_role("button", name="Ingresar").click()
    expect(page).to_have_url(re.compile(".*/inventory"))


def test_login_fallido(page, base_url):
    page.goto(base_url)
    page.get_by_label("Usuario").fill("usuario_invalido")
    page.get_by_label("Contraseña").fill("password_invalido")
    page.get_by_role("button", name="Ingresar").click()
    expect(page.get_by_text("Usuario o contraseña incorrectos")).to_be_visible()


def test_login_sin_datos(page, base_url):
    page.goto(base_url)
    page.get_by_role("button", name="Ingresar").click()
    expect(page).not_to_have_url(re.compile(".*/inventory"))
