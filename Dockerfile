# Используем базовый образ
FROM python:3.9-alpine

# Устанавливаем зависимости для сборки psycopg2
RUN apk add --no-cache \
    gcc \
    musl-dev \
    postgresql-dev

# Устанавливаем зависимости Python
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

RUN pip install flask-sqlalchemy flask-migrate psycopg2-binary redis Flask-Caching prometheus-flask-exporter

ENV SQLALCHEMY_DATABASE_URI=postgresql://user:password@db:5432/flask_db
ENV REDIS_HOST=redis
# Копируем исходный код приложения
COPY . .

# Открываем порт 5000
EXPOSE 5000

# Команда для запуска приложения
CMD ["python", "app.py"]
