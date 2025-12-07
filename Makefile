# Makefile для управления Docker Compose в проекте Laravel

# ----------------------------------------------------------------------
# КОНФИГУРАЦИЯ
# ----------------------------------------------------------------------

# Имя сервиса PHP-FPM, как указано в docker-compose.yml
PHP_SERVICE := app

# Команда для получения ID запущенного контейнера PHP-FPM
# Используется для команды 'connect' (docker exec)
CONTAINER_NAME := $(shell docker compose ps -q $(PHP_SERVICE))

# ----------------------------------------------------------------------
# ЦЕЛИ (COMMANDS)
# ----------------------------------------------------------------------

# Объявление целей, которые не являются файлами
.PHONY: connect up down artisan bash

## 🚀 Основные команды Docker:
# ---------------------------

# up: Сборка и запуск всех сервисов в фоновом режиме.
up:
	@echo "-> Запуск Docker Compose (билдим и запускаем в фоне)..."
	docker compose up -d --build

# down: Остановка и удаление контейнеров и сетей.
down:
	@echo "-> Остановка и удаление контейнеров Docker Compose..."
	docker compose down

## 💻 Управление контейнером PHP (app):
# ------------------------------------

# connect: Подключается к контейнеру PHP-FPM через SH (для Alpine).
connect:
	@echo "-> Подключение к терминалу контейнера PHP-FPM ($(PHP_SERVICE))..."
	@docker exec -it $(CONTAINER_NAME) sh

# bash: Запускает Bash в контейнере. Используйте, если вы заменили базовый образ Alpine на Debian.
bash:
	@echo "-> Подключение к Bash в контейнере PHP-FPM ($(PHP_SERVICE))..."
	@docker exec -it $(CONTAINER_NAME) bash

# composer: Выполняет команду Composer. Использование: make composer c="install"
composer:
ifdef c
	@echo "-> Выполнение 'composer $(c)' в контейнере $(PHP_SERVICE)..."
	@docker compose exec $(PHP_SERVICE) composer $(c)
else
	@echo "Usage: make composer c=\"<composer command>\""
	@echo "Example: make composer c=\"install\""
	@false
endif

# artisan: Выполнить команду Artisan. Использование: make artisan c="migrate"
artisan:
ifdef c
	@echo "-> Выполнение 'php artisan $(c)' в контейнере $(PHP_SERVICE)..."
	@docker compose exec $(PHP_SERVICE) php artisan $(c)
else
	@echo "Usage: make artisan c=\"<artisan command>\""
	@echo "Example: make artisan c=\"migrate --seed\""
	@false
endif