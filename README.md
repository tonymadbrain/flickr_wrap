# Flickr wrapper

## RU

Данное приложение написано чтобы использовать Flickr в качестве хранилища
изображений для моего блога - http://doam.ru. Это простое приложение-обертка,
написанное на sinatra, работающее через Flickr API.

![Main page](https://github.com/tonymadbrain/flickr_wrap/blob/master/screenshot.png "Main page")

### Возможности

* Выгрузка в redis базу списка фотографий загруженных в облако Flickr
(выгружаются: ссылка на оригинал, заголовок, ссылка для показа превью)
* Удаление одной или нескольких фотографий из облакка
* Загрузка фотографий в облако

### Используется

* `sinatra` - не рельсами едиными
* `slim` - пишем html шаблоны без %
* `flickraw` - собственно гем для работы с Flickr API
* `redis` - быстрое kv хранилище

### Заметки:

* https://github.com/hanklords/flickraw - гем для Flickr API

### Переменные окружения необходимые для запуска приложения

> Вот здесь - https://github.com/hanklords/flickraw/blob/master/README.rdoc можно прочитать подробнее про получение токенов доступа и Flickr API в принципе

FLICKR_WRAP_USERNAME - логин для авторизации
FLICKR_WRAP_PASSWORD - пароль для авторизации
FLICKR_API_KEY - API ключ для Flickr API
FLICKR_SHARED_SECRET - Shared secret для Flickr API
FLICKR_ACCESS_TOKEN - Access token для Flickr API
FLICKR_ACCESS_SECRET - Acess secret для Flickr API
FLICKR_USER - Flickr пользователь
REDIS_URL - адрес по которому запущен Redis сервер

### Для запуска

Склонировать репозиторий

~~~bash
$ git clone https://github.com/tonymadbrain/flickr_wrap.git
~~~

Перейти в папку с приложением

~~~bash
$ cd flickr_wrap
~~~

Установить зависимости

~~~bash
$ bundle install
~~~

Экспортировать переменные окружения или создать файл .env

~~~Bash
export FLICKR_WRAP_USERNAME=admin
export FLICKR_WRAP_PASSWORD=password
export FLICKR_API_KEY=g9lCzIAdjvvvPaxU6L8CVf1um
export FLICKR_SHARED_SECRET=g9lCzIAdjvvvPax
export FLICKR_ACCESS_TOKEN=g9lCzIAdjvvv-PaxU6L8CVf1um
export FLICKR_ACCESS_SECRET=g9lCzIAdjvvvPa
export FLICKR_USER=12313131@P01
export REDIS_URL=redis://localhost:6379/1
~~~

Запустить сервер

~~~Bash
$ bundle exec rackup config.ru -p 3000
~~~

### Контакты

По любым вопросам можете писать на <a href="mailto:mail@doam.ru?Subject=Flickr_API_Wrapper" target="_top">почту</a>.

## EN

This application allow using Flickr for storage and CDN for my blog images. It is just wrapper on sinatra around flickraw gem.

![Main page](https://github.com/tonymadbrain/flickr_wrap/blob/master/screenshot.png "Main page")

### Features

* Выгрузка в redis базу списка фотографий загруженных в облако Flickr
(выгружаются: ссылка на оригинал, заголовок, ссылка для показа превью)
* Удаление одной или нескольких фотографий из облакка
* Загрузка фотографий в облако

### Tech used

* `sinatra` - не рельсами едиными
* `slim` - пишем html шаблоны без %
* `flickraw` - собственно гем для работы с Flickr API
* `redis` - быстрое kv хранилище

### Notes:

* https://github.com/hanklords/flickraw - гем для Flickr API

### Required environment variables

> Вот здесь - https://github.com/hanklords/flickraw/blob/master/README.rdoc можно прочитать подробнее про получение токенов доступа и Flickr API в принципе

FLICKR_WRAP_USERNAME - логин для авторизации
FLICKR_WRAP_PASSWORD - пароль для авторизации
FLICKR_API_KEY - API ключ для Flickr API
FLICKR_SHARED_SECRET - Shared secret для Flickr API
FLICKR_ACCESS_TOKEN - Access token для Flickr API
FLICKR_ACCESS_SECRET - Acess secret для Flickr API
FLICKR_USER - Flickr пользователь
REDIS_URL - адрес по которому запущен Redis сервер

### For start

Склонировать репозиторий

~~~bash
$ git clone https://github.com/tonymadbrain/flickr_wrap.git
~~~

Перейти в папку с приложением

~~~bash
$ cd flickr_wrap
~~~

Установить зависимости

~~~bash
$ bundle install
~~~

Экспортировать переменные окружения или создать файл .env

~~~Bash
export FLICKR_WRAP_USERNAME=admin
export FLICKR_WRAP_PASSWORD=password
export FLICKR_API_KEY=g9lCzIAdjvvvPaxU6L8CVf1um
export FLICKR_SHARED_SECRET=g9lCzIAdjvvvPax
export FLICKR_ACCESS_TOKEN=g9lCzIAdjvvv-PaxU6L8CVf1um
export FLICKR_ACCESS_SECRET=g9lCzIAdjvvvPa
export FLICKR_USER=12313131@P01
export REDIS_URL=redis://localhost:6379/1
~~~

Запустить сервер

~~~Bash
$ bundle exec rackup config.ru -p 3000
~~~

### Contact

По любым вопросам можете писать на <a href="mailto:mail@doam.ru?Subject=Flickr_API_Wrapper" target="_top">почту</a>.
