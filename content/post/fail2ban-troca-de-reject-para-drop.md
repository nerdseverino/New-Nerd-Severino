---
title: 'Fail2ban: Troca de REJECT para DROP '
date: '2020-02-04T15:49:27-03:00'
categories:
  - Dicas
tags:
  - fail2ban
  - secure
  - dicas
  - block
  - firewall
  - portugues
keywords:
  - fail2ban
  - secure
  - dicas
  - block
  - firewall
autoThumbnailImage: true
thumbnailImagePosition: top
thumbnailImage: ''
coverImage: /images/uploads/fail2ban-logo.jpg
---
# Versão (0.8.x) 

**/etc/action.d/iptables-blocktype.conf**

\#blocktype = REJECT --reject-with icmp-port-unreachable\
**blocktype = DROP**



# Versão (0.9.x) 

**/etc/action.d/iptables-common.conf**

\#blocktype = REJECT --reject-with icmp-port-unreachable\
**blocktype = DROP**

_Depois disso só fazer um service fail2ban reload para não perder o que já está está bloqueado._
