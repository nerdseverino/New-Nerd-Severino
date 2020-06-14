---
title: Administrando pacotes com o Yum
Date: '2020-03-11T11:33:38-03:00'
tag:
  - Yum
  - Centos
  - Rpm
categories:
  - Dicas

Keywords:
  - yum
  - centos
  - rpm
autoThumbnailImage: false
thumbnailImagePosition: top
coverImage: /images/uploads/cover-post.jpg
---
Estamos acostumados com o **Yum**, mas geralmente usamos apenas a opção install do mesmo, mas existem outros parâmetros bem interessantes do **Yum **que podem ser úteis no seu dia-a-dia.

Esse artigo tem o objetivo de mostrar alguns deles:

1 - Verificar os pacotes instalados no servidor:

`sudo yum list installed`

2 - Se você precisa acompanhar a lista na tela "paginando":

`sudo yum list installed | more`

3 - Se você precisa gerar uma lista de pacotes instalados:

`sudo yum list installed > /tmp/pacotes_instalados`

4 - Se você precisa saber se o pacote Nginx está instalado no servidor:

`sudo yum list installed | grep nginx`

5 - Dentro do list ainda tem um recurso bacana que é verificar se um pacote foi instalado em modo local:

`sudo yum list extras`

6 - É possível também usar o comando **wc **para contar o número de pacotes instalados:

`sudo yum list installed | wc -l`

7 - Podemos usar o list também para listar os upgrades do sistema:

`sudo yum list upgrades`

E a cereja do bolo é o comando History do **Yum**:

`sudo yum history`

Exemplo:


ID     | Login user               | Date and time    | Action(s)      | Altered

- - -

```
17 | root <root>              | 2020-02-19 09:24 | Install        |    1

16 | root <root>              | 2020-02-19 08:55 | Install        |    1

15 | root <root>              | 2020-02-19 07:10 | Update         |    4 EE

14 | root <root>              | 2020-02-18 14:28 | Update         |    2

13 | root <root>              | 2020-02-11 11:16 | I, U           |   82 EE

12 | root <root>              | 2020-01-10 07:24 | I, U           |  124 EE

11 | root <root>              | 2019-12-02 13:35 | Install        |    3

10 | root <root>              | 2019-11-26 14:33 | Install        |    3

 9 | root <root>              | 2019-10-03 11:37 | Erase          |    2 EE

 8 | root <root>              | 2019-09-30 12:01 | Install        |    9

 7 | root <root>              | 2019-09-30 10:57 | I, O, U        |  546 E<

 6 | root <root>              | 2019-08-20 13:11 | Install        |    4 >

 5 | root <root>              | 2019-07-15 13:45 | Update         |   28

 4 | root <root>              | 2019-06-28 13:28 | Install        |    9

 3 | osboxes.org <osboxes>    | 2019-06-28 10:58 | Install        |    4

 2 | System <unset>           | 2019-06-28 10:49 | I, U           |  184 EE

 1 | System <unset>           | 2019-02-11 13:11 | Install        | 1390
```



Com ele você consulta as últimas ações e é possível desfazer ou refazê-las conforme necessário.  :D
