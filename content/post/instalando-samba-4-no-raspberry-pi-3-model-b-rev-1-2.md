---
title: Instalando samba 4 no Raspberry Pi 3 Model B Rev 1.2
date: '2020-10-06T05:05:47-03:00'
categories:
  - Tutoriais
  - ''
tags:
  - raspberry
  - samba4
keywords:
  - raspberry
  - samba4
  - AD-DC
  - Active
  - Directory
  - linux
  - domain
autoThumbnailImage: false
thumbnailImagePosition: top
coverImage: ''
---
![samba4 logo](/images/uploads/logo-samba-4.png)

Vamos começar essa jornada com uma instalação limpa do Raspbian e logo em seguida liberando algum espaço adicional no disco:

 	
**sudo apt-get purge wolfram-engine libreoffice* scratch -y**

**sudo apt-get clean**

**apt-get autoremove -y**

Depois de liberar algum espaço vamos iniciar a instalação de pacotes que vamos precisar:

**sudo apt-get install samba smbclient winbind krb5-user krb5-config krb5-locales winbind libpam-winbind libnss-winbind**

## Agora, vamos configurar um IP fixo para o raspberry pi:

**sudo vim /etc/dhcpcd.conf**

```
# explicitely use eth0 and set static IPs, as well as domain specifics
interface eth0
static routers=192.168.1.1
static domain_name_servers=127.0.0.1
static domain_name_servers=192.168.1.1
static ip_address=192.168.1.2
static domain_search=my.domain.local
```

Não esqueça de configurar endereços que sejam no range da sua rede!

## Desativar entradas Legadas/Antigas pra evitar erros

**sudo systemctl stop samba-ad-dc.service smbd.service nmbd.service winbind.service**
**sudo systemctl disable samba-ad-dc.service smbd.service nmbd.service winbind.service**

## Provisionar o Domínio no samba:

Obs: antes de fazer alterações verifique qual o caminho do arquivo de configuração do samba e fazer uma cópia do mesmo:
**sudo smbd -b | grep "CONFIGFILE"**
  `CONFIGFILE: /etc/samba/smb.conf`

**sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.backup**

Agora estamos prontos pra provisionar o Dominio:

**sudo samba-tool domain provision --use-rfc2307 --interactive**

**Realm \[MY.DOMAIN.LOCAL]** : Se o **“/etc/hosts”** e o **“/etc/resolv.conf”** estiverem definidos basta pressionar ENTER, caso não estejam configurados digite o nome do domínio desejado.

**Domain : \[MY.DOMAIN]** : “pressione enter”;

**Server Role (dc, manber, standalone,) \[dc]** : Como utilizaremos nosso SAMBA como DC basta pressionar ENTER;

**DNS backend (SAMBA_INTERNAL, BIND9, BIND9_DLZ) \[SAMBA_INTERNAL]** : O DNS que iremos escolher o SAMBA_INTERNAL que é o padrão da instalação, bastando pressionar “ENTER”;

**DNS forwarder IP address (write ‘none’ to disable forwarding) \[8.8.8.8]** : Aqui onde definimos o servidor que vai fazer a resolução de nomes externos, pois os nomes de máquina internos vão ser resolvidos pelo SAMBA_INTERNAL

**Administrator password** : Definição da senha de administrador deve conter “letras, números e caracteres especiais” para que não aja erro no processo de provisionamento;

**Retype password:** Repita a senha digitada anteriormente.

Depois de provisionar o domínio você vai precisar ajustar o Kinit:

**sudo ln -sf /var/lib/samba/private/krb5.conf /etc/krb5.conf**
**sudo vim /etc/krb5.conf**

```
[libdefaults]
        default_realm = MY.DOMAIN.LOCAL
        dns_lookup_realm = false
        dns_lookup_kdc = true
[realms]
MY.DOMAIN.LOCAL = {
        kdc = 192.168.1.1:88
        default_domain = MY.DOMAIN.LOCAL
        admin_server = 192.168.1.1
}

[domain_realm]
        RASPBERRY = MY.DOMAIN.LOCAL
```

Também é preciso fazer um ajuste no /etc/samba/smb.conf, você precisa colocar a linha abaixo na sessão **\[global]** do arquivo:

`server services = rpc, nbt, wrepl, ldap, cldap, kdc, drepl, winbind, ntp_signd, kcc, dnsupdate, dns, s3fs`

Tudo certo até aqui podemos reativar o serviço do samba no sistema:

**sudo systemctl unmask samba-ad-dc.service**

**sudo systemctl start samba-ad-dc.service**

**sudo systemctl status samba-ad-dc.service**

**sudo systemctl enable samba-ad-dc.service**


## Para verificar se tudo iniciou corretamente:

**sudo netstat -tulpn | egrep 'smbd|samba'**

```
tcp        0      0 0.0.0.0:636             0.0.0.0:*               OUÇA       3092/samba
tcp        0      0 0.0.0.0:445             0.0.0.0:*               OUÇA       3104/smbd
tcp        0      0 0.0.0.0:1024            0.0.0.0:*               OUÇA       3089/samba
tcp        0      0 0.0.0.0:3268            0.0.0.0:*               OUÇA       3092/samba
tcp        0      0 0.0.0.0:3269            0.0.0.0:*               OUÇA       3092/samba
tcp        0      0 0.0.0.0:389             0.0.0.0:*               OUÇA       3092/samba
tcp        0      0 0.0.0.0:135             0.0.0.0:*               OUÇA       3089/samba
tcp        0      0 0.0.0.0:139             0.0.0.0:*               OUÇA       3104/smbd
tcp        0      0 0.0.0.0:464             0.0.0.0:*               OUÇA       3094/samba
tcp        0      0 0.0.0.0:53              0.0.0.0:*               OUÇA       3101/samba
tcp        0      0 0.0.0.0:88              0.0.0.0:*               OUÇA       3094/samba
```

## Checando a resolução dos nomes:

**ping -c3 my.domain.local**


**ping -c3 raspberry.my.domain.local**


**ping -c3 raspberry**


**host -t A my.domain.local**


**host -t A raspberry.my.domain.local**


**host -t SRV _kerberos._udp.my.domain.local**

**host -t SRV _ldap._tcp.my.domain.local**

## Checando o Kerberos:

Obs.: o comando é case sensitive (o que está em maiúsculas deve ser completado em maiúsculas)
**kinit administrator@MY.DOMAIN.LOCAL**

Ele vai solicitar a senha e vai mostrar as informações do ticket solicitado, para verificar mais tickets válidos use o comando **klist**

## Para criar um usuário de teste no samba:

**sudo samba-tool user create some.user**
