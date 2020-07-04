---
title: 'Raspberry PI - Introdução '
date: '2020-07-04T07:40:23-03:00'
tags:
  - portugues
  - raspberry
keywords:
  - raspberry
  - história
  - sbc
  - computador
autoThumbnailImage: false
thumbnailImagePosition: top
coverImage: ''
---
![raspberry pi logo](/images/uploads/small-raspberry-pi.png)

## Afinal o que é o tal do Raspberry?

Existem no mercado uma categoria de equipamentos que chamamos de **SBC (Single Board Computer)** que traduzindo literalmente seria um **Computador de placa única** [\[1]](https://pt.wikipedia.org/wiki/Computadorde_placa%C3%BAnica), que como o nome sugere tem todos os seus componentes em uma única placa para desempenhar as suas funções.\
Eles geralmente são chamados também de sistemas embarcados, placas de IoT, e outros.

## História

Em 2006 os primeiros conceitos de um computador que motivasse as crianças a desenvolverem algo criativo, ele foi baseado originalmente no microcontrolador Atmel ATmega644 e mais tarde usado a arquitetura ARM, um pacote do mesmo tamanho de uma memória stick USB, uma porta USB em uma extremidade e uma porta HDMI na outra. \[[2]](https://pt.wikipedia.org/wiki/Raspberry_Pi)

>  _O objetivo da Fundação era oferecer o computador por um preço bem acessível, em duas versões: US $ 25 e US $ 35. Eles começaram a aceitar encomendas pelo modelo B que era o de maior preço (US $ 35), em 29 de fevereiro de 2012, e o pelo modelo A, de menor preço (US $ 25), em 4 de Fevereiro de 2013. A diferença entre o Modelo A para o Modelo B, é que o primeiro não tem interface de rede._

De lá pra cá várias versões do pequeno computador foram lançadas com diferentes tamanhos mas mantendo suas características de placa de desenvolvimento para projetos educacionais e o público Maker.

## Versões

O pessoal do [TechTudo ](https://www.techtudo.com.br/)fez uma lista a um tempo atrás com a descrição das principais versões disponíveis hoje que pode ser conferida \[aqui [3]]([(https://www.techtudo.com.br/listas/2018/12/raspberry-pi-conheca-todos-os-modelos-e-precos-do-minipc.ghtml](<(https://www.techtudo.com.br/listas/2018/12/raspberry-pi-conheca-todos-os-modelos-e-precos-do-minipc.ghtml>)) e a versão mais atual enquanto escrevo esse texto que pode ser conferida \[aqui. [4]](https://www.techtudo.com.br/noticias/2019/09/tudo-sobre-o-raspberry-pi-4-veja-especificacoes-e-preco-do-mini-pc.ghtml).

# Anatomia

![raspberry pi 3 B+](/images/uploads/raspberry-pi-3b-top_700.jpg)

Como mostrado na imagem a placa tem um design bem simples com os conectores ao redor da mesma. 

**Chip BCM2837B0 1.4GHz
**

O chip é o BCM2837B0, que foi aprimorado para melhorar a fonte de alimentação dos núcleos ARM. Isso significa que eles podem ter clock de 1,4 GHz (anteriormente 1,2 GHz) - um aumento de 16,7%.
 Ele é o coração da placa e tem poder de processamento pra uma variedade de tarefas.

Enquanto era fabricado, decidiu-se adicionar um dissipador de calor metálico e aprimorar o PCB para ajudar na dissipação de calor. Isso deve ajudar a manter a temperatura controlada com velocidades de clock mais altas.

![Chip BCM2837B0 e seu dissipador metálico](/images/uploads/bcm2837b0-on-rasbperry-pi-3b_700-292x300.jpg)

**Rede sem fio 802.11ac
**

Ele usa o Cypress 43455 “MAC / base-band / rádio WiFi IEEE 802.11ac WiFi de chip único com Bluetooth 4.2 e receptor FM integrado” (receptor FM não conectado).

* A antena de cerâmica foi substituída por uma antena de cavidade ressonante Proant (mesma usada no Pi Zero W)
  .
* Os componentes sem fio / Bluetooth foram incluídos em uma lata metalizada
* O 802.11ac agora é suportado, o que significa que o Pi pode fazer WiFi a 5 GHz e 2,4 GHz

![local da antena wi-fi e bluetooth na placa](/images/uploads/proant-antenna-on-raspberry-pi-3b_700-300x214.jpg)

![Detalhe antena wi-fi e bluetooth](/images/uploads/proant-antenna-on-rasbperry-pi-3b-underside_700-300x152.jpg)

Os componentes sem fio e Bluetooth agora estão dentro de uma lata metalizada. Esse grupo de componentes foi aprovado pela FCC como módulo, o que significa que, se você incorporar um Pi3B + em um produto, a transmissão sem fio / BT não precisará de mais nenhuma certificação. A lata também possui o logotipo do Raspberry Pi gravado, o que é um toque bastante agradável…

O Pi3B + 802.11ac a 5 GHz tem desempenho de até 100 Mbit. Se você opera em um ambiente wifi congestionado, a mudança para 5 GHz pode oferecer algumas melhorias significativas. É sempre bom ter escolhas.

## Base-1000 Ethernet

O Pi 3B + usa um chip Microchip LAN7515 para ethernet e hub USB 2.0. Portanto, ele pode tirar proveito de uma conexão Ethernet Gigabit, mas, devido às limitações do USB 2.0, seu rendimento máximo é de 330 Mbit.

![Microchip LAN7515](/images/uploads/lan7515-on-raspberry-pi-3b_700-300x267.jpg)

## 

Especificações

* Chip BCM2837B0
* CPU córtex A53 quad-core de 64 bits
* Com clock de 1.4GHz
* ~ 16% mais rápido que o Pi 3B
* GPU VideoCore IV de 400 MHz
* SDRAM LPDDR2-900 de 1 GB
* Chip Cypress 43455 para conexão sem fio e Bluetooth
* LAN sem fio 802.11ac
* Bluetooth 4.2

## Conectividade

* 26 portas GPIO na configuração Pi padrão de 40 pinos
* 4 USB 2 ports
* Ethernet 1000 Base-T (velocidade máxima de 330 Mbit)
* Porta DSI
* Porta CSI
* Vídeo / áudio composto de 4 polos
* HDMI 1.4

## Alimentação

* Alimentação micro-usb
* Fornecimento de 2,5 Amp recomendado

No próximo artigo vou falar a respeito dos Sistemas operacionais que podemos usar nessa placa para fazer coisas divertidas :D
