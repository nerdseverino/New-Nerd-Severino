---
title: 'Dica: Comando df retorna disco cheio, mesmo não estando'
date: '2020-02-05T11:16:41-03:00'
categories:
  - Dicas
tags:
  - disco
  - df
  - linux
  - cheio
  - portugues
keywords:
  - dico
  - df
  - linux
  - cheio
autoThumbnailImage: false
thumbnailImagePosition: top
coverImage: /images/uploads/devices-drive-harddisk-icon.png
---
Já presenciei alguns casos onde o disco reporta no comando df que está cheio e na verdade ainda possui um pouco de espaço livre.

Isso causa mau funcionamento dos serviços no servidor e degradação de performance. 

Quando isso ocorre é preciso verificar se o disco não possui espaço reservado, um buffer de segurança para vc poder efetuar manutenção no sistema caso ele fique lotado.

Veja abaixo como podemos consultar o espaço reservado para o sistema e como ajustá-lo:

\- Para consultar as informações sobre a partição usamos o comando:

 **tune2fs -l /dev/sda3**

O resultado vai trazer todas as informações sobre a partição, nesse caso estamos interessados em _Reserved block count_:



**tune2fs -l /dev/sdX**

`tune2fs 1.42.9 (28-Dec-2013)`

`Filesystem volume name:   <none>`

`Last mounted on:          /`

`Filesystem UUID:          25e77052-3e2f-47a0-ba1d-4e3b5c698ac7`

`Filesystem magic number:  0xEF53`

`Filesystem revision #:    1 (dynamic)`

`Filesystem features:      has_journal ext_attr resize_inode dir_index filetype needs_recovery extent 64bit flex_bg sparse_super large_file huge_file uninit_bg dir_nlink extra_isize`

`Filesystem flags:         signed_directory_hash`

`Default mount options:    user_xattr acl`

`Filesystem state:         clean`

`Errors behavior:          Continue`

`Filesystem OS type:       Linux`

`Inode count:              15728640`

`Block count:              62914560`

# **`Reserved block count:     629145`**



Para modificar esse valor vc pode usar o mesmo tune2fs, mudando a porcentagem do disco que deseja reservar para manuteção de emergência:

**tune2fs -m 1 /dev/sdX **

_No caso o 1 representa 1% do tamanho total da partição._
