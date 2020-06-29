---
title: Ubuntu - COMO Iniciar em modo de emergência
date: '2020-06-28T21:18:42-03:00'
categories:
  - Dicas
tags:
  - portugues
  - Ubuntu
  - Rescue
autoThumbnailImage: false
thumbnailImagePosition: top
coverImage: /images/uploads/cover-post.jpg
---
![Ubuntu-logotipo](/images/uploads/kisspng-ubuntu-linux-logo-installation-computer-software-logo-material-5ad80a1797d3f9.8943267215241077996219.png)

Existem algumas situações quando você esquece a senha do seu usuário ou mesmo precisa efetuar uma manutenção de disco você pode recorrer ao modo de inicialização de recuperação do ubuntu para efetuar esses procedimentos.



_Modo de recuperação (Single User Mode) _

 

1) Reinicie o sistema e espere a tela de bootloader do grub e pressione "**ESC**", escolha Ubuntu e pressione "**E**".

2) Na linha que começa com linux, adicione no final da linha : **systemd.unit=rescue.target** 

3) Depois pressione "**CTRL + X**" ou "**F10**" para o sistema reiniciar em Single Mode

4) Quando aparecer "**Press Enter for maintenence**" você pressiona Enter e ele vai liberar o terminal para você fazer o que precisa. 

5) Depois de fazer a manutenção que precisa pode no terminal digitar "**systemctl reboot**" e o equipamento vai reiniciar o sistema. 



_Modo de emergnecia (Emergency Mode)_



1) Reinicie o sistema e espere a tela de bootloader do grub e pressione "**ESC**", escolha Ubuntu e pressione "**E**".

2) Na linha que começa com linux, adicione no final da linha : **systemd.unit=emergency.target **

3) Depois pressione "**CTRL + X**" ou "**F10**" para o sistema reiniciar em Emergence Mode

4) Quando aparecer "**Press Enter for maintenence**" você pressiona Enter e ele vai liberar o terminal para você fazer o que precisa. 

5) Depois de fazer a manutenção que precisa pode no terminal digitar "**systemctl reboot**" e o equipamento vai reiniciar o sistema. 



> Obs.: Em modo de emergência os discos serão montados em modo somente leitura, para efetuar gravação você pode usar mount -o remount,rw /
