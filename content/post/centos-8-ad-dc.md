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

**yum -y install epel-release**

E depois temos que ativar o repositório PowerTools

**yum config-manager --set-enabled PowerTools**

E rodamos a atualização do servidor

**yum update -y**

Depois disso é recomendado você reiniciar o servidor.

De volta ao sistema agora vamos instalar as dependências para podermos compilar o samba 4 com role AD-DC:

**yum install docbook-style-xsl gcc gdb gnutls-devel gpgme-devel jansson-devel keyutils-libs-devel krb5-workstation libacl-devel libaio-devel libarchive-devel libattr-devel libblkid-devel libtasn1 libtasn1-tools libxml2-devel libxslt lmdb-devel openldap-devel pam-devel perl perl-ExtUtils-MakeMaker perl-Parse-Yapp popt-devel python3-cryptography python3-dns python3-gpg python36-devel readline-devel rpcgen systemd-devel tar zlib-devel cups-devel wget -y**

Em seguida, vamos editar o arquivo hosts

**vim /etc/hosts**

`192.168.2.7     srvdc01.home.local    srvdc01`

**Obs.: Ajuste o IP e o nome conforme a sua configuração.**

Depois a gente configura a resolução de nomes do servidor, vai ser importante mais pra frente:

**vim /etc/resolv.conf**

`domain home.local`

`nameserver 192.168.2.22`

`search srvdc01.home.local`

Após configurar e salvar o “/etc/resolv.conf” execute o comando “chattr +i” para garantir que o arquivo não seja modificado pelo sistema.

**chattr +i /etc/resolv.conf**

Até aqui apenas ajustamos o sistema para receber o samba, agora vamos baixar o samba e começar a trabalhar nele :D

**wget https://ftp.samba.org/pub/samba/samba-latest.tar.gz**

Descompactar os arquivos

**tar -xzvf samba-latest.tar.gz**

Entrar na pasta

**cd samba-4.12.6**

E rodar o "./configure"

**./configure**

Nesse ponto ele vai verificar se o sistema atende todos os requisitos para compilar o samba 4, caso tudo esteja certo ele vai apresentar a mensagem abaixo:

_'configure' finished successfully (1m23.880s)_

Agora é a vez do "Make"

**make**

E por último o "Install" pra colocar tudo no lugar correto dentro do sistema.

**make install**

Se tudo terminar bem o resultado será esse:

_'build' finished successfully (20m34.783s)_

Pra facilitar criamos um script que ajusta PATH para os comandos do samba: 

**vim /etc/profile.d/samba4.sh**

`if [ $(id -u) -eq 0 ]`

`then`

`PATH="/usr/local/samba/sbin:$PATH"`

`fi`

`PATH="/usr/local/samba/bin:$PATH"`

`export PATH`

Damos permissão com:

**chmod +x /etc/profile.d/samba4.sh**

Agora vem a parte mais importante do processo: Provisionamento do Domínio

**samba-tool domain provision --use-rfc2307 --interactive**

Onde:

```
domain provision = para elevar o SAMBA a controlador de domínio;

–use-rfc2307 = ativa o Network Information Server (NIS);

–interactive = Modo interativo que permite realizar as configurações do domínio.
```

Ele vai solicitar algumas informações nesse ponto pois escolhemos a opção interativa no provisionamento, são elas:

   **Realm \[HOME.LOCAL]** : Se o “/etc/hosts” e o “/etc/resolv.conf” estiverem definidos basta pressionar ENTER, caso não estejam configurados digite o nome do domínio desejado.

   **Domain : \[HOME] ** : “pressione enter”;

   **Server Role (dc, manber, standalone,) \[dc]** : Como utilizaremos nosso SAMBA como DC basta pressionar ENTER;

  **DNS backend (SAMBA_INTERNAL, BIND9, BIND9_DLZ) \[SAMBA_INTERNAL]** : O DNS que iremos escolher o SAMBA_INTERNAL que é o padrão da instalação, bastando pressionar “ENTER”;

  **DNS forwarder IP address (write ‘none’ to disable forwarding) \[192.168.2.22]** : Aqui onde definimos o servidor que vai fazer a resolução de nomes externos, pois os nomes de máquina internos vão ser resolvidos pelo SAMBA_INTERNAL

  ** Administrator password** : Definição da senha de administrador deve conter “letras, números e caracteres especiais” para que não aja erro no processo de provisionamento;

  **Retype password**: Repita a senha digitada anteriormente.

Existem mais alguns passos para colocarmos nosso samba a funcionar a todo vapor :D

Copiar o **krb5.conf** para o local correto:

**cp /usr/local/samba/private/krb5.conf /etc/**

Criar alguns links para funcionando do winbind:

**ln -s /usr/local/samba/lib/libnss_winbind.so.2 /lib/libnss_winbind.so**

**ln -s /lib/libnss_winbind.so /lib/libnss_winbind.so.2**

**ln -s /usr/local/samba/lib/libnss_winbind.so.2 /lib64/libnss_winbind.so**

**ln -s /lib/libnss_winbind.so /lib64/libnss_winbind.so.2**

E ajustarmos o mecanismo de autenticação do Linux (CentOS) para usar as contas do samba também:

**vim /etc/nsswitch.conf**

Vai ficar assim:

`passwd:     files sss winbind`

`group:      files sss winbind`

Agora só precisamos fazer um script para manejar o samba através do SystemD

**vim /lib/systemd/system/samba-dc.service**

`[Unit]`

`Description= Samba 4 Active Directory`

`After=syslog.target network.target remote-fs.target nss-lookup.target`

`[Service]`

`Type=forking`

`LimitNOFILE=16384`

`ExecStart=/usr/local/samba/sbin/samba -D`

`ExecReload=/usr/bin/kill -HUP $MAINPID`

`PIDFile=/usr/local/samba/var/run/samba.pid`

`[Install]`

`WantedBy=multi-user.target`

Agora podemos habilitar ele na inicialização do sistema:

**systemctl enable samba-dc**

E por fim iniciar o serviço:

**systemctl start samba-dc**

# Bônus:

Se você não quer desativar o **Selinux** e o **Firewall** segue os passos abaixo pra não ser atrapalhado pelos dois:

Firewall: 

**firewall-cmd --permanent --add-service=samba**

**firewall-cmd --reload**

Selinux:

* instalar o pacote policycoreutils-python-utils

**yum install policycoreutils-python-utils**

* executar os comandos abaixo:

**setenforce 0**

**cd /tmp**

**grep denied /var/log/audit/audit.log > selinuxloginfails**

**audit2allow -M samba4 -i selinuxloginfails**

**semodule -i samba4.pp**

**setenforce 1**

Era isso por enquanto pessoal, deixe nos comentários sugestões, correções ou opiniões sobre esse tutorial, quem sabe sai um vídeo mostrando como eu fiz ele aqui pra vocês :P
