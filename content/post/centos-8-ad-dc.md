---
title: Centos 8 + AD-DC
date: '2020-08-25T02:04:20-03:00'
categories:
  - Tutorial
tags:
  - Centos
  - samba
  - active
  - directory
  - ldap
keywords:
  - Centos
  - samba
  - active
  - directory
  - ldap
autoThumbnailImage: false
thumbnailImagePosition: top
coverImage: ''
---
![Centos Logo](/images/uploads/capa_centos.png)



# O que é o Samba?



O Samba 4.x compreende um servidor de diretório LDAP, um servidor de autenticação Heimdal Kerberos, um servidor DNS dinâmico e implementações de todas as chamadas de procedimento remoto necessários para o Active Directory.



Para quem vem do mundo Windows está acostumando com o conceito de Active Directory e com o Samba 4 isso é possível, gerenciar todos os logins e polices de estações windows a partir de um servidor central.



Para iniciar os trabalhos vamos adicionar o repositório EPEL no Centos:

**yum -y install epel-release**



E depois temos que ativar o repositório PowerTools



**yum config-manager --set-enabled PowerTools**



E rodamos a atualização do servidor



**yum update -y**



_Depois disso é recomendado você reiniciar o servidor._



De volta ao sistema agora vamos instalar as dependências para podermos compilar o samba 4 com role AD-DC:



**yum install docbook-style-xsl gcc gdb gnutls-devel gpgme-devel jansson-devel keyutils-libs-devel krb5-workstation libacl-devel libaio-devel libarchive-devel libattr-devel libblkid-devel libtasn1 libtasn1-tools libxml2-devel libxslt lmdb-devel openldap-devel pam-devel perl perl-ExtUtils-MakeMaker perl-Parse-Yapp popt-devel python3-cryptography python3-dns python3-gpg python36-devel readline-devel rpcgen systemd-devel tar zlib-devel cups-devel wget -y**



Em seguida, vamos editar o arquivo hosts



**vim /etc/hosts**



`192.168.2.30     srvdc01.home.local    srvdc01 `

**Obs.: Ajuste o IP e o nome conforme a sua configuração.**



Até aqui apenas ajustamos o sistema para receber o samba, agora vamos baixar o samba e começar a trabalhar nele :D



**wget https://ftp.samba.org/pub/samba/samba-latest.tar.gz**



Descompactar os arquivos



**tar -xzvf samba-latest.tar.gz**



Entrar na pasta



**cd samba-4.12.6**



E rodar o "./configure"



**./configure**



Nesse ponto ele vai verificar se o sistema atende todos os requisitos para compilar o samba 4, caso tudo esteja certo ele vai apresentar a mensagem abaixo:

_'configure' finished successfully (1m23.880s)_



Agora é a vez do "Make"

**make** 

E por último o "Install" pra colocar tudo no lugar correto dentro do sistema.

**make install**



Se tudo terminar bem o resultado será esse:

_'build' finished successfully (20m34.783s)_
