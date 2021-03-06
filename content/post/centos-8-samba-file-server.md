---
title: Centos 8 - Adicionando o Servidor ao Domínio (Samba4 ou AD-MS)
date: '2020-08-25T03:24:50-03:00'
categories:
  - Tutoriais
tags:
  - centos 8
  - file server
  - acl
  - permissões
keywords:
  - centos 8
  - file server
  - acl
  - permissões
autoThumbnailImage: false
thumbnailImagePosition: top
coverImage: ''
---
![Samba 4 Logo](/images/uploads/logo-samba-4.png)

Olá Pessoal lembram do tutorial anterior onde criamos um controlador de domínio usando o **Centos 8** e o ** Samba 4**, provisionando um Domínio para as estações Windows e Linux da Rede.

Hoje a tarefa é dar prosseguimento e colocar o servidor Samba no Domínio como membro. 



Vocês podem notar que a primeira parte de instalação do pacote do Samba é bem mais tranquila que a anterior:

**
sudo dnf install realmd sssd oddjob oddjob-mkhomedir adcli samba-common samba-common-tools krb5-workstation authselect-compat
**

Próximo passo é liberar o serviço no firewall:

**
firewall-cmd --permanent --zone=public --add-service=samba
**

**firewall-cmd --reload
**

Nesse ponto eu vou abordar uma coisa importante, no Linux nos temos o modelo de permissão que é Usuário, Grupo e Outros. Em um servidor de arquivos as vezes é necessário um sistema de permissão mais complexo que isso, então no disco onde ficam os dados a gente usa uma flag de montagem chamada ACL que aciona um módulo do Kernel que permite "expandir" as permissões e vai ser usado pra podermos trabalhar melhor com grupos e usuários do DC.

Para isso no /etc/fstab, você deve incluir um acl logo após o defaults do disco onde os dados vão ficar.

_
UUID=5c7527da-7c10-49fa-9063-a288fd218675  /dados       ext4    defaults,acl 0 0
_

Para descobrir o UUID do disco** use o tune2fs -l /dev/sdx **(onde sdx é o device do seu Disco).

O próximo passo para ingressar a máquina no domínio do Samba é verificar se o DNS está apontando para o servidor Samba que criamos anteriormente.

**
vim /etc/resolv.conf
**

```
# Generated by NetworkManager
search home.local
nameserver 192.168.2.7
```

Feito isso podemos verificar se o servidor do domínio está respondendo corretamente como abaixo:

**realm  discover home.local**

```
home.local
  type: kerberos
  realm-name: HOME.LOCAL
  domain-name: home.local
  server-software: active-directory
  client-software: sssd
  required-package: oddjob
  required-package: oddjob-mkhomedir
  required-package: sssd
  required-package: adcli
  required-package: samba-common-tools
```

  Se tudo está correto podemos então ingressar o servidor no domínio com o comando abaixo:

** realm join home.local -U Administrator**

A senha do Administrator será requisitada para a operação.

Certo ele retorna pro terminal sem apresentar erro, como eu fico sabendo se ele está no Domínio ou não?

Nesse ponto vc deve notar que no primeiro realm discover o resultado mostra um status **configured: no** e depois do adicionar o servidor no domínio o status muda para **configured: kerberos-member**

Certo até aqui ingressamos o servidor no Domínio mas ele já tá pronto? Ainda não!

Agora precisamos fazer o Linux usar o novo método de autenticação usando as credenciais do domínio.

O primeiro passo pra isso é rodar os comandos: 

**sudo authselect select sssd**

**sudo authselect select sssd with-mkhomedir**

Quando executa o segundo comando ele na saída pede que você inicialize o serviço oddjobd:

**systemctl enable oddjobd.service**

**systemctl start oddjobd.service**

Podemos verificar se o sssd.conf está correto com o comando:

**cat /etc/sssd/sssd.conf **

Ele deve parecer com isso:

```
[sssd]
domains = home.local
config_file_version = 2
services = nss, pam
[domain/home.local]
ad_domain = home.local
krb5_realm = HOME.LOCAL
realmd_tags = manages-system joined-with-adcli
cache_credentials = True
id_provider = ad
krb5_store_password_if_offline = True
default_shell = /bin/bash
ldap_id_mapping = True
use_fully_qualified_names = True
fallback_homedir = /home/%u@%d
access_provider = ad
```

Se tudo estiver correto podemos reiniciar o serviço SSSD:

**sudo systemctl restart sssd**

E podemos testar se as contas do domínio estão funcionando com o seguinte comando:

**id administrator@home.local**

_uid=1324800500(administrator@home.local) gid=1324800513(domain users@home.local) grupos=1324800513(domain users@home.local),1324800520(group policy creator owners@home.local),1324800512(domain admins@home.local),1324800518(schema admins@home.local),1324800519(enterprise admins@home.local),1324800572(denied rodc password replication group@home.local)_

Precisamos também verificar o Kerberos:

**vim /etc/krb5.conf**

```
# To opt out of the system crypto-policies configuration of krb5, remove the
# symlink at /etc/krb5.conf.d/crypto-policies which will not be recreated.
includedir /etc/krb5.conf.d/
[logging]
   
    default = FILE:/var/log/krb5libs.log
    kdc = FILE:/var/log/krb5kdc.log
    admin_server = FILE:/var/log/kadmind.log

[libdefaults]
  
    dns_lookup_realm = false
    ticket_lifetime = 24h
    renew_lifetime = 7d
    forwardable = true
    rdns = false
    pkinit_anchors = FILE:/etc/pki/tls/certs/ca-bundle.crt
    spake_preauth_groups = edwards25519
    default_realm = HOME.LOCAL
    default_ccache_name = KEYRING:persistent:%{uid}

[realms]

# EXAMPLE.COM = {
#     kdc = kerberos.example.com
#     admin_server = kerberos.example.com
#
# }

[domain_realm]
# .example.com = EXAMPLE.COM
# example.com = EXAMPLE.COM
#

[realms]
HOME.LOCAL = {
kdc = srvdc01.home.local
default_domain = home.local
admin_server = srvdc01.home.local
}

[domain_realm]
.home.local = HOME.LOCAL
home.local = HOME.LOCAL
```
