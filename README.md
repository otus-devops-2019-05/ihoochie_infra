# ihoochie_infra

#### ДЗ №2: Локальное окружение инженера. ChatOps и визуализация рабочих процессов. Командная работа с Git. Работа в GitHub. 

###### Создание ветки репозитория:

```bash
$ git clone git@github.com:otus-devops-2019-05/ihoochie_infra.git
$ cd ihoochie_infra
$ git branch play-travis
$ git checkout play-travis
```
###### Создание ветки репозитория и добавление шаблона PR
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

###### Подготовка
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
