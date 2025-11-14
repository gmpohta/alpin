SHELL := /bin/bash
EXEC_PHP := docker compose exec -it php
ifeq (locally,$(firstword $(MAKECMDGOALS)))
	EXEC_PHP :=
endif

locally:;@:
.PHONY: locally

dev:
	$(EXEC_PHP) bin/rr serve -c .rr.dev.yaml

run:
	$(EXEC_PHP) bin/rr serve

## Контроль качества кода

check: lint psalm rector check-composer ## Запустить все проверки
.PHONY: check

lint: var vendor ## Проверить PHP code style при помощи PHP CS Fixer (https://github.com/FriendsOfPHP/PHP-CS-Fixer)
	$(EXEC_PHP) vendor/bin/php-cs-fixer fix --dry-run --diff --verbose
.PHONY: lint

fixcs: var vendor ## Исправить ошибки PHP code style при помощи PHP CS Fixer (https://github.com/FriendsOfPHP/PHP-CS-Fixer)
	$(EXEC_PHP) vendor/bin/php-cs-fixer fix --diff --verbose
.PHONY: fixcs

psalm: var vendor ## Запустить полный статический анализ PHP кода при помощи Psalm (https://psalm.dev/)
	$(EXEC_PHP) vendor/bin/psalm --no-diff $(file)
.PHONY: psalm

rector: var vendor ## Запустить полный анализ PHP кода при помощи Rector (https://getrector.org)
	$(EXEC_PHP) vendor/bin/rector process --dry-run
.PHONY: rector

rector-fix: var vendor ## Запустить исправление PHP кода при помощи Rector (https://getrector.org)
	$(EXEC_PHP) vendor/bin/rector process
.PHONY: rector-fix

check-composer: composer-validate composer-audit composer-require ## Запустить все проверки для Composer
.PHONY: check-composer

composer-validate: ## Провалидировать composer.json и composer.lock при помощи composer validate (https://getcomposer.org/doc/03-cli.md#validate)
	$(EXEC_PHP) composer validate --strict --no-check-publish
.PHONY: composer-validate

composer-require: vendor ## Обнаружить неявные зависимости от внешних пакетов при помощи ComposerRequireChecker (https://github.com/maglnet/ComposerRequireChecker)
	$(EXEC_PHP) vendor/bin/composer-require-checker check
.PHONY: composer-require

composer-audit: vendor ## Обнаружить уязвимости в зависимостях Composer при помощи composer audit (https://getcomposer.org/doc/03-cli.md#audit)
	$(EXEC_PHP) composer audit
.PHONY: composer-audit
