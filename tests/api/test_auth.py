import requests

def test_login_exitoso(base_url, credenciales):
    response = requests.post(
    f"{base_url}/api/auth/login",
    json=credenciales
    )
    assert response.status_code == 200
    assert "token" in response.json()["data"]

def test_login_fallido(base_url):
    response = requests.post(
    f"{base_url}/api/auth/login",
    json={"username": "falso@test.com", "password": "incorrecta"}
    )
    assert response.status_code == 401