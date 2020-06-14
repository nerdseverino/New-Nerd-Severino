---
title: 'Xenserver: adicionar placa fisica no xen'
date: '2020-02-04T16:06:41-03:00'
categories:
  - Dicas
tags:
  - xenserver
  - nic
  - placa de rede
  - linux
keywords:
  - xenserver
  - nic
  - placa de rede
  - linux
autoThumbnailImage: false
thumbnailImagePosition: top
thumbnailImage: /images/uploads/xenserver_logo_original.png
coverImage: ''
---
1 - Logue no Console do xenserver e rode o seguinte comando:

**xe host-list**

`uuid ( RO)                : a7c4230f-84fd-47a3-89a1-dd1b4feaf4ec`

`name-label ( RW): localhost`

`name-description ( RO): Default install of XenServer`

**Obs.: Anote o uuid pois usaremos mais adiante**.

2 - Agora vamos verificar se a interface física foi detectada no xenserver para isso usamos o comando:

**xe pif-list host-uuid=\[uuid of the XenServer host]**

`uuid ( RO)                  : c9669949-e4d0-e58d-2d73-aebe37f4d725`

`device ( RO): eth0`

`currently-attached ( RO): true`

`VLAN ( RO): -1`

`network-uuid ( RO): dcac1d5c-559e-1c63-59ef-4255ac191440`

`uuid ( RO)                  : 4bc8e60b-0aab-4ee6-0983-3718121dba64`

`device ( RO): eth1`

`currently-attached ( RO): true`

`VLAN ( RO): -1`

`network-uuid ( RO): cac4eefd-c5b4-99d6-3a28-6a1671e49d4e`

`uuid ( RO)                  : 4d9bf1ef-d34d-b91d-ce4c-013762d2a273`

`device ( RO): __tmp206888048`

`currently-attached ( RO): true`

`VLAN ( RO): -1`

`network-uuid ( RO): 1b98d2f1-18b4-530d-aae6-3f8a5fdbcbed`

Serão listadas todas as interfaces disponíveis, caso sua nova interface não apareça usaremos o comando: 

**xe pif-scan host-uuid=\[uuid of the XenServer host]
**

Ele não tem saída na tela e depois dele podemos executar o pif-list novamente do passo anterior.

3 - Se tudo der certo até aqui você verá um dispositivo com o final __tmp206888048, essa é sua placa mas precisaremos corrigir o nome dela e ajustar no device correto.

Começamos então com um ifconfig para obtermos o mac da placa de rede nova:

**ifconfig -a**

`__tmp206888048 Link encap:Ethernet HWaddr 00:15:17:6B:6A:31`

`UP BROADCAST MULTICAST MTU:1500 Metric:1`

`RX packets:0 errors:0 dropped:0 overruns:0 frame:0`

`TX packets:0 errors:0 dropped:0 overruns:0 carrier:0`

`collisions:0 txqueuelen:1000`

`RX bytes:0 (0.0 b) TX bytes:0 (0.0 b)`

Copie o Mac vamos precisar dele para criar o dispositivo. Agora vamos fazer o sistema "esquecer" o device temporário que ele criou com o uudi que listamos acima:

**xe pif-forget uuid=4d9bf1ef-d34d-b91d-ce4c-013762d2a273**

E logo em seguida adicioná-la novamente com o Device Correto:

**xe pif-introduce host-uuid=\[uuid of the XenServer host] device=\[machine-readable name of the interface (for example, eth3)] mac=00:15:17:6B:6A:31
**

Depois disso ativamos a nova placa com o comando:

**xe pif-plug uuid=4d9bf1ef-d34d-b91d-ce4c-013762d2a273
**

No final entre no Xencenter e adicione a placa na aba Networking e adicione a placa relacionando com o Device real.

Clique em add network depois em external network

Coloque um nome

Em nick relaciona com a placa real, e a vlan relacionada.

(Caso não tenha vlan deixe com o valor padrão)

Depois clique em finish e está pronta para ser adicionada nas VM's
