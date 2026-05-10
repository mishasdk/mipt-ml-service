# mipt-ml-service

Проект с ДЗ_7 по курсу развертывание ML моделей. Тема: Сборка конвейера CI/CD.

## Запуск

1. Установите необходимые python зависимости:

  ```sh
  pip install -r requirements.txt
  ```

2. Запустите пайплайн:

  ```sh
  python ml_pipeline.py
  ```

## Структура

```sh
.
├── ml_pipeline.py - ML пайплайн.
├── .gitlab-ci.yml - конфигурация CI/CD конвейера.
├── README.md
└── requirements.txt
```
