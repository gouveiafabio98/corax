void player() { //barra inferior

  noStroke();
  //Barra
  fill(50);
  rect(0, height-height/8, width, height/8);

  //Botão play/pause
  fill(30);
  fill(cinzento_escuro);
  ellipse(width/2, height-height/16, conv_width(40), conv_width(40));
  if (play.mouseHover(mouseX, mouseY)) {
    fill(20);
    ellipse(width/2, height-height/16, conv_width(40), conv_width(40));
  }
  if (music==null || !music.isPlaying()) { //se a musica não estiver a tocar desenha o play
    play.desenha();
    if (!rodarCD && music!=null && !pauseB && musicaAtual!=musicas.size()-1 && !music.isPlaying() && !moveTimer) { //se a musica chegar ao final muda para a prox muisca 
      mudaMusica(true, random);
      println("hey");
      if (menu==3)
        carregarRep3();
    }
  } else { //se não estiver a tocar desenha o pause 
    pause.desenha();
    //
    xlinha=map(music.position(), 0, tamanho, 0, width); //tempo atual
    player.get(0).muda(convMili(music.position()));//atualiza o texto do tempo atual
  }

  //Botão música seguinte
  fill(cinzento_escuro);
  ellipse(width/2+conv_width(45), height-height/16, conv_width(30), conv_width(30));

  if (musicaseguinte.mouseHover(mouseX, mouseY)) {
    fill(20);
    ellipse(width/2+conv_width(45), height-height/16, conv_width(30), conv_width(30));
  }
  musicaseguinte.desenha();

  //Botão música anterior
  fill(cinzento_escuro);
  ellipse(width/2-conv_width(45), height-height/16, conv_width(30), conv_width(30));

  if (musicaanterior.mouseHover(mouseX, mouseY)) {
    fill(20);
    ellipse(width/2-conv_width(45), height-height/16, conv_width(30), conv_width(30));
  }
  musicaanterior.desenha();

  //Tempo total
  stroke(cinzento_claro);
  strokeWeight(5);
  line(0, height-height/8, width, height-height/8);
  //Tempo atual
  stroke(255);
  line(0, height-height/8, xlinha, height-height/8); 

  if (moveTimer || mouseY>(height-height/8)-conv_height(5) && mouseY<(height-height/8)+conv_height(10)) { //se estiver em cima do timer 
    stroke(amarelo);
    line(0, height-height/8, xlinha, height-height/8); 
    noStroke();
    fill(200);
    ellipse(xlinha, height-height/8, 10, 10);
  }

  //Volume
  strokeWeight(25);
  stroke(200);
  //muda o icon do volume
  if (xbolavolume<=conv_width(1174.7946)) { 
    volume0.desenha();
    xbolavolume=conv_width(1170);
  } else if (xbolavolume<conv_width(1180)+conv_width(23)) {
    volume1.desenha();
  } else if (xbolavolume<conv_width(1170)+conv_width(60)) {
    volume2.desenha();
  } else {
    volume3.desenha();
  }
  strokeWeight(3);
  stroke(200);
  line(conv_width(1170), conv_height(675), conv_width(1170+70), conv_height(675));
  fill(cinzento_claro);
  stroke(255);
  line(conv_width(1170), conv_height(675), xbolavolume, conv_height(675));

  //se estiver em cima do volume
  if (moveVolume || mouseX>conv_width(1165) && mouseX<conv_width(1165)+conv_width(80) && mouseY> conv_height(665)&& mouseY<conv_height(665)+conv_height(15) ) {
    stroke(amarelo);
    line(conv_width(1170), conv_height(675), xbolavolume, conv_height(675));
    noStroke();
    ellipse(xbolavolume, conv_height(675), conv_width(8), conv_height(8));
  }

  player.get(0).desenha();
  player.get(1).desenha();
  noStroke();

  //botoes do balance
  b_n.desenha();

  b_l.desenha();

  b_r.desenha();

  l.desenha();
  r.desenha();
  if (balance==0) { //music.getBalance()
    b_n.mudaCor(color(amarelo));
  } else {
    b_n.mudaCor(color(cinzento_escuro));
  }
  if (balance==-1) {
    b_l.mudaCor(color(amarelo));
  } else {
    b_l.mudaCor(color(cinzento_escuro));
  }
  if (balance==1) {
    b_r.mudaCor(color(amarelo));
  } else {
    b_r.mudaCor(color(cinzento_escuro));
  }
}


void mudaMusica(boolean sentido, boolean rand) { //muda de musica baseado no sentido (andar para tras ou frente) e no random (shuffle)
  if (rand && sentido && musicas.size()>2) { //se tiver mais que 2 musicas e shuffle
    int musAnt=musicaAtual; // guarda a musica atual
    while (musAnt==musicaAtual) { //enquato a musica atual for igual impede a musica seguinte ser igual
      musicaAtual=round(random(musicas.size()-1));
    }
    musicas.get(musicaAtual).playMusic();
  } else {//se não for random
    if (sentido) {  //e se o sentido for para a frente
      //muda para a proxima
      if (musicaAtual==musicas.size()-1) {
        musicaAtual=0;
      } else {
        musicaAtual++;
      }
    } else {
      //muda para a anterior
      if (musicaAtual==0) {
        musicaAtual=musicas.size()-1;
      } else {
        musicaAtual--;
      }
    }
    musicas.get(musicaAtual).playMusic();
  }
}
