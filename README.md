# Tutorial Introdutório de Robot Framework #

Este é um tutorial do [Robot Framework][robot], um framework de Testes de
Aceitação escrito em Python.

Além da documentação com o tutorial, há um pequeno aplicativo Web desenvolvido
em Django e alguns Casos de Teste para demonstração dos conceitos.

## Tutorial ##

O tutorial se encontra em https://meunomemauricio.github.io/robot-tutorial.

## Instalando Dependências ##

Aconselho a criar um ambiente virtual com o `virtualenv` para instalar as
dependências do projeto. É importante utilizar o *Python 2.7* como
interpretador, já que a biblioteca de testes do Selenium não foi portada para o
Python 3 ainda.

    $ virtualenv -p /usr/bin/python2.7 robottutorial
    $ source robottutorial/bin/activate

Instalar as dependencias com :

    $ pip install -r requirements.txt
    $ pip install -r tests/requirements.txt

Para abrir o aplicativo, iniciar o servidor HTTP do Django:

    $ cd demo
    $ python manage.py runserver

O aplicativo estará disponível acessando `http://localhost:8000/todo`.

[robot]: http://robotframework.org/
