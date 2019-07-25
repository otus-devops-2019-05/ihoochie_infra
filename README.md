# ihoochie_infra [![Build Status](https://travis-ci.com/otus-devops-2019-05/ihoochie_infra.svg?branch=master)](https://travis-ci.com/otus-devops-2019-05/ihoochie_infra)

[ДЗ №2: Локальное окружение инженера. ChatOps и визуализация рабочих процессов. Командная работа с Git. Работа в GitHub](#дз-2-локальное-окружение-инженера-chatops-и-визуализация-рабочих-процессов-командная-работа-с-git-работа-в-github)
* [Создание ветки репозитория](#создание-ветки-репозитория)
* [обавление шаблона PR](#добавление-шаблона-pr)
* [Интеграция GitHub и Slack](#интеграция-github-и-slack)
* [Интеграция с Trevis CI](#интеграция-с-trevis-ci)

[ДЗ №3: Знакомство с облачной инфраструктурой и облачными сервисами](#дз-3-знакомство-с-облачной-инфраструктурой-и-облачными-сервисами)
* [Адреса для подключения](#адреса-для-подключения)
* [Инициализация GCP](#инициализация-gcp)
* [Создание инстанса VM c внешним IP (подключение через bastion host)](#создание-инстанса-vm-c-внешним-ip-подключение-через-bastion-host)
* [Создание инстанса VM без внешнего IP](#создание-инстанса-vm-без-внешнего-ip)
* [Подключение к someinternalhost с локальной машины одной командой](#подключение-к-someinternalhost-с-локальной-машины-одной-командой)
* [Создание VPN сервера при помощи Pritunl](#создание-vpn-сервера-при-помощи-pritunl)
* [Добавление валидного сертификата, полученного в Let's encrypt](#добавление-валидного-сертификата-полученного-в-lets-encrypt)

[ДЗ №4: Основные сервисы Google Cloud Platform (GCP)](дз-4-основные-сервисы-google-cloud-platform-gcp)
* [Адреса для подключения2](#адреса-для-подключения2)  
* [Установка и настройка gcloud](#установка-и-настройка-gcloud)  
* [Создание инстанса (gcloud)](#создание-инстанса-gcloud)  
* [Подключение к инстансу и обновление ruby](#подключение-к-инстансу-и-обновление-ruby)  
* [Установка и запуск mongodb](#установка-и-запуск-mongodb)  
* [Деплой приложения](#деплой-приложения)  
* [Firewall правило](#firewall-правило)  
* [Bash-скрипты](#bash-скрипты)  
* [Startup script](#startup-script)

[ДЗ №5: Модели управления инфраструктурой](#дз-5-модели-управления-инфраструктурой)
* [Создание Packer template](#создание-packer-template)
* [Задание со * №1: baked-образ с деплоем приложения](#задание-со-звездочкой-1-baked-образ-с-деплоем-приложения)
* [Задание со * №2: создание инстанса при помощи gcloud](#задание-со-звездочкой-2-создание-инстанса-при-помощи-gcloud)

[ДЗ №6: Практика Infrastructure as a Code (IaC)](#дз-6-практика-infrastructure-as-a-code-iac)
* [Основная конфигурация](#основная-конфигурация)
* [Задание со * ](#задание-cо-звездочкой-добавление-ssh-ключей-для-нескольких-пользователей)
* [Задание с **](#задание-с-2-звездами-конфигурация-балансировщика-нагрузки)

[ДЗ №7: Принципы организации инфраструктурного кода и работа над инфраструктурой в команде на примере Terraform](#дз-7-принципы-организации-инфраструктурного-кода-и-работа-над-инфраструктурой-в-команде-на-примере-terraform)
* [Разделение конфигурации и использование модулей](#разделение-конфигурации-и-использование-модулей)
* [Задание со * ](#задание-со-звездочкой-хранение-state-файла-в-удаленном-storage-bucket)
* [Задание с **](#задние-с-двумя-звездами-запуск-приложения-с-бд-на-втором-инстансе)

[ДЗ №8: Знакомство с Ansible.Управление конфигурацией](#дз-8-знакомство-с-ansible-управление-конфигурацией)
* [Создание основных файлов](#создание-основных-файлов)
* [Задание со * ](#задание-со-звездочкой-dynemic-inventory)

#### ДЗ №2: Локальное окружение инженера. ChatOps и визуализация рабочих процессов. Командная работа с Git. Работа в GitHub. 

###### Создание ветки репозитория:

```bash
$ git clone git@github.com:otus-devops-2019-05/ihoochie_infra.git
$ cd ihoochie_infra
$ git branch play-travis
$ git checkout play-travis
```
###### Добавление шаблона PR
```bash
$ mkdir .github
$ cd .github
$ wget http://bit.ly/otus-pr-template -O PULL_REQUEST_TEMPLATE.md
$ git add PULL_REQUEST_TEMPLATE.md
$ git commit -m 'Add PR template'
$ git push --set-upstream origin play-travis
```
###### Интеграция GitHub и Slack
* Для получения нотификаций в Slack об изменениях на GitHub долна быть настроена интеграция бота с пространством по [инструкции](https://get.slack.help/hc/en-us/articles/232289568-GitHub-for-Slack).
* Чтобы подписаться на нотификации, выполнить команду в Slack-канале:
  ```
  /github subscribe Otus-DevOps-2019-05/ihoochie_infra commits:all
  ```
  
###### Интеграция с Trevis CI
**Trevis CI** - это бесплатный сервис непрерывной сборки и тестирования для проектов, размещенных на GitHub.
* Добавление файла с тестом
  ```bash
  $ mkdir play-travis
  $ cd play-travis
  $ wget https://raw.githubusercontent.com/express42/otus-snippets/master/hw-04/test.py
  $ git add test.py
  $ git commit -m "add test.py"
  $ git push
  ```
* Добавление инструкции для сборки
Создаем в корне репозитория .yml файл, в котором описываем инструкции для сборки
  ```bash
  $ touch .travis.yml
  ```
  ```
  dist: trusty
  sudo: required
  language: bash
  before_install:
  - curl https://raw.githubusercontent.com/express42/otus-homeworks/2019-05/run.sh |
  bash
  ```
* Шифрование токена Trevis CI и Slack интеграция
  ```bash
  $ apt-get update
  $ apt-get upgrade
  $ apt-get install ruby-dev
  $ gem install travis
  ```
  Логинимся и доавляем шифрованный токен в .trevis.yml
    ```bash
    $ travis login --com
    $ travis encrypt "<trevis_slack_token>#ilya_andrutskiy" --add notifications.slack.rooms --com
    ```
    В .trevis.yml добавились параметры для Slack интеграции
* Тестирование билда и исправление python скрипта
  ```bash
  $ git status
  $ git commit -m "add encrypted .travis.yml file"
  $ git show
  $ git push
  ```
  Нотификация от Trevis приходт, но билд упал. Смотрим лог и понимаем, что проблема в функции test_equal() в test.py. 
  Исправляем, коммитим. Билд успешно собран.

#### ДЗ №3: Знакомство с облачной инфраструктурой и облачными сервисами.
###### Адреса для подключения

```
bastion_IP = 35.210.60.203
someinternalhost_IP = 10.132.0.4
```

###### Инициализация GCP
* Создаем новую учетную запись в Google Cloud Platform
* Создаем новый проект Infra
* Генерируем ssh-ключи и публичный ключ добавляем в метеданные проекта (по умолчанию действует на все VM в проекте)
  ```bash
  $ ssh-keygen -t rsa -f ~/.ssh/appuser -C appuser -P ""
  ```
###### Создание инстанса VM c внешним IP (подключение через bastion host)
* Создаем VM: 

    **Name:** bastion  
    **Zone:** europe-west1-b  
    **Machine type:** f1-micro (1 vCPU, 0.6 GB memory)  
    **Boot disk:** Ubuntu 16.04  
    **Hostname:** bastion  
    **External IP:** bastion (35.210.60.203)
    
* Проверяем подключение
  ```bash
  $ ssh -i ~/.ssh/appuser.pub appuser@35.210.60.203
  ```
###### Создание инстанса VM без внешнего IP
* Создаем VM: 

    **Name:** someinternalhost  
    **Zone:** europe-west1-b  
    **Machine type:** f1-micro (1 vCPU, 0.6 GB memory)  
    **Boot disk:** Ubuntu 16.04  
    **Hostname:** someinternalhost  
 * Для возможности подключения к someinternalhost из внутренней (от bastion), добавляем приватный ключ в агент авторизации на локальной машине
    ```bash
    $ ssh-add ~/.ssh/appuser
    ```
* Включаем  SSH Agent Forwarding при помощи параметра -A, затем пробуем подключиться к someinternalhost
  ```bash
  $ ssh -i ~/.ssh/appuser -A appuser@35.210.60.203
  $ ssh 10.132.0.4
  ```
##### Подключение к someinternalhost с локальной машины одной командой
* С добавлением параметра -J (использование jump host)
  ```bash
  $ ssh -i ~/.ssh/appuser.pub -J appuser@35.210.60.203 appuser@10.132.0.4
  ```
* С использованием директивы ProxyJump
В файле **~/.ssh/config** добавляем:
  ```
  Host bastion
    User appuser
    Hostname 35.210.60.203
    ForwardAgent yes
    IdentityFile ~/.ssh/appuser.pub

  Host someinternalhost
    User appuser
    Hostname 10.132.0.4
    ProxyJump bastion
  ```
  Теперь подключение к someinternalhost может выглядеть следующий образом
  ```bash
  $ ssh someinternalhost
  ```
  
  Добавляем алиас, для подключения в одно слово
  ```bash
  $ alias someinternalhost='ssh someinternalhost'
  ```  
  
  **Примечание:** встарых версиях OpenSSH отсутствуют возможности, описанные выше. Пришлось обновиться
  ```bash
  $ sudo apt update
  $ sudo apt install build-essential zlib1g-dev libssl-dev 
  $ wget -c https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.0p1.tar.gz
  $ tar -xzf openssh-8.0p1.tar.gz
  $ cd openssh-8.0p1/
  $ sudo apt install libpam0g-dev libselinux1-dev 
  $ ./configure --with-md5-passwords --with-pam --with-selinux --with-privsep-path=/var/lib/sshd/ --sysconfdir=/etc/ssh 
  $ make
  $ sudo make install 
  ```
  В старых версиях можно реализовать то же через конфиг через директиву ProxyCommand:
  ```bash
  Host bastion
      HostName 35.210.60.203
      IdentityFile ~/.ssh/appuser.pub
      ForwardAgent yes
      User ec2-user

  Host someinternalhost
      HostName 10.132.0.4 
      User appuser  
      Proxy Command ssh -q -W %h:%p bastion
  ```
    
 ###### Создание VPN сервера при помощи Pritunl
  
 * В настройках bastion инстанса в разделе Firewalls разрешаетм HTTP, HTTPS трафик. Появились теги http-server, https-server.
  * Выполняем [команды](https://gist.github.com/Nklya/df07e99e63e4043e6a699060a7e30b66) для установки pritunl.
  * Создаем в web-интерфейсе pritunl организацию, пользователя, сервер. Привязываем сервер к организации и запускаем.
  * В настройках сети GCP добавляем правило в Firewall rules  
  **Name:** vpn-13009  
  **Targets:** vpn-13009  
  **Filters: IP ranges:** 0.0.0.0/0  
  **Protocols / ports:** udp:13009
 * Добавляем правило udp:10855 в теги сети bastion сервера
 * Скачиваем конфигурационный файл *.ovpn в web интерфейсе Pritunl
 * Добавляем конфиг в клиент OpenVPN
    ```bash
     sudo openvpn --config ~/cloud-bastion.ovpn
    ```
  * Подключаемся к someinternalhost с локальной машины
    ```bash
    ssh -i ~/.ssh/appuser appuser@10.132.0.4
    ```
##### Добавление валидного сертификата, полученного в Let's encrypt
* Для получения сертификата Let's Encrypt, воспользуемся клиентом Cerbot
* Let's Encrypt не выдает сертификаты для IP адресов, поэтому нужен DNS
 * С указаннми в инструкции сервисами sslip.io и xip.io возникали проблемы, связанные с привешением лимитов на использвание доменных имен ([rate limits](https://letsencrypt.org/docs/rate-limits/)), поэтому была найдена альтернатива - nip.io* Устанавливаем Cerbot и запрашиваем сертификат для адреса 35.210.60.203.nip.io
    ```bash
    $ sudo apt-get update
    $ sudo apt-get install software-properties-common
    $ sudo add-apt-repository universe
    $ sudo add-apt-repository ppa:certbot/certbot
    $ sudo apt-get update
    $ sudo apt-get install certbot
    ```
    Останавливаем сервер и запрашиваем сертификат
    ```bash
    sudo certbot certonly --standalone
    ```
 *  После этого в web-интерфейсе pritunl в настройках вводим адрес 35.210.60.203.nip.io в поле Let's Encrypt Domain
  * Проверяем, что браузер больше не ругается на сертификат и что подключение к VPN серверу с локальной машины работает

#### ДЗ №4: Основные сервисы Google Cloud Platform (GCP)

###### Адреса для подключения2:
```
testapp_IP = 35.233.102.55
testapp_port = 9292
```
###### Установка и настройка gcloud

**Инструкция**: https://cloud.google.com/sdk/docs/#deb

###### Создание инстанса (gcloud)

```
$ gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure
```
###### Подключение к инстансу и обновление ruby

```bash
$ ssh appuser@<instace_public_ip>

$ sudo apt update
$ sudo apt install -y ruby-full ruby-bundler build-essential
```
###### Установка и запуск mongodb

```bash
$ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
$ sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'

$ sudo apt update
$ sudo apt install -y mongodb-org

$ sudo systemctl start mongod
$ sudo systemctl enable mongod
```
###### Деплой приложения
```bash
$ git clone -b monolith https://github.com/express42/reddit.git
$ cd reddit
$ bundle install
$ puma -d
$ ps aux | grep puma
```
###### Firewall правило

В разделе Firewall rules добавлено правило с тегом **puma-server** и tcp портом **9292**

###### Bash-скрипты

Описанные выше шаги добавлены в скрипты: **install_ruby.sh**, **install_mongodb.sh** и **deploy.sh**

###### Startup script
Все команды объединены в скрипт startup.sh.  
Для автоматического создания инстанса с задеплоенным приложением выполнить команду:
```
$ gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=startup.sh
```

#### ДЗ №5: Модели управления инфраструктурой

##### Создание Packer template

* Устаноавливаем Packer с https://www.packer.io/downloads.html

* Раздамем права для управления ресурсами GCP -  Application Default Credentials (ADC)
  ```bash
  $ gcloud auth application-default login
  ```
* Заполняем шаблон ubuntu16.json. Некоторые значения параметризированы при помощи пользоватльских переменных

* Проверяем шаблон 
  ```bash
  $ packer validate ./ubuntu16.json 
  ```

* Запускаем создание образа 
  ```bash
  $ packer build -var-file=variables.json ubuntu16.json
  ```

##### Задание со звездочкой №1: baked-образ с деплоем приложения

* Для деплоя приложения, используя systemd, создан скрипт **scripts/deploy.sh**
  ```bash
  !#/bin/bash
  set -e

  git clone -b monolith https://github.com/express42/reddit.git
  cd reddit
  bundle install

  cat > /etc/systemd/system/puma.service <<EOF
  [Unit]
  Description=OTUS_puma_app
  After=network.target

  [Service]
  Type=simple
  PIDFile=/home/appuser/reddit/pids/service.pid
  WorkingDirectory=/home/appuser/reddit
  ExecStart=/usr/local/bin/puma
  Restart=always

  [Install]
  WantedBy=multi-user.target
  EOF

  systemctl enable puma
  systemctl start puma
  ```

* Новый шаблон в **immutable.json**, добавлен provisoner
  ```json
  {
  "type": "shell",
  "script": "scripts/deploy.sh",
  "execute_command": "sudo {{.Path}}"
  }
  ```

##### Задание со звездочкой №2: создание инстанса при помощи gcloud

* Создаем sh-скрипт **create-redditvm.sh** для создания инстанса с использованием baked-образа
  ```bash
  #!/bin/bash
  set -e

  gcloud compute instances create reddit-app\
    --image-family reddit-full \
    --machine-type=g1-small \
    --tags puma-server \
    --restart-on-failure
  ```
#### ДЗ №6: Практика Infrastructure as a Code (IaC)

##### Основная конфигурация
* Создан файл main.tf, в котором определены создаваемые ресурсы: инстанс и правило файрволла
* В outputs.tf определена переменная для удобного вывода внешнего IP созданной VM
* В variables.tf объявлены переменные для параметризации создания ресурсов
* В terraform.tfvars указаны значения переменных
* Добавлены дполнительные переменные для приватного ключа и зоны
  ```
  variable private_key {
      description = "Path to the privat key uset for ssh access in the provisoners"
  }
  variable {
      description = "Zone for instance"
      default = "europe-west1-b"
  }
  ```
* все конфигурационные файлы отформатированы командой terraform fmt

##### Задание cо звездочкой: добавление ssh ключей для нескольких пользователей
* Добавление группы ключей
  ```
  resource "google_compute_project_metadata" "ssh-key-appuser" {
    metadata {
      ssh-keys = <<EOF
  appuser1:${var.public_key} appuser1
  appuser2:${var.public_key} appuser2
  appuser3:${var.public_key} appuser3
  appuser4:${var.public_key} appuser4
  appuser5:${var.public_key} appuser5
  EOF
    }
  }
  ```
* Вариант с google_compute_project_metadata_item
  ```
  resource "google_compute_project_metadata_item" "ssh-key-appuser" {
    key = "ssh-keys"
    value = "appuser1:${var.public_key} appuser1\nappuser2:${var.public_key} appuser2\nappuser3:${var.public_key} appuser3"
  }
  ```
* Если добавить новый ключи в интерфейсе, а потом выполнить terraform apply, то ключ будет утерян. Чтобы этого избежать нужно добавлять его в конфигурацию terraform.

##### Задание с 2 звездами: конфигурация балансировщика нагрузки
* Конфигурация для создания балансировщика добавлена в lb.tf, включая правило firewall для Health чекера
  ```resource "google_compute_firewall" "fw-allow-health-checks" {
    name    = "fw-allow-health-checks"
    network = "default"
    allow {
      protocol = "tcp"
      ports    = ["9292"]
    }
    target_tags = ["allow-health-checks"]
    source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
    priority = 1000
    direction = "INGRESS"
  }
  ```
* Тег назначается создаваемым инстансам. Тег reddit-app больше не нужен, так как доступ к приложение будет происходить через балансировщик.
  ```
  tags = ["allow-health-checks"]
  ```
* Добавлено второй инстанс в описание конфигурации, из-за чего пришлось првить код в разных местах, что не оптимально и может в будуещм привести к проблемам из-за ошибок.
* При остановке одного инстанса приложение продолжает быть доступным по адресу балансировщика.
* В [документации](https://www.terraform.io/docs/configuration-0-11/resources.html) описано использование count для создания нескольких экземпляров ресурса и добавление индекса к имени через count.index. Например, создание группы инстансов (значение count определено в виде переменной):
  ```
  variable instance_count {
      description = "Public ssh key"
      default = 1
  }
  resource "google_compute_instance" "app" {
    count        = "${var.instance_count}"
    name         = "reddit-app${count.index}"
    ...
    ...
    }
    resource "google_compute_instance_group" "reddit-instance-group" {
    name        = "reddit-instance-group"
    description = "Reddit instance group"
    instances = [
      "${google_compute_instance.app.*.self_link}"
    ]
    ...
    ...
    }
    ```
* Список ip адресов добавлен в output.tf
  ```  
  output "all_external_ips" {
  value = "${google_compute_instance.app.*.network_interface.0.access_config.0.nat_ip}"
  }
  output "external_ip_0" {
    value = "${google_compute_instance.app.0.network_interface.0.access_config.0.nat_ip}"
  }
  output "load_balancer_ip" {
      value = "${google_compute_global_forwarding_rule.reddit-lb-global-forwarding-rule.ip_address}"
  }
  ```
#### ДЗ №7: Принципы организации инфраструктурного кода и работа над инфраструктурой в команде на примере Terraform. 

##### Разделение конфигурации и использование модулей

* Добавляем автоматически созданное при создании проекта правило default-allow-ssh в конфигурацию
  ```
  resource "google_compute_firewall" "firewall_ssh" {
    description = "Allow SSH from anywhere"
    name    = "default-allow-ssh"
    network = "default"

    allow {
      protocol = "tcp"
      ports    = ["22"]
    }

    source_ranges = ["0.0.0.0/0"]
  }
  ```
  ```
  $ terraform import google_compute_firewall.firewall_ssh default-allow-ssh
  ```


* Добавляем создание внешнего ip адреса и его использование инстансом
  ```
  resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
  }
  ```
  ```
  ...
  network_interface {
  network       = "default"
      access_config = {
        nat_ip = "${google_compute_address.app_ip.address}"
      }
  }
  ...
  ```

* Создаем Packer конфигурацию для создания образа с установленным mongodb - packer/db.json
* Создаем Packer конфигурацию для создания образа с установленным  Ruby - packer/app.json

* Создаем образы
  ```
  $ packer build -var-file=variables.json app.json
  $ packer build -var-file=variables.json db.json
  ```

* Разделяем конфигурацию на разные файлы: app.rf, db.tf, vpc.tf

* Создаем модули
  ```bash
  $ mkdir modules
  $ cd modules
  $ mkdir db
  $ cd db
  $ touch main.tf
  $ touch variables.tf
  $ touch outputs.tf
  $ cat ~/ihoochie_infra/terraform/db.tf > ./main.tf
  $ cd ..

  $ mkdir app
  $ cd app
  $ touch main.tf
  $ touch variables.tf
  $ touch outputs.tf
  $ cat ~/ihoochie_infra/terraform/app.tf > ./main.tf
  ```
* Из директории terraform удаляем файлы app.tf и db.tf
* По аналогии создаем модуль vpc.tf
* Добавляем подключение модулей в основную конфигурацию в terrafom/main.tf
  ```
  module "app" {
    source          = "modules/app"
    public_key_path = "${var.public_key_path}"
    zone            = "${var.zone}"
    app_disk_image  = "${var.app_disk_image}"
  }

  module "db" {
    source          = "modules/db"
    public_key_path = "${var.public_key_path}"
    zone            = "${var.zone}"
    db_disk_image   = "${var.db_disk_image}"
  }

  module "vpc" {
    source          = "modules/vpc"
  }
  ```
* Подключаем модули
  ```
  $ terraform get
  ```

* В terraform/outputs.tf описываем переменные, ссылаясь на модули.  
  ```
  output "db_external_ip" {
      value = "${module.db.db_external_ip}"
  }
  output "app_external_ip" {
      value = "${module.app.app_external_ip}"
  }
  ```
* Параметризируем source_ranges в модуле vpc  
* Создадим Stage и Prod
   ```bash
    $ mkdir prod
    $ mkdir stage
    $ cp main.tf variables.tf outputs.tf terraform.tfvars ./prod
    $ cp main.tf variables.tf outputs.tf terraform.tfvars ./stage
   ```
 
##### Задание со звездочкой: хранение state файла в удаленном storage bucket
* Добаляем storage бакеты - terraform/storage-bucket.tf
* В директориях stage и prod определяем конфигурацию backend.tf

* Если скопировать конфигруационные файлы в директорию вне репозитория, стостояние инфраструктуры прододжает быть видимым при отсутствии локального state файла.

* При одновременном запуске терраформа из двух директорий, получаем ошибку - система блокировок работает.
  ```
  Error: Error locking state: Error acquiring the state lock: writing "gs://reddit-storage-stage/stage/default.tflock" failed: googleapi: Error 412: Precondition Failed, conditionNotMet
  Lock Info: ...

  Terraform acquires a state lock to protect the state from being written
  by multiple users at the same time. Please resolve the issue above and try
  again. For most commands, you can disable locking with the "-lock=false"
  flag, but this is not recommended.
  ```

##### Задние с двумя звездами: Запуск приложения с БД на втором инстансе

* Для того, чтобы поднять прилоение с двумя инстансами, нужно, чтобы mongodb был доступен из внутренней сети а приложение puma должно обращаться к внутреннему ip инстанса с mongodb.

* Для открытия доступа к mongodb заменим конфиг /etc/mongod.conf. При помощи провиженеров применим файлы mongod.conf и bind_ip.sh, объявленные в модуле db
  ```
    provisioner "file" {
      source      = "${path.module}/files/mongod.conf"
      destination = "/tmp/mongod.conf"
    }

    provisioner "remote-exec" {
      script = "${path.module}/files/bind_ip.sh"
    }
  ```
* В модуле db объявим output. Она будет использована как input при инициализации модуля
  ```
  output "db_internal_ip" {
    value = "${google_compute_instance.db.network_interface.0.network_ip}"
  }
  ```
* В модуле app объявим переменную
  ```
  variable "db_internal_ip" {
    description = "DB internal ip to connect the app"
    default = "127.0.0.1"
  }
  ```
* Испоьзуем переменную в определнии ресурса. Здесь мы передаем внутренний ip db инстанса
  ```
    provisioner "file" {
      source      = "${path.module}/files/puma.service"
      destination = "/tmp/puma.service"
    }

    provisioner "remote-exec" {
      inline = "echo 'Environment=DATABASE_URL=${var.db_internal_ip}:27017' >> /tmp/puma.service"
    }

    provisioner "remote-exec" {
      script = "${path.module}/files/deploy.sh"
    }
  ```
 * В инициализации модуля в prod/main.tf и stage/main.tf используем переменную.
    ```
       db_internal_ip  = "${module.db.db_internal_ip}"
    ```
#### ДЗ №8: Знакомство с Ansible. Управление конфигурацией

##### Создание основных файлов

* Созданы:
  * Основной конфиг - ansible.cfg
  * Inventory в формате INI - inventory
  * Inventory в YMAL формате - inventory.yml
  * Создали простой плейбук для копирования git репозитория - clone.yml

##### Задание со звездочкой: Dynemic Inventory
* В отличии от статического inventory, динамический представляет из себя скрипт, результатом которого является json, выводимый в stdout.
* Такой способ позовляет автоматичеси подставлять изменяемые значения пересоздаваемых ресурсов инфраструктуры.
* Такой скрипт описан в файле inventory.py и добавлен в основной кофиг, для использования Ansible по умолчанию.
* Переменные для формирования берутся из terraform/stage/terraform.tfstate
* Пример вывода скрипта добавлен в inventory.json
