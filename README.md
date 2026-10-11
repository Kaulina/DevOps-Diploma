# Дипломный проект


Terraform и провайдер работают, validate проходит

Создана инфраструктурная сеть для проекта: 
- использована существующая VPC-сеть Yandex Cloud netology-network, 
- в зоне ru-central1-a создана подсеть devops-diploma-subnet-a с адресным диапазоном 10.10.0.0/24. 

Управление подсетью выполняется через Terraform. Состояние инфраструктуры синхронизировано, terraform plan подтверждает отсутствие изменений.

[3](screenshots/3.png)

VM успешно создана

[4](screenshots/4.png)

проверила, что Terraform управляет обоими ресурсами, а так же, проверила что после создания VM Terraform не видит никаких расхождений между .tf-конфигурацией и реально созданными ресурсами.

[5](screenshots/5.png)

подняла докер

[6](screenshots/6.png)

Docker успешно установлен и запущен на VM.

Проверена работа Docker без sudo от пользователя ubuntu:
- пользователь добавлен в группу docker;
- выполнена команда `docker ps`;
- успешно запущен тестовый контейнер `hello-world`;
- версия Docker: 29.1.3.

[7](screenshots/7.png)

Далее, Terraform и Yandex Cloud полностью синхронизировала:
- VM A — devops-diploma-vm
- VM B — devops-k8s-worker-b
- VM D — devops-k8s-worker-d
- 3 зоны: ru-central1-a, ru-central1-b, ru-central1-d
- Worker B и D — preemptible
- Worker D — security group зафиксирована в Terraform
- SSH к D работает
- Terraform не видит drift
- terraform plan не предлагает изменений

[8](screenshots/8.png)

Итоговая проверка инфраструктуры Yandex Cloud: три виртуальные машины в разных зонах доступности, Terraform без расхождений с фактическим состоянием инфраструктуры.

проверила Kubernetes-required sysctl

[9](screenshots/9.png)

подтвердила, что:
- сеть B-A работает
- Kubernetes API 6443 доступен
- TLS и discovery работают
- kubelet запустился
- сертификат worker получен
- VM B присоединилась к кластеру.
- 
[10](screenshots/10.png)

проверила на ВM A — control plane и готовность worker работать в кластере

[11](screenshots/11.png)

настроила так е ВМ D, и проверила что кластер полностью собран. Развернутый Kubernetes-кластер из трёх VM в трёх availability zones работает.

[12](screenshots/12.png)

проверила доступ control-plane - kubelet, дальше настроила Flannel, убедилась что он работает на всех трёх узлах

[13](screenshots/13.png)

создала временный тестовый под net-test и выполнила тест. 
убедилась, что работает двустороннюю работу Pod-сети ВМ D-ВM A через Flannel VXLAN.

[14](screenshots/14.png)

Pod-сеть Kubernetes работает между всеми тремя узлами

[15](screenshots/15.png)
