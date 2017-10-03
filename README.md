# Flickr wrapper

## RU

Данное приложение написано чтобы использовать flickr в качестве хранилища
изображений для моего блога - http://doam.ru. Это простое приложение-обертка,
написанное на sinatra, работающее через flickr API.

![Main page](https://github.com/tonymadbrain/flickr_wrap/blob/master/screenshot.png "Main page")

### Возможности

* Выгрузка в redis базу списка фотографий загруженных в облако flickr
(выгружаются: ссылка на оригинал, заголовок, ссылка для показа превью)
* Удаление одной или нескольких фотографий из облакка
* Загрузка фотографий в облако

### Используется

gem 'sinatra'
gem 'sinatra-contrib'
gem 'redis', '~>3.2'
gem 'flickraw'
gem 'dotenv'
gem 'slim'
gem 'http'
gem 'rack-ssl'

* `sinatra` - не рельсами едиными
* `slim` - пишем html шаблоны без %
* `flickraw` - собственно гем для работы с flickr API
* `redis` - быстрое kv хранилище

### Заметки:

* https://github.com/hanklords/flickraw - гем для flickr API

### TODO:

Смотри Pull Requests

### Для запуска:

Склонировать репозиторий

~~~bash
$ git clone https://github.com/tonymadbrain/flickr_wrap.git
~~~

Перейти в папку с приложением

~~~bash
$ cd flickr_wrap
~~~

Создать файлы конфигов и отредактировать их

~~~bash
$ touch sinatra.rb flickr.yml puma.rb
~~~

Установить зависимости

~~~bash
$ bundle install
~~~

Запустить сервер

~~~Bash
$ puma -C config/puma.rb
~~~

### Примеры конфигов

flickr.yml:
~~~yaml
:api_key: g9lCzIAdjvvvPaxU6L8CVf1um
:shared_secret: g9lCzIAdjvvvPax
:access_token: g9lCzIAdjvvv-PaxU6L8CVf1um
:access_secret: g9lCzIAdjvvvPa
:user: 12313131@P01
~~~

sinatra.rb:
~~~ruby
#configuration
configure do
  set :server, :puma
end
~~~

puma.rb:
~~~ruby
root = "#{Dir.getwd}"

daemonize false
environment 'development'
bind "unix:///tmp/flickr_api.socket"
pidfile "/tmp/flickr_api.pid"
rackup "#{root}/config.ru"
stdout_redirect "/tmp/flickr_api.stdout.log", "/tmp/flickr_api.stderr.log"
threads 1, 1

#activate_control_app
#state_path "/tmp/flickr_state"
~~~

### Контакты

По любым вопросам можете писать на <a href="mailto:mail@doam.ru?Subject=Flickr_API_Wrapper" target="_top">почту</a>.

## EN

In progress!
