Introdução
==========


Sobre o Framework
-----------------

O Robot é um **Framework Genérico de Automação de Testes**. É considerado
genérico porque ele serve para testar qualquer tipo de sistema, independente da
linguagem em que ele é escrito e de suas interfaces de usuário (CLI, GUI, Web,
etc...).

O foco dele é em **Testes de Aceitação**, ou seja, testes que garantem que as
especificações do usuário estão sendo atendidas pelo software. Tem como
escrever testes de unidade? Até tem, mas não tem porque, já que existem
ferramentas bem mais práticas pra isso (pytest, nosetest, etc...).

A ferramenta é **escrita em Python**, podendo ser executada nos principais
interpretadores Python (CPython/Jython/IronPython) e o código pode ser acessado
em `seu repositório GitHub`_.

.. _seu repositório GitHub: https://github.com/robotframework/robotframework

Vale comentar também que a partir da versão 3.0, o Robot pode se executado no
Python 3, porém fica o aviso de que algumas bibliotecas de teste ainda não
foram portadas (como é o caso da ``Selenium2Library``).


Porque usar o Robot?
--------------------

O grande propósito de se utilizar um framework de testes é **uniformizar a
maneira de escrever os testes**. É importante que todos as equipes trabalhando
no mesmo projeto “falem a mesma língua” na hora de escrever testes. Isso vai
além da linguagem da programação.

Testes de Unidade são escritos *pelos desenvolvedores, para os próprios
desenvolvedores*. Então não é problema eles serem um pouco mais "crípticos", já
que só precisam ser entendidos por quem está escrevendo código. No caso dos
Testes de Aceitação, **é muito mais importante escrever os testes em uma
linguagem acessível e mais humana**, já que provavelmente outros Stakeholders
do projeto (Product Owner, Gerentes de negócio, time de QA, etc...) dependam de
ler o que está sendo testado de forma a ter visibilidade da cobertura de testes
automáticos.

Para atingir essa uniformização, o Robot aposta em uma **sintaxe simples e
tabular**, apresentando o conceito de **Keywords**, que são frases que
expressam claramente a intenção de uma ação ou verificação que será feita no
sistema sendo testado. Definindo bem as Keywords de um teste, é possível
deixá-los tão legíveis que muitas vezes não é necessário documentação ou
comentários adicionais para entender o que os testes estão fazendo.

.. todo: continuar falando sobre os logs/reports e ferramentas CI


Bibliotecas de Teste
--------------------

Como expliquei anteriormente, o Robot busca ser um framework genérico. Ele
seria uma monstruosidade se tentasse implementar tudo o que é necessário pra se
interfacear com todo tipo de sistema possível e imaginável. O que ele faz então
é disponibilizar **uma API simples** que permite a criação de **Bibliotecas de
Teste.**

Isso não significa que é preciso reinventar a roda. Existem algumas bibliotecas
simples que já são integradas ao Robot (`Internal Libraries`_) para
funcionalidades comuns à maioria dos projetos (manipular strings, XML, executar
comandos no sistema operacional, etc...).

.. _Internal Libraries: http://robotframework.org/#libraries-standard

Há também disponíveis algumas bibliotecas externas (`External Libraries`_) que
utilizam ferramentas de teste (e.g.  Selenium, Appium, SSH, etc...). Estas
bibliotecas podem ser instaladas facilmente através de um ``pip install``.

.. _External Libraries: http://robotframework.org/#libraries-external

É somente no caso de precisar de uma interface específica do projeto, ou
precisar expandir alguma das bibliotecas já existentes é que a gente acaba
botando a mão na massa e escrevendo código Python.

.. todo:: falar da documentação das bibliotecas.

Arquitetura
-----------

.. todo:: escrever sobre arquitetura.

