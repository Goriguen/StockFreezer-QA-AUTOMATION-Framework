import re
from playwright.sync_api import expect


def test_inventario_visible_guest(page, base_url, credenciales_guest):
    page.goto(base_url)
    page.get_by_label("Usuario").fill(credenciales_guest["username"])
    page.get_by_label("Contraseña").fill(credenciales_guest["password"])
    page.get_by_role("button", name="Ingresar").click()
    expect(page).to_have_url(re.compile(".*/inventory"))
    expect(page.locator("h1")).to_contain_text("G-Stock")


def test_boton_alertas_no_visible_para_guest(page, base_url, credenciales_guest):
    page.goto(base_url)
    page.get_by_label("Usuario").fill(credenciales_guest["username"])
    page.get_by_label("Contraseña").fill(credenciales_guest["password"])
    page.get_by_role("button", name="Ingresar").click()
    expect(page).to_have_url(re.compile(".*/inventory"))
    expect(page.get_by_title("Gestión de Alertas")).not_to_be_visible()


def test_admin_users_redirige_guest_a_inventory(page, base_url, credenciales_guest):
    page.goto(base_url)
    page.get_by_label("Usuario").fill(credenciales_guest["username"])
    page.get_by_label("Contraseña").fill(credenciales_guest["password"])
    page.get_by_role("button", name="Ingresar").click()
    expect(page).to_have_url(re.compile(".*/inventory"))  # esperar login completo antes de continuar
    page.goto(f"{base_url}/admin/users")
    expect(page).to_have_url(re.compile(".*/inventory"))
