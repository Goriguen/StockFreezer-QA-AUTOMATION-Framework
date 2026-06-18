import pytest
import requests

def test_listar_cajones(base_url, auth_headers):
    response = requests.get(
    f"{base_url}/api/crates",
    headers=auth_headers
    )
    assert response.status_code == 200
    assert response.json()["ok"] == True

def test_crear_cajon_exitoso(base_url, auth_headers):
    response = requests.post(
    f"{base_url}/api/crates",
    headers=auth_headers,
    json={"name": "Cajon Automation", "type": "LOGICAL", "maxCapacity": 10}
    )
    assert response.status_code == 201
    assert response.json()["ok"] == True
    assert response.json()["data"]["name"] == "Cajon Automation"

def test_crear_cajon_sin_token(base_url):
    response = requests.post(
    f"{base_url}/api/crates",
    json={"name": "Cajon Sin Auth", "type": "LOGICAL", "maxCapacity": 10}
    )
    assert response.status_code == 401

@pytest.mark.xfail(reason="Bug conocido en validacion de tipo, en seguimiento interno")
def test_crear_cajon_tipo_invalido(base_url, auth_headers):
    response = requests.post(
    f"{base_url}/api/crates",
    headers=auth_headers,
    json={"name": "Cajon Malo", "type": "INEXISTENTE", "maxCapacity": 10}
    )
    assert response.status_code == 400

def test_crear_cajon_grid_sin_dimensiones(base_url, auth_headers):
    response = requests.post(
    f"{base_url}/api/crates",
    headers=auth_headers,
    json={"name": "Cajon Grid", "type": "GRID"}
    )
    assert response.status_code == 400
    assert response.json()["error"]["code"] == "INVALID_GRID_DIMENSIONS"