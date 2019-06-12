PImage maskDisc, vinilCapa, vinilCapa2, vinil, speaker, scrollBalanceRep3, scrollRep3Button, scrollVolumeRep3, speakerDigital, seta, agulha, baseAgulha, playRep3, rep3Digital, baseDisco, digitalScreen;
int voltasRep3=0;
float rightBalance, leftBalance, posDisc3, posDisc2, posClickDisc2, posClickDisc, posxLinha, movementLerp, movementLerp2, posBalanceY, posBalanceX, posVolumeX, posVolumeY, agulhaRot, scrollBalanceX, scrollVolumeX, posPlayX;
boolean moverDiscRep3=false, ativarDiscRep3=false, moverBalance=false, moverVolume=false, rodarCD=false, removeRep3=false, pausa=false;
RFont f;
RShape grp;
RPoint[] points;

void reprodutor3() { //Reprodutor 3
  textAlign(CENTER);
  textFont(font2, conv_width(30));

  if (music!=null) { //Se tiver a tocar uma musica
    fft.forward( music.mix );

    RG.setPolygonizerLength(map(music.mix.level(), 0, 1, 3, 50)); //Texto é convertido em uma shape
    points = grp.getPoints(); //Recebe os pontos
  }

  if (musicas.size()>1 || music==null) { //Se exitir disco superior
    if (!moverDiscRep3 && !ativarDiscRep3 && posDisc2!=-vinil.height/4) { //Movimento do disco para a sua posição caso este não se encontre nesta
      posDisc2=lerp(posDisc2, -vinil.height/4, movementLerp);
    } else if (!moverDiscRep3 && ativarDiscRep3) { //Movimento do disco para o centro do base
      posDisc2=lerp(posDisc2, alturaR/3*2, movementLerp);
      if (posDisc2>=alturaR/3*2-0.2) { //Atualiza a musica
        ativarDiscRep3=false;
        mudaMusica(true, false);
        atualizaTextLat();
        carregarRep3();
      }
    }
  }

  if (removeRep3) { //Movimento do disco apos ejetado
    posDisc3=lerp(posDisc3, -vinil.width, movementLerp2);
    if (posDisc3<=-vinil.width+movementLerp2) {
      removeRep3=false;
      carregarRep3();
    }
  }

  pushMatrix();
  translate(barraLat+width/8, 3*height/4);
  image(digitalScreen, -digitalScreen.width/2, -conv_width(200));
  if (music!=null) { //Desenho do nome, como forma irregular a partir dos pontos
    //Nome
    if (points != null) {
      noFill();
      stroke(amarelo);
      strokeWeight(1);
      beginShape(TRIANGLE_STRIP);
      for (int i=0; i<points.length; i++) {
        vertex(points[i].x, points[i].y);
      }
      endShape();
    }

    //Barras
    for (int i=0; i<20; i++) { //Desenho de 20 barras baseado no fft
      noFill();
      rect(i*(int)conv_width(6)-10*(int)conv_width(6), -conv_width(80), (int)conv_width(4), -constrain(fft.getBand(i), 0, alturaR/8));
    }
  }
  popMatrix();

  //Desenho da base do disco
  pushMatrix();
  translate(barraLat+larguraR/2, alturaR/3*2);
  image(baseDisco, -baseDisco.width/2, -baseDisco.height/2);
  popMatrix();
  //Desenho dos discos
  if (music!=null) {
    rightBalance=map(music.right.level(), 0, 1, 0, 1)*map(constrain(music.getBalance(), 0, 1), 0, 1, 0.5, 0)*map(music.getGain(), -80, 6.026, 0, 1);
    leftBalance=map(music.left.level(), 0, 1, 0, 0.5)*map(constrain(music.getBalance(), -1, 0), -1, 0, 0, 0.5)*map(music.getGain(), -80, 6.026, 0, 1);
    //Disco
    pushMatrix();
    translate(barraLat+larguraR/2, alturaR/3*2);
    rotate(map(xlinha, 0, width, 0, TWO_PI*voltasRep3));
    image(vinil, -vinil.width/2, -vinil.height/2);
    image(vinilCapa, -vinilCapa.width/2, -vinilCapa.height/2);
    popMatrix();
  }

  if (removeRep3) { //Desenho do Vinil
    pushMatrix();
    translate(posDisc3, alturaR/3*2);
    rotate(map(xlinha, 0, width, 0, TWO_PI*voltasRep3));
    image(vinil, -vinil.width/2, -vinil.height/2);
    image(vinilCapa, -vinilCapa.width/2, -vinilCapa.height/2);
    popMatrix();
  }
  //Desenho da seta
  image(seta, barraLat+larguraR/2-seta.width/2, seta.height/5);

  if (musicas.size()!=0 && (musicas.size()>1 || music==null)) { // && (musicas.size()>1 && !music.isPlaying())
    //Disco 2
    pushMatrix();
    translate(barraLat+larguraR/2, posDisc2);
    image(vinil, -vinil.width/2, -vinil.height/2);
    image(vinilCapa2, -vinilCapa2.width/2, -vinilCapa2.height/2);
    popMatrix();
  }


  //Coluna Direita
  image(speakerDigital, barraLat+larguraR/10-speakerDigital.width/2, alturaR/8);

  pushMatrix();
  translate(barraLat+larguraR/10, alturaR/8);

  fill(amarelo);
  text(int(map(rightBalance, 0, 1, 0, 100)), 0, speakerDigital.width/3*4);

  scale(1+rightBalance); //Scale da coluna baseado no som
  image(speaker, -speaker.width/2, -speaker.height/2);

  popMatrix();

  //Coluna Esquerda
  image(speakerDigital, barraLat+larguraR-larguraR/10-speakerDigital.width/2, alturaR/8);

  pushMatrix();
  translate(barraLat+larguraR-larguraR/10, alturaR/8);

  fill(amarelo);
  text(int(map(leftBalance, 0, 1, 0, 100)), 0, speakerDigital.width/3*4);

  scale(1+leftBalance); //Scale da coluna baseado no som
  image(speaker, -speaker.width/2, -speaker.height/2);

  popMatrix();

  //Barras
  image(scrollBalanceRep3, scrollBalanceX, alturaR/2);
  image(scrollRep3Button, posBalanceX, posBalanceY);

  image(scrollVolumeRep3, scrollVolumeX, alturaR/2);
  image(scrollRep3Button, posVolumeX, posVolumeY);

  //Agulha
  if (music!=null) {
    agulhaRot=lerp(agulhaRot, map(music.mix.level(), 0, 1, -PI/12, PI/8), movementLerp2); //Movimento da agulha baseado na amplitude da musica
  } else {
    agulhaRot=-PI/12;
  }
  pushMatrix();
  translate(barraLat+larguraR-larguraR/3.6, height/3);
  image(baseAgulha, -baseAgulha.width/2, -baseAgulha.height/2);
  rotate(agulhaRot);
  image(agulha, -agulha.width/4*3.2, -agulha.width/4);
  popMatrix();

  //Botao
  image(playRep3, posPlayX+playRep3.width/2, alturaR-alturaR/5);
  if (music!=null)
    if (music.isPlaying()) {
      b_pause.desenha();
      b_play.desenha();

      b_play.mudaCor(amarelo);
      b_pause.mudaCor(cinzento_claro);
    } else {
      b_play.desenha();
      b_pause.desenha();

      b_play.mudaCor(cinzento_claro);
      b_pause.mudaCor(amarelo);
    }

  stroke(50);
  fill(cinzento_claro);
  ellipse(width-width/3.5, alturaR-alturaR/10, 15, 15);

  textAlign(CORNER);
}

void carregarRep3() { //Carregar definições do reprodutor 3
  loadAlbumRep3();
  loadPositionRep3();
  scrollBalanceX=barraLat+larguraR-larguraR/10-scrollBalanceRep3.width/2;
  scrollVolumeX=barraLat+larguraR-larguraR/6-scrollVolumeRep3.width/2;
  posPlayX=scrollVolumeX+scrollVolumeRep3.width+(scrollVolumeX-scrollBalanceX)/2+playRep3.width/4;
  if (music!=null) {
    fft = new FFT(music.bufferSize(), music.sampleRate());
  }
}

void loadAlbumRep3() { //Carregar capa do Album para o vinil usando uma mask
  agulhaRot=-PI/12;
  posDisc2=-vinil.height;
  //Disco 1
  if (music!=null) {
    if (musicas.get(musicaAtual).capaRep()!=null) {
      vinilCapa=musicas.get(musicaAtual).capaRep().copy();
    } else {
      vinilCapa=reproductorPre.copy();
    }
    vinilCapa.resize(maskDisc.width, maskDisc.height);
    vinilCapa.mask(maskDisc);
    voltasRep3=int(music.length()*.00001);

    grp = RG.getText(musicas.get(musicaAtual).getNomeLim(larguraR/15), "fonts/FreeSans.ttf", (int)conv_width(25), CENTER);
  }

  //Disco 2
  if (musicas.size()!=0 && (musicas.size()>1 || music==null)) {
    if (music==null && musicas.size()>0) {
      if (musicas.get(0).capaRep()!=null) {
        vinilCapa2=musicas.get(0).capaRep().copy();
      } else {
        vinilCapa2=reproductorPre.copy();
      }
    } else if (musicaAtual+1<musicas.size()) {
      if (musicas.get(musicaAtual+1).capaRep()!=null) {
        vinilCapa2=musicas.get(musicaAtual+1).capaRep().copy();
      } else {
        vinilCapa2=reproductorPre.copy();
      }
    } else {
      if (musicas.size()>0 && musicas.get(0).capaRep()!=null) {
        vinilCapa2=musicas.get(0).capaRep().copy();
      } else {
        vinilCapa2=reproductorPre.copy();
      }
    }
    vinilCapa2.resize(maskDisc.width, maskDisc.height);
    vinilCapa2.mask(maskDisc);
  }
}

void loadPositionRep3() { //Carregar posições dos botões
  removeRep3=false;
  posDisc3=barraLat+larguraR/2;
  posVolumeX=barraLat+larguraR-larguraR/6-scrollRep3Button.width/2;
  posBalanceX=barraLat+larguraR-larguraR/10-scrollRep3Button.width/2;
  if (music!=null) {
    posBalanceY=map(music.getBalance(), -1, 1, alturaR/2+scrollBalanceRep3.height/10, alturaR/2+scrollBalanceRep3.height/10*9-scrollRep3Button.height);
    posVolumeY=map(xbolavolume, conv_width(1170), conv_width(1170+70), alturaR/2+scrollBalanceRep3.height/10*9-scrollRep3Button.height, alturaR/2+scrollBalanceRep3.height/10);
  } else {
    posBalanceY=map(balance, -1, 1, alturaR/2+scrollBalanceRep3.height/10, alturaR/2+scrollBalanceRep3.height/10*9-scrollRep3Button.height);
    posVolumeY=map(constrain(xbolavolume, conv_width(1170), conv_width(1170+70)), conv_width(1170), conv_width(1170+70), alturaR/2+scrollBalanceRep3.height/10, alturaR/2+scrollBalanceRep3.height/10*9-scrollRep3Button.height);
  }
}
