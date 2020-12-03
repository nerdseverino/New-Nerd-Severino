---
title: Samba 4 em um Raspberry PI 3
date: '2020-12-03T18:08:37-03:00'
categories:
  - Dicas
keywords:
  - samba4
  - debian
  - raspbian
  - raspberry
  - active
  - directory
autoThumbnailImage: false
thumbnailImagePosition: top
coverImage: ''
---
![Samba4 Logo](/images/uploads/logo-samba-4.png)

Bom depois de fazer o[ tutorial do Samba 4](https://nerdseverino.com.br/2020/10/06/instalando-samba-4-no-raspberry-pi-3-model-b-rev-1.2/) e depois de mexer com Docker no pequeno PI, eu pensei porque não tentar colocar o Samba4 no Debian que é a base do Raspbian.

Com uma rápida pesquisa no google esse [tutorial ](https://www.server-world.info/en/note?os=Debian_10&p=samba&f=4) que ensina como fazer em um server X86.

Depois de fazer uma instalação limpa do Raspbian no cartão basta seguir o tutorial e vc vai ter um servidor funcional Samba 4 que pode seu utilizado para autenticar suas estações de trabalho, serviços e outros que você possa imaginar que sejam compatíveis com o Active Directory. 

Essa foi uma dica rápida com um exemplo do que podemos fazer com um pequeno equipamento, pode ajudar muito um escritório pequeno ou uma startup que precisa "organizar" a casa e centralizar os acessos e permissões. 

Sim nesse post não ensina a fazer nada de novo mas a intenção é começar a trazer algumas ferramentas que possam ser úteis e integradas criando soluções que possam ser úteis no dia-a-dia em um escritório.
