---
title: 'Raspberry - Rodando containers no Raspberry pi - Atualizado '
date: '2020-08-19T07:14:03-03:00'
categories:
  - Dicas
tags:
  - raspberry
  - docker
  - containers
  - arm
keywords:
  - raspberry
  - docker
  - containers
  - arm
autoThumbnailImage: false
thumbnailImagePosition: top
coverImage: ''
---
![Docker + Raspberry](/images/uploads/1-sld_ocnoe1dvkrij1whliw.png)

Olá pessoal, estava tentando testar algumas aplicações no Raspberry PI, então eu pensei: Por quê não em contêiner?

Então comecei a pesquisar um pouco sobre Docker na arquitetura ARM e durante os testes aconteceram algumas coisas interessantes que vou relatar aqui.

Para essa primeira rodada de testes foi usada a última versão disponível do [Raspbian ](https://www.raspberrypi.org/downloads/raspberry-pi-os/)que foi gravada nos cartões de memória. 

[Aqui tem um tutorial ensinando a fazer a instalação no Raspberry.](https://dev.to/rohansawant/installing-docker-and-docker-compose-on-the-raspberry-pi-in-5-simple-steps-3mgl)

Bom pra deixar mais claro os testes, usei 2 modelos diferentes de Raspberry:

**\- Raspberry Pi 3 Model B Rev 1.2**

**\- Raspberry Pi Zero W Rev 1.1**

Bom então começando os trabalhos com o Pi "Maior" eu instalei o Raspbian Lite no cartão e logo depois os pacotes recomendados.

Nesse passo deu tudo certo sem erros.

Depois vem a hora de executar o script de instalação do Docker, que é uma mão na roda pra fazer essa instalação.

No final da instalação é necessário adicionar o usuário PI ao grupo docker:

**sudo usermod -aG docker pi**

Se você quer o docker-compose também precisa seguir esses passos adicionais:

**sudo apt-get install -y libffi-dev libssl-dev**
\
**sudo apt-get install -y python3 python3-pip**
\
**sudo apt-get remove python-configparser**
\
**sudo pip3 -v install docker-compose **
\
\
Até aqui deu tudo certo. 

Quanto aos containers, você precisa procurar imagens que sejam ARM no [Docker Hub](https://hub.docker.com/search?type=image&architecture=arm)

Ficam aqui um exemplo:

```
version: '3'
volumes:
  portainer_data:
  nextcloud_data:
#
services:
  nextcloud:
    container_name: nextcloud
    image: armhero/nextcloud
    volumes:
      #- $PWD/nextcloud:/var/www/html  
      - nextcloud_data:/data
    ports:
      - 8091:80
#
  portainer:
    container_name: portainer
    image: portainer/portainer:latest
    command: -H unix:///var/run/docker.sock
    restart: always
    ports:
      - 9000:9000
      - 8000:8000
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data
#        
  rpi-monitor:
    container_name: rpi-monitor
    image: michaelmiklis/rpi-monitor:latest
    volumes:
      - /opt/vc:/opt/vc
      - /boot:/boot
      - /sys:/dockerhost/sys:ro
      - /etc:/dockerhost/etc:ro
      - /proc:/dockerhost/proc:ro
      - /usr/lib:/dockerhost/usr/lib:ro
    devices:
      - "/dev/vchiq:/dev/vchiq" 
      - "/dev/vcsm:/dev/vcsm"  
    restart: unless-stopped
    ports:
      - 8888:8888
#
```



Bom povo, como fui convidado pra falar um pouco sobre essa experiência no Meetup de Docker de Porto Alegre, eu criei um repositório no Github com os docker-compose files:

[https://github.com/nerdseverino/docker-meetup.git](https://github.com/nerdseverino/docker-meetup)
