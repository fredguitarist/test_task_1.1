# #!/bin/bash

# # Простой curl-запрос с логированием
# echo "вызван второй скрипт"
# STATUS=$(curl -LI "https://test.com/monitoring/test/api" --connect-timeout 1 --max-time 1 -o /dev/null -w "%{http_code}" -s) || STATUS="000"
# echo "Получен HTTP код: $STATUS"

# if [[ "$STATUS" != "200" ]]; then
#     echo "$(date '+%Y-%m-%d %H:%M:%S') - URL https://test.com/monitoring/test/api недоступен, код: $STATUS" >> log.txt
# fi

#!/bin/bash

echo "вызван второй скрипт"

STATUS=$(curl -LI "https://test.com/monitoring/test/api" \
    --connect-timeout 55 --max-time 55 \
    -o /dev/null -w "%{http_code}" -s) || STATUS="000"

echo "Получен HTTP код: $STATUS"

if [[ "$STATUS" != "200" ]]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - URL https://test.com/monitoring/test/api недоступен, код: $STATUS" >> log.txt
fi


