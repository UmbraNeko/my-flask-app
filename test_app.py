import pytest
from app import app

@pytest.fixture
def client():
    # Создаём тестовый клиент Flask
    with app.test_client() as client:
        yield client

def test_home_page(client):
    response = client.get('/')
    assert response.status_code == 200
    assert b'Hello' in response.data

def test_data_page(client):
    response = client.get('/data')
    assert response.status_code == 200
    assert b'This is some data' in response.data

def test_cache(client):
    response1 = client.get('/data')
    response2 = client.get('/data')
    assert response1.data == response2.data

def test_404(client):
    response = client.get('/page404')
    assert response.status_code == 404