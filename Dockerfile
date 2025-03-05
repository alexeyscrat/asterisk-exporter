# Используем базовый образ с Alpine Linux
FROM alpine:latest

# Устанавливаем необходимые пакеты
RUN apk add --no-cache curl

# Скачиваем и устанавливаем asterisk-exporter
RUN curl -L -o /usr/local/bin/asterisk-exporter https://github.com/khulnasoft-lab/asterisk_exporter/releases/download/v0.5.0/asterisk_exporter-0.5.0.linux-amd64.tar.gz && \
    tar -xzf /usr/local/bin/asterisk-exporter -C /usr/local/bin/ && \
    rm /usr/local/bin/asterisk-exporter

# Открываем порт для Prometheus
EXPOSE 9168

# Запускаем asterisk-exporter
CMD ["/usr/local/bin/asterisk_exporter", "--asterisk.host=10.21.44.157", "--asterisk.port=5038", "--asterisk.user=cron", "--asterisk.password=1234"]