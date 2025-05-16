Набо рскриптов выполнен согласно заданию. 
Для запуска проекта необходимо:
0) скачать проект в папку [ваша папка]
1)создать systemd юнит(для запуска скрипта при загрузке системы):
```создать файл /etc/systemd/system/monitor.service

внести в него содержимое

[Unit]
Description=launch monitor.sh
After=network.target    

[Service]
Type=simple
ExecStart=[ваша папка]/monitor.sh
WorkingDirectory=[ваша папка]   
User=root            
Restart=always        
StandardOutput=journal         
StandardError=journal          

[Install]
WantedBy=multi-user.target 
```
2)дать права на исполнение всем сфайлам с разрешением .sh и test

3)запустить test

4)запустить monitor.sh

