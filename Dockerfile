# Этап 1: Сборка бинарного файла
FROM golang:1.21-alpine AS builder

# Устанавливаем зависимости для сборки
RUN apk add --no-cache git make

# Клонируем репозиторий
RUN git clone https://github.com/robinmarechal/asterisk_exporter /src

# Переходим в директорию проекта
WORKDIR /src

# Собираем проект
RUN make build

# Этап 2: Создаем минимальный образ
FROM alpine:3.21

# Копируем бинарный файл из этапа сборки
COPY --from=builder /src/bin/asterisk_exporter /usr/local/bin/asterisk_exporter

# Устанавливаем права на выполнение
RUN chmod +x /usr/local/bin/asterisk_exporter

# Открываем порт для Prometheus
EXPOSE 9168

# Запускаем asterisk-exporter
CMD ["/usr/local/bin/asterisk_exporter", "--asterisk.host=10.21.44.157", "--asterisk.port=5038", "--asterisk.user=cron", "--asterisk.password=1234"]