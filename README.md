# barmank32_microservices
barmank32 microservices repository
# ДЗ № 12
[![Build Status](https://travis-ci.com/barmank32/trytravis_microservices.svg?branch=docker-2)](https://travis-ci.com/barmank32/trytravis_microservices)
## Устанавка Docker
```
# Docker
$ sudo apt install docker-ce

# docker-compose
$ sudo apt install docker-compose

# docker-mashin
$ curl -L https://github.com/docker/machine/releases/download/v0.16.2/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine && \
    chmod +x /tmp/docker-machine && \
    sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
```
### Команды Docker
- `docker version` - версия Docker сервера и клиента
- `docker info` - информация о текущем состоянии
- `docker run hello-world` - запуск контейнера `hello-world`
- `docker ps` - вывод запущенный контейнеров. `-a` показывает все контейнеры.
- `docker images` - список сохраненных образов
- `docker run -it ubuntu:18.04 /bin/bash` - запустить и зайти в контейнер
- `docker start` - запустить остановленный контейнер
- `docker attach` - присоединиться к запущенному контейнеру
- `docker run -dt nginx:latest` - запустить контейнер в фоновом режиме
- `docker exec -it <u_container_id> bash` - запустить новый процесс в контейнере
- `docker commit <u_container_id> yourname/ubuntu-tmp-file` - создать образ из запущенного контейнера
- `docker inspect` - вывод информации о контейнере или образе
- `docker kill` - удалить контейнер
- `docker system df` - отображает сколько дискового пространства занято
- `docker rm` - удалить контейнер. `-f` удалить работающий.
- `docker rmi` -  удалить образ
- `docker rm $(docker ps -a -q)` -  удалит все незапущенные контейнеры
- `docker rmi $(docker images -q)` - удалит все образы
## Docker machine
встроенный в докер инструмент для создания хостов и установки на них docker engine. Имеет поддержку облаков и систем виртуализации.
### Команды
- `docker-machine create <имя>` - создать
- `eval $(docker-machine env<имя>)` - переключиться
- `eval $(docker-machineenv --unset)` - переключиться на локальный
- `docker-machine rm <имя>` - удалить
команда подключения
- `docker-machine ls` - запушенные соединения
```
$ docker-machine create \
  --driver generic \
  --generic-ip-address=<ПУБЛИЧНЫЙ_IP_СОЗДАНОГО_ВЫШЕ_ИНСТАНСА> \
  --generic-ssh-user yc-user \
  --generic-ssh-key ~/.ssh/id_rsa \
    docker-host
```
## Dockerfile
Файл для создания образа контейнера
```
FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y mongodb-server ruby-full ruby-dev build-essential git ruby-bundler
RUN apt-get install -y nano net-tools mc

RUN git clone -b monolith https://github.com/express42/reddit.git
COPY mongod.conf /etc/mongod.conf
COPY db_config /reddit/db_config
COPY start.sh /start.sh

RUN chmod 0777 /start.sh
RUN cd /reddit && rm Gemfile.lock && bundle install

CMD ["/start.sh"]
```
`$ docker build -t reddit:latest .` - команда для создания образа
## Docker hub
- `docker login` - аутентификация на docker hub
- `docker tag reddit:latest <your-login>/otus-reddit:1.0` - присвоение тега
- `docker push <your-login>/otus-reddit:1.0` - отправка образа на docker hub
# ДЗ № 13

## Задание*
```
$ docker kill $(docker ps -q)
$ docker run -d --network=reddit --network-alias=mongodb -v reddit_db:/data/db mongo:latest
$ docker run -d --network=reddit --network-alias=app_post --env POST_DATABASE_HOST=mongodb barmank32/post:1.0
$ docker run -d --network=reddit --network-alias=app_comment --env COMMENT_DATABASE_HOST=mongodb barmank32/comment:2.0
$ docker run -d --network=reddit -p 9292:9292 --env POST_SERVICE_HOST=app_post --env COMMENT_SERVICE_HOST=app_comment barmank32/ui:3.0
```
