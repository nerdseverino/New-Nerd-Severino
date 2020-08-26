---
title: Raspberry - Rodando containers no Raspberry pi
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

\- Raspberry Pi 3 Model B Rev 1.2

\- Raspberry Pi Zero W Rev 1.1

Bom então começando os trabalhos com o Pi "Maior" eu instalei o Raspbian Lite no cartão e logo depois os pacotes recomendados.

Nesse passo deu tudo certo sem erros.

Depois vem a hora de executar o script de instalação do Docker, que é uma mão na roda pra fazer essa instalação.

No final da instalação é necessário adicionar o usuário PI ao grupo docker:

**sudo usermod -aG docker pi **

Se você quer o docker-compose também precisa seguir esses passos adicionais:

**sudo apt-get install -y libffi-dev libssl-dev

**

**

**

Até aqui deu tudo certo. 

Daí pensando pela lógica era apenas repetir o mesmo processo no Raspberry pi zero. Mas aí começou os contra-tempos:

A instalação do Docker em si correu sem problemas, porém o docker-compose não consegui instalar de jeito nenhum.

Mas pro Sysadmin velho de guerra isso é apenas uma oportunidade de fazer uma gabiarra a mais: rodar os containers usando o docker run mesmo! :D 

Quanto aos containers, você precisa procurar imagens que sejam ARM no [Docker Hub](https://hub.docker.com/search?type=image&architecture=arm)



[PS.: achei uma outra maneira de usar o compose usando um container e o docker run](https://www.freecodecamp.org/news/the-easy-way-to-set-up-docker-on-a-raspberry-pi-7d24ced073ef/)