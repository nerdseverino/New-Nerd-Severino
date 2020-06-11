+++
title = "O custo implicito de coordenação"
date = 2020-06-11T20:03:40-03:00
draft = false
description = "Uma reflexão experimental sobre custo implícito de coordenação baseada no roteiro do episódio 004 do PontoCafé Podcast"
categories = ["podcast", "agile", "scrum", "portugues"]
tags = ["podcast", "agile", "scrum", "portugues", "cobol", "lean"]
+++
![](/images/teamwork-615159_640.jpg)

<iframe src="https://anchor.fm/pontocafe/embed/episodes/004---Custo-implcito-de-coordenao-ef64b4" height="102px" width="400px" frameborder="0" scrolling="no"></iframe>

Muitas vezes não conseguimos identificar o quanto a coordenação de pessoas, equipes, aplicações e processos podem impactar a produtividade. Este custo costuma ser implícito, frequentemente invisíveis e quase nunca mensurado; ele impacta diretamente na entrega de valor de equipe e organização. Um bom exemplo relacionado é o gerenciamento de expectativas ao basear o planejamento de um produto ou produto somente em estiamtivas.

Já deve ter lido ou ouvido muitos praticantes de Agilidade dizendo para não estimar. Concordo com esta afirmação no sentido de não ficar gerenciando todo o planejamento somente em estimativas, o cenário considerado ao estimar a longo prazo não considera que estamos num sistema complexo, caótico e aberto. Também não considera que a interação de pessoas, aplicações e processos não ocorrem de foram precisa. Não sendo possível prever todas as possíveis variáveis que podem impactar a execução do que foi planejado. Organizações que planejam e executam somente baseado em estimativas são despreparadas para o inesperado, sendo pouco resilientes.

O custo implícito foi evidenciado, ainda que indiretamente, por Mel Conway no texto chamado “**How Do Committees Invent?**” em 1967 para Harvard Business Review, uma tradução livre poder ser entendido: “*Como os grupos inventam*”. Este texto não é tão reconhecido, contudo ele é referenciado por [Fred Brooks](https://en.wikipedia.org/wiki/Fred_Brooks) no livro “*The Mythical Man-Month*" como **Conway's Law**. Conway discorre no texto como um sistema desenvolvido numa empresa reflete a forma que ela é organizada. Ele exemplifica (tradução livre):

“*Um organização de pesquisa contrata oitos pessoas nas quais irão produzir um compilador COBOL e outro em ALGOL. Depois de alguma estimativas iniciais da dificuldade e do tempo, cinco pessoas são designadas para trabalhar no compilador COBOL e três para o compilado ALGOL. O resultado será que o compilador COBOL terá 5 etapas e o compilado ALGOL terá 3.*”

Um parênteses para falar sobre COBOL e ALGOL. O acrônimo COBOL é COmmon Business Oriented Language, criado em 1959, tem, entre os criadores a [Grace Hooper](https://en.wikipedia.org/wiki/Grace_Hopper). Se não há conhece, vale olha a página da Wikipedia a respeito dela, é uma das pessoas importantes na história da computação. COBOL foi muito popular nos anos 70 e 80 e ainda é utilizada em instituições financeiras. 

Sabe o que é mais incrível notícia relacionada ao COBOL em 2020? O governador do estado de New Jersey, [Phil Murphy](https://twitter.com/GovMurphy), numa [entrevista](https://nymag.com/intelligencer/2020/04/what-is-cobol-what-does-it-have-to-do-with-the-coronavirus.html) coletiva sobre como eles estão lidando com a COVID19, comentou da existência de sistemas com mais de 40 anos e da necessidade de ter programadores COBOL para mantê-los. Um trecho da entrevista ele diz que um dos relatórios pós crise provavelmente irá citar porque não tínhamos programadores COBOL quando realmente precisávamos. Um apelo interessante dele, não acham? Quem sabe num futuro próximo retomo esse assunto, aplicações legadas e organizações.

Agora, sobre ALGOL, o termo é acrônimo para (Algorithmic Language) e surgiu em 1958, ALGO é predecessor de linguagens como Pascal e C, também foi a primeira referência documentada e publicada da aplicação de conceitos como uma função de outra função (nested function).

Feito aparte, retomando o tema do custo implícito de coordenação. 

Há um consenso, no momento (como as coisas mudam tão rapidamente nestes, pode ser que amanhã seja tudo diferente), de que equipe pequenas e coesas são melhor maneira de organizar pessoas para serviços e produtos. Já deve ter lido ou ouvido [a frase atribuída ao Jezz Bezos](https://www.theguardian.com/technology/2018/apr/24/the-two-pizza-rule-and-the-secret-of-amazons-success) - “*Toda equipe interna deve ter pequena o suficiente para ser alimentada por duas pizzas*”.

Uma pesquisa rápida na internet sobre tamanho de equipes “Ágeis”, ou melhor, equipes que aplicam conceitos e princípios relacionados a Agilidade, descrevem como ideal as equipes entre 3 e 10 pessoas. Equipes pequenas, aplicando uma das palavras da moda - "enxutas", resolvem é ter um custo baixo de tempo para coordenar as atividades e manter uma comunicação coesa entre os membros. Equipes pequenas não deveria exigir muitos processos para atualização de status e andamento das atividaes. Se isso está acontecendé porque só está usando a label (etiqueta) de Agilidade. 

Equipes grandes ou estrutura organizacional muito verticalizadas, costumam exigir mais processos, mais reuniões para coordenar as atividades de várias equipes e áreas. As implementações de ITIL em locais mais burocráticos criaram o estigma dos Comitês/Gerência de Mudança (**C**hange-**A**dvisory **B**oard) como rituais frustrantes. Se você não conhece, são processos para identificar as mudanças que podem ir para os sistemas em produção e qual o impacto dessas mudanças. Os processo podem ser manuais ou automatizados até as reuniões de mudança, elas seguramente evitam muitas mudanças que podem gerar incidentes. Contudo, se as mudanças propostas não tiverem a maior parte da execução e testes automatizados, essas mudanças não são escaláveis. Elas ficam restritas a capacidade de execução das tarefas pelas pessoas envolvidas e frequentemente restritas ao um período específico. 

As organizações que aplicam Continuous Delivery (Entrega Contínua) podem retirar a restrição de implementar as mudanças dos sistemas em horários específicos para a maioria das situações, aumentando as quantidade de mudanças para muito além da capacidade das equipes de aplicar mudanças manualmente. O resultado é uma maior entrega de valor das equipes, diminuindo (Lead Time) o tempo entre a idealização de funcionalidades até a implementação no sistemas em produção (Deploy). 

Já faz algum tempo que não acompanho ITIL tão de perto, mas se a minha memória não estiver confundido as coisas, não há nada no ITIL que restrinja a implementação de processos automatizados desde que tenham evidências de sucesso e rastreáveis. As reuniões de mudança podem ser substituídas na totalidade ou parcialmente por revisões e testes das mudanças em ferramentas e/ou serviços como Github e Gitlab. As mudanças são propostas via Pull Requests (Github) ou Merge Request (Gitlab), para as mudanças serem aprovadas podem ter restrições (exemplo): 

- a mudança deve ter teste(s) unitário(s)
- aprovadas por revisão automatizada (SonarQube)
- gerar artefato sem quebrar (uma imagem de container)
- executar o artefato 
- revisão de outra pessoa
- passar no teste de conformidade de segurança (AppSec)
- passar no teste de integração

A mudança sendo aprovado pelos testes e passos estabelecidos como suficiente para serem aprovadas, elas podem ser automaticamente implementadas em produção. As evidencias da mudança ter passado em todos os testes estarão disponíveis na ferramenta ou serviço de Continuous Delivery para verificações futuras caso ocorra algum problema e seja necessário investigar ou mesmo reverter a mudança. Um boa implementação de um pipeline automatizdo deve ser olhado não só para a quantidade de mudanças foram implementas no ambiente de produção, mas também pelo tempo não disperdiçado em reuniões de mudança e outras atividades relacionadas como documentos prepatórios de impacto ou sistema de gestão de mudança com fluxos de aprovação burocráticos. 

No início citei o exemmplo de construção de compiladores de Mel Conway, no mesmo texto de 1967 ele diz - “*... organizações que projetam sistemas (no sentido amplo usado aqui) restringem o desenvolvimento dos projetos como cópias da estrutura de comunicação dessas organizações.*”. Isso também se reflete na cadeia de fluxo de valor, no Lead time e nos processos. Mary e Tom Poppendieck numa [entrevista](https://www.informit.com/articles/article.aspx?p=1380369) de 11 anos atrás também discorrem sobre o custo de coordenação indiretamente, eles afirmam - “*Para sobreviver a constante mudança do mercado, precisamos criar equipes pequenas e bem lideradas, capazes de se adaptarem rapidamente a realidade e continuar entregar os melhores resultados para os clientes.*”.

A entrevista me fez refletir sobre o quanto ficamos focados em implementar novos processos seguindo estritamente um framework ou método como Scrum, Lean, "coloque aqui o framework do momento" e nos esquecemos de que eles são o meio e não o fim. O esforço de implementar sem considerar a adaptação deles para cultura organizacional vigente torna a implementação o fim e não o meio do que realmente é importante, entregar valor para os clientes. Esse esforço exige um grande nível de coordenação que muitas vezes não é mensurado. Como ele está implícito, somente ser tornará visível quando chegar a fatura da implementação somado com a constatação que não houve realmente mudança significativa na comunicação e na entrega de valor. 

Para não tirar do contexto, segue o trecho completo - “*Não acho que o problema do sucesso ou fracasso esteja na prática do Agile que vem sendo usado. Acredito que o verdadeiro problema é se as pessoas estão ou nã́o olhando para uma mudança fundamental na maneira como pensam em agregar valor. Em muitos casos, eles estão simplesmente mudando processos mas mantendo por baixo a mesma filosofia. As empresas mais eficientes são quase sempre as que não adotam rótulos como Scrum, XP [Extreme Programming] ou Lean, no entanto entendem por si mesmo qual é a melhor maneira de melhorar o valor entregue para os clientes ao longo do tempo. Tentar economizar dinheiro ou obter eficiência será limitado. Mudar a maneira como trabalhamos e nossos objetivos finais terá muito mais impacto. Para sobreviver a constante mudança do mercado, precisamos criar equipes pequenas e bem lideradas, capazes de se adaptarem rapidamente a realidade e continuar entregar os melhores resultados para os clientes.*”

Antes mesmo do modelo Spotify ter se tornado público e famoso, Mary e Tom dizem na mesma entrevista - “*A primeira coisas a fazer é entender que não estamos desenvolvendo software. Estamos fazendo algo maior e software é parte da solução. A otimização do software prejudica o retorno geral. Trabalho de desenvolvimento requer equipes verdadeiramente multifuncionais com capacidade e responsabilidade de ponta a ponta.*“ O modelo de Squad é bom não porque é da cultura da Spotify que é uma startup de sucesso. Os pontos chaves do modelo são das equipes serem pequenas, multifuncionais, autônomas e direcionadas para produto. Lembra um pouco (muito) uma empresa do oriente chamada Toyota e conceitos derivados como Lean. O custo de coordenação para equipes menores e autônomas é muito menor comparado com equipes grandes muito verticalizadas. Ainda em 2020 há muitas organizações na qual a estrutura de equipes seguem o modelo "mais tradicional", baseado em especialidades (DBAs, Sysadmins, Backup, Backend, Frontend, QA, Data Scientist, etc). Essas equipes costumam ter papéis mais transversais, isso por si não seria um problema mas elas precisam ter muitas interações com outras equipes para implementar as mudanças, o custo de coordenação tendem a ser mais alto.

Um outro exemplo evidente de um alto custo de coordenação são organizações que costuma ter War Rooms (Salas de guerra), onde todas as pessoas envolvidas num incidente ficam numa sala trabalhando juntos até que o incidente seja resolvido. Geralmente é destacado alguns membros de cada equipe para estarem nesta sala atuando em conjunto, outras pessoas são chamadas pontualmente para participarem se for necessário. Este evento exige um alto grau de organização do fluxo de comunicação das pessoas presentes, isso porque nem todas estão contextualizadas sobre o incidente, sendo necessário explicar o status para cada pessoa que participa se a mesma não estiver presente desde o início do incidente. Essa necessidade de sincronicidade entre todos é muito custosa do ponto de vista de tempo, forçando o Warm Room ter um curto período de existência até o próximo incidente. 

O oposto custuma ocorrer em organizações mais horizontalizadas e com equipes baseadas em produto ou serviço. Um incidente é tratado diretamente pela equipe sem a necessidade de envolver muitas pessoas de fora, exigindo um menor esforço de contextualização já que a maioria das pessoas envolvidas no incidente conhece as funções existentes e onde estão potenciais causas. O tempo de resolução de um incidente tende a ser menor que o exemplo anterior.

Equipes pequenas, autônomas e multifuncionais também pode ter alto custo de coordenação quando elas usam muito do tempo delas em reuniões e rituais que exigem de todos a dedicação de tempo exclusivo. Já vi situações em que a equipe passava da metade do tempo em atividades não planejadas e cerimônias de algum framework de Agilidade. 

E você? Já tentou observar quanto tempo seu e da equipe em que você está é usado em coordenar as atividades suas, da sua equipe e das outras que você se relaciona no dia a dia? 
