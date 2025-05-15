#!/bin/bash
source ./config.env 

# Файл для хранения предыдущего PID
PID_FILE="/tmp/${PROCESS_NAME}.pid"
LOG_FILE="log.txt"

if [[ -z "$PROCESS_NAME" ]]; then
  echo "Ошибка: переменная PROCESS_NAME не задана"
  exit 1
fi

# Читаем старый PID из файла, если он есть
old_pid=""
if [[ -f "$PID_FILE" ]]; then
  old_pid=$(cat "$PID_FILE")
fi

# Ищем текущий PID процесса (берём первый найденный)
new_pid=$(pgrep -f "$PROCESS_NAME" | head -n 1)

# Проверяем, найден ли процесс
if [[ -z "$new_pid" ]]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Процесс $PROCESS_NAME не найден" >> "$LOG_FILE"
  exit 0
fi

# Сравниваем PID
if [[ "$new_pid" != "$old_pid" ]]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Процесс $PROCESS_NAME перезапущен: старый PID=$old_pid, новый PID=$new_pid" >> "$LOG_FILE"
  echo "$new_pid" > "$PID_FILE"
else
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Процесс $PROCESS_NAME работает, PID=$new_pid" >> "$LOG_FILE"
fi
