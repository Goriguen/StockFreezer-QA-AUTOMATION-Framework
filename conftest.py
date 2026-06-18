import pytest
import os
import requests
from dotenv import load_dotenv

load_dotenv()

@pytest.fixture
def base_url():
    return os.environ.get("BASE_URL", "https://demo.g-stockfreezer.com")

@pytest.fixture
def credenciales():
    return {
        "username": os.environ.get("TEST_USER"),
        "password": os.environ.get("TEST_PASS")
    }

@pytest.fixture
def token(base_url, credenciales):
    response = requests.post(
        f"{base_url}/api/auth/login",
        json=credenciales
    )
    return response.json()["data"]["token"]

@pytest.fixture
def auth_headers(token):
    return {"Authorization": f"Bearer {token}"}