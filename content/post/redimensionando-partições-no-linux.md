---
title: Redimensionando partições no Linux
date: '2021-02-15T09:33:55-03:00'
categories:
  - Dicas
tags:
  - linux
  - resize
  - XFS
  - ext4
  - cli
  - ''
autoThumbnailImage: false
thumbnailImagePosition: top
coverImage: ''
---
![LVM LOGO](/images/uploads/how-to-resize-extend-lvm-partitioned-hard-disks-logical_volume_manager_lvm_logo.jpg)

Uma dúvida recorrente e também uma tarefa cotidiana do Sysadmin é ajustar (geralmetne aumentar) partições no Linux para evitar a interrupção de serviços. 

**_Obs.: Esse Lab foi feito com uma VM no Virtualbox com um disco apenas de 80Gb de tamanho no Centos 7, o procedimento pode variar para outras distribuições mas os passos são bem semelhantes_**

Primeiro eu recomendo que leia esse bom artigo sobre partições no Linux:

<https://www.vivaolinux.com.br/artigo/Particoes-Linux-Faca-direito>

Depois disso o interessante é identificar as partições do sistema, aqui cabe uma explicação rápida sobre como podemos "arrumar" as partições no linux: Elas podem ser criadas diretamente no disco físico (que é o procedimento mais comum) ou podem ser "arrumadas" em volumes Lógicos que podem conter vários discos físicos - LVM. 

Para identificarmos os discos usaremos o comando **fdisk** e o comando **df** do linux:

```
[user@lab1 ~]$ sudo fdisk -l
Disk /dev/sda: 85.9 GB, 85899345920 bytes, 167772160 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x000586db

Dispositivo Boot      Start         End      Blocks   Id  System
/dev/sda2         2099200   167772159    82836480   8e  Linux LVM
```

```
[user@lab1 ~]$ df -h
Sist. Arq.               Tam. Usado Disp. Uso% Montado em
devtmpfs                 484M     0  484M   0% /dev
tmpfs                    496M     0  496M   0% /dev/shm
tmpfs                    496M  6,8M  489M   2% /run
tmpfs                    496M     0  496M   0% /sys/fs/cgroup
/dev/mapper/centos-root   50G  1,6G   49G   4% /
/dev/sda1               1014M  197M  818M  20% /boot
/dev/mapper/centos-home   27G   33M   27G   1% /home
tmpfs                    100M     0  100M   0% /run/user/0
tmpfs                    100M     0  100M   0% /run/user/1000
```

Primeira coisa a fazer é editar o tamanho do seu VHD, essa etapa varia de virtualizador para virtualizador. No Virtualbox eu desliguei a VM e editei o tamanho do disco de 80 para 100Gb de tamanho. 

Depois de religar a VM se vocês notarem ao usar o **fdisk -l** ele já mostra o tamanho de **100Gb**, porém na partição ainda consta como **80Gb**. 

```
[user@lab1 ~]$ sudo fdisk -l
Disk /dev/sda: 107.4 GB, 107374182400 bytes, 209715200 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x000586db
Dispositivo Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048     2099199     1048576   83  Linux
/dev/sda2         2099200   167772159    82836480   8e  Linux LVM
```

```
[user@lab1 ~]$ df -h
Sist. Arq.               Tam. Usado Disp. Uso% Montado em
devtmpfs                 484M     0  484M   0% /dev
tmpfs                    496M     0  496M   0% /dev/shm
tmpfs                    496M  6,8M  489M   2% /run
tmpfs                    496M     0  496M   0% /sys/fs/cgroup
/dev/mapper/centos-root   50G  1,6G   49G   4% /
/dev/sda1               1014M  197M  818M  20% /boot
/dev/mapper/centos-home   27G   33M   27G   1% /home
tmpfs                    100M     0  100M   0% /run/user/1000
```

Bom então, como fazemos pra usar esse espaço que está sobrando no disco do nosso servidor?

Existe uma documentação da Red hat oficial sobre esse procedimento e vou deixar para consulta:

<https://access.redhat.com/articles/1190213>

Vamos a versão resumida:

1 - Usar o fdisk para remover a partição sda2 e depois recriá-la com todo tamanho disponível

**(Sim, parece louco excluir uma partição, mas não, os dados não serão apagados ao fazer isso e vc terá acesso ao espaço livre)**

```
fdisk /dev/sda
Command (m for help): d
Partition number (1-4): 2
```

Obs.: Nesse momento é extremamente importante que você não feche o fdisk e não entre com o w nas opções do prompt

2 - Agora vamos recriar a partição novamente com todo o espaço disponível

```
Command (m for help): n
Partition type:
   p   primary (1 primary, 0 extended, 3 free)
   e   extended
Select (default p): p
Partition number (2-4, default 2): 2
```

3 - Depois disso vc deve mudar o tipo da partição para LVM para que tudo fique como era antes

```
Command (m for help): t
Partition number (1,2, default 2): 2
Hex code (type L to list all codes): 8e
Changed type of partition 'Linux' to 'Linux LVM' 
```

4 - Se tudo deu certo até aqui podemos então gravar as alterações na nossa nova partição com mais espaço livre :D

```
Command (m for help): w
The partition table has been altered!
Calling ioctl() to re-read partition table.
WARNING: Re-reading the partition table failed with error 16: Device or resource busy.

The kernel still uses the old table. The new table will be used at the next reboot or after you run partprobe(8) or kpartx(8)

Syncing disks.
```

Nesse ponto eu recomendaria que vc reiniciasse o servidor para evitar problemas com o novo tamanho da partição de dados.

Depois de reiniciado e com as partições físicas com os tamanhos corretos, agora é hora de ajustar os Volumes LVM adicionando o espaço, isso é feito em 2 etapas, a primeira vc "informa" pro LVM que possui mais espaço Físico e na segunda atribui ela para um Volume. 

```
[root@lab1 ~]#  pvresize /dev/sda2

  Physical volume "/dev/sda2" changed

  1 physical volume(s) resized or updated / 0 physical volume(s) not resized
```

```
[root@lab1 ~]# lvresize /dev/mapper/centos-home /dev/sda2

  Size of logical volume centos/home changed from 26,99 GiB (6910 extents) to <27,00 GiB (6911 extents).

  Logical volume centos/home successfully resized.
```

Agora estamos prontos pra aumentar o volume lógico o escolhido é o que contém o /home

```
\[root@lab1 ~]# xfs_growfs /dev/centos/home 

meta-data=/dev/mapper/centos-home isize=512    agcount=4, agsize=1768960 blks

\=                       sectsz=512   attr=2, projid32bit=1

\=                       crc=1        finobt=0 spinodes=0

data     =                       bsize=4096   blocks=7075840, imaxpct=25

\=                       sunit=0      swidth=0 blks

naming   =version 2              bsize=4096   ascii-ci=0 ftype=1

log      =internal               bsize=4096   blocks=3455, version=2

\=                       sectsz=512   sunit=0 blks, lazy-count=1

realtime =none                   extsz=4096   blocks=0, rtextents=0
```

**Obs.: Se sua partição está como EXT4/3, use o comando resize2fs para fazer essa etapa.**

Depois de tudo isso podemos verificar o novo tamanho da partição com o comando df
```
[root@lab1 ~]# df -h

Sist. Arq.               Tam. Usado Disp. Uso% Montado em

devtmpfs                 484M     0  484M   0% /dev

tmpfs                    496M     0  496M   0% /dev/shm

tmpfs                    496M  6,8M  489M   2% /run

tmpfs                    496M     0  496M   0% /sys/fs/cgroup

/dev/mapper/centos-root   50G  1,6G   49G   4% /

/dev/sda1               1014M  197M  818M  20% /boot

/dev/mapper/centos-home   47G   33M   47G   1% /home

tmpfs                    100M     0  100M   0% /run/user/1000
```
Com isso redimensionamos a partição /home do servidor, até a próxima pessoal!
