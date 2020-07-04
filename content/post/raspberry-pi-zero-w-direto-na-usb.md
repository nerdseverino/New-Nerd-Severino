---
title: Raspberry - Pi Zero W direto na USB
date: '2020-07-04T15:20:57-03:00'
tags:
  - portugues
  - raspberry
  - raspbian
  - ''
autoThumbnailImage: false
thumbnailImagePosition: top
coverImage: ''
---
![raspberry pi zero](/images/uploads/raspberry-pi-zero.png)



Apesar de seu tamanho reduzido o Raspberry pi zero w é bem popular para projetos onde o tamanho seja um fator determinante.

Hoje vamos mostrar como fazer a ligação dele ao computador por meio da interface USB.

Uma característica do chip USB adicionado nessa versão é ser bem flexível e pode ser detectado de diferentes formas por outro dispositivo.

Caso você queira saber mais sobre isso pode dar uma [olhada nessa documentação.](https://gist.github.com/gbaman/50b6cca61dd1c3f88f41)

Para fazer o acesso do Raspberry diretamente pela interface **OTG USB**, vamos usar o módulo **Ethernet (g_ether)**.

Vamos listar alguns passos:

1 - Instalar o raspbian no seu cartão SD

2 - Editar o arquivo config.txt

Procure o arquivo na raiz do cartão. Caso esteja usando o Windows eu recomento eu que use o Notepad ++ para editar o arquivo por causa da codificação.

Acrescente no final do arquivo o seguinte:

_dtoverlay=dwc2_

_3 - Editar o arquivo cmdline.txt_

Logo após o rootwait, acrescente mais um espaço e cole:

 _modules-load=dwc2,g_ether _

Salve em seguida o arquivo.

Com isso a parte do cartão do SD está pronta, você já pode inseri-lo no slot e energizar o Raspberry usando a porta com a legenda USB.



Você pode também comprar em sites da internet adaptadores OTG USB dongle, existem variados modelos. 

Eu comprei esse aí de baixo no Mercado Livre por pouco mais de R$ 50,00 

![USB OTG dongle](/images/uploads/5ac72aacf3bcca6aaa1eecf3-large.jpg)
