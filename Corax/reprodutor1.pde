color colorRep1, cor;

//Linhas verticais e suas posições
IntList xrep1 = new IntList();
IntList x1rep1 = new IntList();

//Linhas horizontsid e suas posições
IntList yrep1 = new IntList();
IntList y1rep1 = new IntList();

//Altura e largura do reprodutor
int alturaR, larguraR;

//SampleRate das músicas
int sampleRate=2048;

int musicaTam, randomRepX, randomRepY; //Tamanho da música, e posição de criação de novas ondas

int linesTimeX, linesTimeY, atualTimeLimitX=0, atualTimeLimitY=0; //Limites e numero de linhas criadas baseadas no tempo

int effect=0; //Efeito atual
float copy, k; //Variaveis auxiliares

PImage rep1Image=null; //Imagem da musica atual

Ellipse_Effect ellipseRep1; //Efeito da ellipse

void reprodutor1() { 
  beat.detect(music.mix); //Atualiza o beat

  if (music.position()>atualTimeLimitX && x1rep1.size()!=0) { //Adiciona linhas verticais enquanto a musica toca
    atualTimeLimitX+=linesTimeX;
    randomRepX=(int)random(x1rep1.size());
    xrep1.append(x1rep1.get(randomRepX)); //Adicona uma linha do x1rep1 ao xrep1
    x1rep1.remove(randomRepX); //Remove-a da array para evitar repetição
  }

  if (music.position()>atualTimeLimitY && y1rep1.size()!=0) { //Adiciona linhas horizontais enquanto a musica toca
    atualTimeLimitY+=linesTimeY;
    randomRepY=(int)random(y1rep1.size());
    yrep1.append(y1rep1.get(randomRepY)); //Adicona uma linha do x1rep1 ao xrep1
    y1rep1.remove(randomRepY); //Remove-a da array para evitar repetição
  }

  if (effect==0 || effect==2) { //Desenha linhas verticais ou horizontais baseado no efeito
    for (int i=0; i<music.mix.size()-1; i++) { //Linhas verticais
      for (int j=0; j<xrep1.size(); j++) { //Verifica todos os pixies da linha
        colorRep1=rep1Image.get(xrep1.get(j)+int(music.mix.get(i)*50), i); //Copia os pixeis da imagem na posição da linha
        set(xrep1.get(j)+int(music.mix.get(i)*50)+int(barraLat), i, colorRep1); //Desenha esses pixeis para criar a ilusão de onda
      }
    }
  }
  if (effect==1 || effect==2) { //Desenha linhas verticais ou horizontais baseado no efeito
    for (int i=0; i<music.mix.size()-1; i++) { //Linhas horizantais
      for (int j=0; j<yrep1.size(); j++) { //Verifica todos os pixies da linha
        colorRep1=rep1Image.get(i, yrep1.get(j)+int(music.mix.get(i)*50)); //Copia os pixeis da imagem na posição da linha
        set(i+int(barraLat), yrep1.get(j)+int(music.mix.get(i)*50), colorRep1); //Desenha esses pixeis para criar a ilusão de onda
      }
    }
  }

  if (music.mix.level()>0.3) //Caso a musica esteja com o uma amplitude de som superior a 0.3 aplica o filtro threshold
    filter(THRESHOLD);

  k=alturaR*music.mix.level(); //Valor usado na ondulação da ellipse

  if (beat.isHat()) { //Se o beat for do tipo hat redefine os valores para uma nova ellipse baseada na amplitude atual da musica e com uma posição aleatoria
    ellipseRep1 = new Ellipse_Effect(random(larguraR)+barraLat, random(alturaR), alturaR/2-k);
  }

  noStroke();
  for (int x=(int)barraLat; x<width; x++) { //Desenha a ellipse
    for (int y=0; y<alturaR; y++) {
      if (ellipseRep1!=null) {
        copy=dist(ellipseRep1.getX(), ellipseRep1.getY(), x, y); //Copia os pixeis da imagem na localização da ellipse
        if (copy>ellipseRep1.getRaio() && copy<ellipseRep1.getRaio()+1) {
          colorRep1=rep1Image.get(x+int(music.mix.get(x)*100)-(int)barraLat, y+int(music.mix.get(x)*100)); //Copia a cor
          fill(colorRep1);
          rect(x+int(music.mix.get(x)*100), y+int(music.mix.get(x)*100), 2, 2);
        }
      }
    }
  }

  if (beat.isKick()) { //Se o tipo de beat for kick muda de efeito
    effect++;
    if (effect==3)
      effect=0;
  }
}

void carregarRep1() { //Carrega as definições do reprodutor 1
  if (menu==1 && music!=null) { //Se estiver no reprodutor 1 e estiver a tocar uma musica
    beat = new BeatDetect(); //Cria a variavel de deteção do  beat
    musicaTam=music.length(); //Atualiza tamanho total da musica
    linesTimeX=musicaTam/larguraR; //Calcula o numero de linhas verticais criadas ao longo do tempo
    linesTimeY=musicaTam/alturaR; //Calcula o numero de linhas horizontais criadas ao longo do tempo
    atualTimeLimitX=0; //Recomeçar o contador de linhas verticais
    atualTimeLimitY=0; //Recomeçar o contador de linhas horizontais
    //Limpar arrays de linhas
    x1rep1.clear();
    y1rep1.clear();
    xrep1.clear();
    yrep1.clear();
    
    //Adicionar todas as linhas posiveias na array x1rep1 e y1rep1
    for (int i=0; i<larguraR; i++) {
      x1rep1.append(i);
    }
    for (int i=0; i<alturaR; i++) {
      y1rep1.append(i);
    }
    
    //Utilizar a capa da musica no reprodutor
    if (musicas.get(musicaAtual).capaRep()!=null)
      rep1Image=musicas.get(musicaAtual).capaRep().copy();
    else
      rep1Image=reproductorPre.copy();
    
    //São criadas linhas até corresponder ao numero indicado
    while (music.position()>atualTimeLimitX) {
      if (music.position()>atualTimeLimitX && x1rep1.size()!=0) {
        atualTimeLimitX+=linesTimeX;
        randomRepX=(int)random(x1rep1.size());
        xrep1.append(x1rep1.get(randomRepX));  //Adicona uma linha do x1rep1 ao xrep1
        x1rep1.remove(randomRepX); //Remove-a da array para evitar repetição
      }
    }
    
    //São criadas linhas até corresponder ao numero indicado
    while (music.position()>atualTimeLimitY) {
      if (music.position()>atualTimeLimitY && y1rep1.size()!=0) {
        atualTimeLimitY+=linesTimeY;
        randomRepY=(int)random(y1rep1.size());
        yrep1.append(y1rep1.get(randomRepY)); //Adicona uma linha do y1rep1 ao yrep1
        y1rep1.remove(randomRepY); //Remove-a da array para evitar repetição
      }
    }

    beat = new BeatDetect(music.bufferSize(), music.sampleRate()); //Verifica os beats da musica atual
  }
}
