---
title: Tar.xz outra opção de compactação para seus backups.
date: '2020-06-22T07:08:58-03:00'
categories:
  - dicas
tags:
  - portugues
keywords:
  - xz
  - cli
  - linux
autoThumbnailImage: true
thumbnailImagePosition: top
coverImage: ''
---
<p align="center">

<img src="/images/uploads/1full_colored_dark.png" width="350" title="Raspberry pi logo">

</p>

O formato mais popular de compactação no Linux é de longe o tar.gz que vem sendo adotado a muitos anos por várias pessoas. Porém existem outros formatos de compactação no linux que são capazes de aproveitar melhor os recursos de multiprocessamento.

Hoje vou falar um pouco sobre o XZ:

Para consultar o manual:

** man xz**

Antes de começar importante salientar que o padrão do xz é remover o arquivo para isso usamos "-k" preserva o arquivo que o "xz" apagaria:

** xz -k (--keep) **

Para descompactá-lo, preservando o ".xz":

** xz -dk (--decompress) (--keep) arquivo.xz**

Para compactar um arquivo usamos a sintaxe abaixo:

**xz -kvT4 -9e arquivo**

Onde:
-v: --verbose ( detalhes na tela )
-Tnumero: --threads=numero exemplo -T4
-9: nível de compactação, aqui ajustamos o nível de compactação (quanto maior mais processamento). O "maior" nível é o "--extreme" ou usando o "-T" que ficaria "-9e" (níveis vão de 1 a 9).

Exemplo 1: **xz -kvT4 -9e arquivo** ->> Aqui a gente comprime o arquivo com o máximo do algoritmo usando 4 threads.

Exemplo 2: **xz -dkvT4 arquivo.xz** ->> Aqui descompactamos o arquivo com as mesmas 4 threads e ainda podemos ver (verbose) o que está sendo feito.

Mas e se eu quiser usar em pastas?

Caso precise compactar pastas um outro utilitário velho conhecido do Linux vem nos salvar. É o comando tar do Linux que cria um "pacote" com a pasta e os arquivos que estão dentro dela.

Para manual:
**man tar**

Para dizer para o TAR que é um "xz":
tar -J ou (--xz)

podemos usar com ele:
-v (--verbose): detalhes na tela
-c (--create): indica que esta criando um arquivo
-f (--file=arquivo): que indica que é um diretório

Exemplo (compacta um diretório):

 tar -Jvcf arquivo.tar.xz arquivo/

Usando o tar.xf na prática:

_TAR.XZ + THREADS + EXTREME_

Ficaria assim:

** tar -Jvcf - teste/ | xz -T4 -9e > teste.tar.xz**

Onde: "-Jvcf" é:
	
**tar --xz --verbose --create --file - teste/| xz --threads=4 --extreme -9 > teste.tar.xz**

"-" → não representa nada, é só para não gerar uma mensagem de erro.

"|" → une os comandos "tar" e "xz" (usar sempre à frente do comando que vai unir, exemplo: cat arquivo.txt | less

">" → direciona a saída para o arquivo "teste.tar.xz", que vai tudo que foi feito.

Se você quer comparar o tamanho dos dados compactados pode usar o comando:

**xz -l teste.tar.xz**

A saída:

> Strms  Blocks   Compressed Uncompressed  Ratio  Check   Filename
>     1       1     10,5 MiB     10,5 MiB  1,000  CRC64   teste.tar.xz

_Obs.:
Esse era um arquivo que tinha em grande maioria texto e não foi usado um índice de compactação alto, por isso o mesmo valor._

Referências:

* <https://www.vivaolinux.com.br/dica/Usando-o-tarxz-varias-threads-e-compactacao-extrema>
* [https://www.linuxforce.com.br/comandos-linux/comandos-linux-comando-xz](https://www.linuxforce.com.br/comandos-linux/comandos-linux-comando-xz/)
* <https://linux.die.net/man/1/xz>
