---
title: Usando armazenamento remoto com o SSHFS
date: '2020-06-22T08:36:31-03:00'
categories:
  - Dicas
tags:
  - Portugues
keywords:
  - ssh
  - fs
  - cli
  - remote
autoThumbnailImage: false
thumbnailImagePosition: top
coverImage: ''
---
<p align="center">

<img src="/images/uploads/1full_colored_dark.png" width="350" title="Raspberry pi logo">

</p>

_Eu estava aqui pensando em como fazer o backup do sistema do meu Raspberry PI Zero W que tem um cartão micro ssd de 32 Gb._

Depois de quebrar um pouco a cabeça eu lembrei que o SSH é verdadeiramente um canivete suíço :P

Sendo assim eu lembrei que o ssh possui uma ferramenta que permite montar um File System sobre o túnel ssh.

Para instalar o SSHFS no Debian/Ubuntu ou no CentOS seguem os comandos:

**sudo apt-get install sshfs**\
**yum install fuse-sshfs **

Depois de instalado para efetuar a montagem do File System você precisa executar a linha abaixo:

**sshfs -o allow_other,default_permissions root@xxx.xxx.xxx.xxx:/ /mnt/remote**

Caso você tenha uma chave RSA configurada no servidor 

**sshfs -o allow_other,default_permissions,IdentityFile=~/.ssh/id_rsa root@xxx.xxx.xxx.xxx:/ /mnt/remote**

Se você está em uma rede local e precisa desse compartilhamento permanentemente pode colocar esse ponto de montagem no arquivo /etc/fstab, mas faça isso com cautela pois caso o servidor remoto esteja indisponível, seu servidor não vai iniciar corretamente.
