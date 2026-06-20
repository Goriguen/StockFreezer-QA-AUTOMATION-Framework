import re
from playwright.sync_api import expect


def test_boton_alertas_visible_para_admin(page, base_url, credenciales):
    page.goto(base_url)
    page.get_by_label("Usuario").fill(credenciales["username"])
    page.get_by_label("Contraseña").fill(credenciales["password"])
    page.get_by_role("button", name="Ingresar").click()
    expect(page).to_have_url(re.compile(".*/inventory"))
    expect(page.get_by_title("Gestión de Alertas")).to_be_visible()


def test_abrir_modal_alertas_admin(page, base_url, credenciales):
    page.goto(base_url)
    page.get_by_label("Usuario").fill(credenciales["username"])
    page.get_by_label("Contraseña").fill(credenciales["password"])
    page.get_by_role("button", name="Ingresar").click()
    page.get_by_title("Gestión de Alertas").click()
    expect(page.get_by_role("heading", name="Gestión de Alertas")).to_be_visible()
