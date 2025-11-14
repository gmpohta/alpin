## Как локально развернуть проект

Предварительно нужно установить докер https://docs.docker.com/engine/install/

### 1. Подготовка `.env`

Создайте файл `.env` скопировав `.env.example`

---

### 2. Разверните докер контейнеры

```bash
docker compose up --build --detach --remove-orphans
```

---

### 3. Установка зависимостей и инициализация

```bash
docker compose exec php composer install
docker compose exec php php bin/console doctrine:migrations:migrate --no-interaction
docker compose exec php vendor/bin/rr get --location bin/
docker compose exec php npm install
docker compose exec php npm run dev
```

---

### 4. Запустите проект

```bash
docker compose exec php bin/rr serve -c .rr.dev.yaml
```

Проект запустится локально по адресу http://localhost:8085
---