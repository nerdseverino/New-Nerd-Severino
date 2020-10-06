---
title: Saga dos containers no raspberry - Parte2
date: '2020-10-02T10:48:59-03:00'
categories:
  - Dicas
tags:
  - ''
keywords:
  - docker
  - raspberry
  - zero
  - w
  - linux
  - containers
autoThumbnailImage: false
thumbnailImagePosition: top
coverImage: ''
---
![Raspberry+docker](/images/uploads/1-sld_ocnoe1dvkrij1whliw.png)

Continuando a minha saga de rodar containers no raspberry pi zero w. Para esclarecer essa empreitada toda tem fins didáticos de validar o que é possível fazer com um hardware pequeno em dimensões.

Bom de cara a diferença mais óbvia é a arquitetura do processador (ARMv6), mas eu já falei um pouco disso no meu [post anterior.](https://nerdseverino.com.br/2020/08/19/raspberry-rodando-containers-no-raspberry-pi-atualizado-10/09/2020/)

Isso parece pouca coisa, mas não é, muitas das imagens que funcionaram tranquilamente no Raspberry PI 3 (ARMv7) não funcionaram corretamente nessa versão do PI Zero.

Vou pegar o exemplo que mais me fez quebrar a cabeça: ugeek/mariadb
Eu queria rodar o container do Nextcloud e Nginx proxy manager. 

Ao criar o container com essa imagem ele encerra com o código de saída 139. Depois de algumas pesquisas eu cheguei na informação que era erro de arquitetura (do processador).

Daí eu iniciei uma saga atrás de uma imagem que funcionasse nessa board. 


