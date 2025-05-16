#!/bin/bash

# Получаем текущую директорию
WORKDIR="$(pwd)"
UNIT_NAME="main.service"
UNIT_PATH="/etc/systemd/system/$UNIT_NAME"

# Проверка наличия main.sh
if [[ ! -f "$WORKDIR/main.sh" ]]; then
  echo "Файл main.sh не найден в $WORKDIR"
  exit 1
fi

# Создаём unit-файл
cat <<EOF | sudo tee "$UNIT_PATH" > /dev/null
[Unit]
Description=Launch main.sh
After=network.target

[Service]
Type=simple
ExecStart=$WORKDIR/main.sh
WorkingDirectory=$WORKDIR
User=root
Restart=always
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

# Установка прав, перезапуск systemd, enable и start
sudo chmod 644 "$UNIT_PATH"
sudo systemctl daemon-reload
sudo systemctl enable "$UNIT_NAME"
sudo systemctl start "$UNIT_NAME"

echo "Сервис $UNIT_NAME установлен и запущен."
