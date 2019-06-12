void mousePressed() {
  if (resMenu) { //resize
    //se o tamanho do ecran for igual a ... e estiver na posição onde se encontra essa medida 
    //o tamanho e do ecran é igualado à mesma
    //guarda as opçoes no ficheiro  
    //aparece uma janela (JOptionPane) do java com uma mensagem ao clicar para reiniciar o programa para haver alterações
    if (!screenSize.equals("1920x1080") && resMenu_text.get(0).mouseHover(mouseX, mouseY)) {
      screenSize="1920x1080";
      saveFSetting();
      JOptionPane.showMessageDialog(null, "Renicie para as definições terem efeito.", "Definições guardadas com sucesso:", JOptionPane.INFORMATION_MESSAGE, UIicon);
    } else if (!screenSize.equals("1280x720") && resMenu_text.get(1).mouseHover(mouseX, mouseY)) {
      screenSize="1280x720";
      saveFSetting();
      JOptionPane.showMessageDialog(null, "Renicie para as definições terem efeito.", "Definições guardadas com sucesso:", JOptionPane.INFORMATION_MESSAGE, UIicon);
    } else if (!screenSize.equals("640x360") && resMenu_text.get(2).mouseHover(mouseX, mouseY)) {
      screenSize="640x360";
      saveFSetting();
      JOptionPane.showMessageDialog(null, "Renicie para as definições terem efeito.", "Definições guardadas com sucesso:", JOptionPane.INFORMATION_MESSAGE, UIicon);
    } else if (!screenSize.equals("fullScreen") && resMenu_text.get(3).mouseHover(mouseX, mouseY)) {
      screenSize="fullScreen";
      saveFSetting();
      JOptionPane.showMessageDialog(null, "Renicie para as definições terem efeito.", "Definições guardadas com sucesso:", JOptionPane.INFORMATION_MESSAGE, UIicon);
    }
  }
  resMenu=false;

  if (resize.mouseHover(mouseX, mouseY) && mouseButton == LEFT) { //se estiver em cima do resize
    resMenu=true;
    rcMenu=false;
    //redefine a posição
    resX=mouseX;
    resY=mouseY;
    resMenu_text.get(0).muda_pos(resX+conv_width(5), resY+conv_height(20));
    resMenu_text.get(1).muda_pos(resX+conv_width(5), resY+conv_height(45));
    resMenu_text.get(2).muda_pos(resX+conv_width(5), resY+conv_height(70));
    resMenu_text.get(3).muda_pos(resX+conv_width(5), resY+conv_height(95));
  }

  if (rcMenu) { //barra de definições de musica
    if (mouseX>rcMenu_text.get(0).getX()-conv_width(25) && mouseX<rcMenu_text.get(0).getX()-conv_width(25)+rcWidth && mouseY>rcMenu_text.get(0).getY()-rcMenu_text.get(0).getHeight() && mouseY<rcMenu_text.get(0).getY()-rcMenu_text.get(0).getHeight()+rcMenu_text.get(0).getHeight()+conv_height(5)) {
      musicas.remove(rcM); //remove a musica da posição clicada
      if (music!=null)  //se houver musica a tocar
        music.pause();
      if (musicaAtual==rcM) { //se a musica atual for removida, retira-a e redefine os valores
        music=null;
        barra_texto.get(5).muda("");
        barra_texto.get(6).muda("");
        player.get(0).muda("--:--");
        player.get(1).muda("--:--");
        xlinha=0;
        musicaAtual=-1;
      } else if (musicaAtual>rcM) { //se a musica atual for maior que a musica removida recuam uma posição
        musicaAtual--;
      }
      saveF();
    } else if (mouseX>rcMenu_text.get(1).getX()-conv_width(25) && mouseX<rcMenu_text.get(1).getX()-conv_width(25)+rcWidth && mouseY>rcMenu_text.get(1).getY()-rcMenu_text.get(1).getHeight() && mouseY<rcMenu_text.get(1).getY()-rcMenu_text.get(1).getHeight()+rcMenu_text.get(1).getHeight()+conv_height(5)) {
      selectInput("Selecione uma imagem:", "addImage"); //seleção de imagem para a musica
    } else if (musicas.get(rcM).getImgLink()!=null && mouseX>rcMenu_text.get(2).getX()-conv_width(25) && mouseX<rcMenu_text.get(2).getX()-conv_width(25)+rcWidth && mouseY>rcMenu_text.get(2).getY()-rcMenu_text.get(2).getHeight() && mouseY<rcMenu_text.get(2).getY()-rcMenu_text.get(2).getHeight()+rcMenu_text.get(2).getHeight()+conv_height(5)) {
      musicas.get(rcM).remove_capa(); //remove a capa caso tenha sido adicionada pelo utilizador 
      saveF();
    }
    rcMenu=false;
  } else {
    //se  clicar em cima de "reprodutor" abre a aba
    if (barra_texto.get(1).mouseHover(mouseX, mouseY)) {
      show=!show;
      // Botões da barra inferior
    } else if (play.mouseHover(mouseX, mouseY)) { //Play/Pause
      if (music!=null) //se a musica existir
        if (music.isPlaying()) { //e estiver a tocar
          music.pause(); // pausa
          pausa=true;
        } else {
          music.play(); // senão dá play
          pausa=false;
        }
      pauseB=!pauseB;
    } else if (add.mouseHover(mouseX, mouseY)) { //Adicionar música
      selectInput("Selecione uma música:", "addMusic");
    } else if (musicaanterior.mouseHover(mouseX, mouseY)) { //Musica Anterior
      mudaMusica(false, random); //
      if (menu==3)
        carregarRep3();
      carregarRep1();
    } else if (musicaseguinte.mouseHover(mouseX, mouseY)) { //Musica Seguinte
      mudaMusica(true, random); 
      carregarRep3();
      carregarRep1();
    } else if (barra_texto.get(0).mouseHover(mouseX, mouseY)) { //Musicas
      menu=0;
    } else if (show && barra_texto.get(2).mouseHover(mouseX, mouseY)) { //Reprodutor 1
      menu=1;
      carregarRep1();
    } else if (show && barra_texto.get(3).mouseHover(mouseX, mouseY)) {//Reprodutor 2
      menu=2;
      carregarRep2();
    } else if (show && barra_texto.get(4).mouseHover(mouseX, mouseY)) {//Reprodutor 3
      menu=3;
      carregarRep3();
    } else if (exit.mouseHover(mouseX, mouseY)) { //Sair
      exit();
    } else { //Clicar em música
      verificaOp=true; 
      musicaClick();
    }
  }

  if (opcoes.mouseHover(mouseX, mouseY)) {//se clicar em cima das opçoes 
    rcMenu=true; //aparece o menu
  }

  if (mouseX>width-conv_width(10) && mouseY<height-height/8 && tamanhoBarraScroll<height-height/8-conv_width(90)) { //se clicar em cima do scroll
    scrollMover=true;
  }

  if (mouseY>height-height/8-conv_height(10) && mouseY<height-height/8+conv_height(10) && !moveTimer) { //Barra inferior (mover a posição da musica)
    if (music!=null) {  
      moveTimer=true; 
      music.pause();
    }
  }

  if (mouseX>conv_width(1170) && mouseX<conv_width(1170)+conv_width(70) &&mouseY>conv_height(665) && mouseY<conv_height(685) && !moveVolume) { //barra do volume
    moveVolume=true;
  }

  if (shuffle.mouseHover(mouseX, mouseY)) //shuffle
    random=!random;

  //ordenar as musicas
  if (nome_texto.get(0).mouseHoverPlusLim(mouseX, mouseY, conv_width(43))  ) { 
    if (oporordem!=1) {
      oporordem=1;
      boolordem=true;
    } else {
      if (!boolordem) {
        boolordem=true;
      } else {
        boolordem=false;
      }
    }
    ordena();
  } else if (nome_texto.get(1).mouseHoverPlusLim(mouseX, mouseY, conv_width(43)) ) {
    if (oporordem!=2) {
      oporordem=2;
      boolordem=true;
    } else {
      if (!boolordem) {
        boolordem=true;
      } else {
        boolordem=false;
      }
    }
    ordena();
  } else if (nome_texto.get(2).mouseHoverPlusLim(mouseX, mouseY, conv_width(43)) ) {
    if (oporordem!=3) {
      oporordem=3;
      boolordem=true;
    } else {
      if (!boolordem) {
        boolordem=true;
      } else {
        boolordem=false;
      }
    }
    ordena();
  }
  //reprodutor 3
  if (menu==3) { 
    //verificar se clica em cima do disco superior
    if ((musicas.size()>1 || music==null) && mouseX>barraLat+larguraR/2-vinil.width/2 && mouseX<barraLat+larguraR/2+vinil.width/2 && mouseY>posDisc2-vinil.height/2 && mouseY<posDisc2+vinil.height/2) {
      moverDiscRep3=true; 
      posClickDisc2=mouseY;
    }
    if (mouseX>posBalanceX && mouseX<posBalanceX+scrollRep3Button.width && mouseY>posBalanceY && mouseY<posBalanceY+scrollRep3Button.height) { //balance
      moverBalance=true;
    }
    if (mouseX>posVolumeX && mouseX<posVolumeX+scrollRep3Button.width && mouseY>posVolumeY && mouseY<posVolumeY+scrollRep3Button.height) { //volume
      moverVolume=true;
    }
    if (dist(barraLat+larguraR/2, alturaR/3*2, mouseX, mouseY)<vinil.width/2 && music!=null) { //rodar cd para meter musica para a frente
      rodarCD=true;
      music.pause();
      posClickDisc=mouseY;
      posxLinha=xlinha;
    }
    if (music!=null && dist(width-width/3.5, alturaR-alturaR/10, mouseX, mouseY)<15) { //ejetar o disco
      music.pause();
      music=null;
      barra_texto.get(5).muda("");
      barra_texto.get(6).muda("");
      player.get(0).muda("--:--");
      player.get(1).muda("--:--");
      rightBalance=0;
      leftBalance=0;
      xlinha=0;
      removeRep3=true;
    }
  }


  if (b_n.mouseHover(mouseX, mouseY)) { //bola centro
    if (music!=null) {
      music.setBalance(0);
    }
    balance=0;
    posBalanceY=alturaR/2+scrollBalanceRep3.height/2-scrollRep3Button.height/2;
  } else if (b_l.mouseHover(mouseX, mouseY)) { // bola left
    if (music!=null) {
      music.setBalance(-1);
    }
    balance=-1;
    posBalanceY=alturaR/2+scrollBalanceRep3.height/10;
  } else if (b_r.mouseHover(mouseX, mouseY)) { //bola right
    if (music!=null) {
      music.setBalance(1);
    }
    balance=1;
    posBalanceY=alturaR/2+scrollBalanceRep3.height/10*9-scrollRep3Button.height;
  }
  if (dist(mouseX, mouseY, posPlayX+playRep3.width/2, alturaR-alturaR/5)<conv_width(50)) {
    if (music!=null) //se a musica existir
      if (music.isPlaying()) { //e estiver a tocar
        music.pause(); // pausa
        pausa=true;
      } else {
        music.play(); // senão dá play
        pausa=false;
      }
    pauseB=!pauseB;
  }
}

void mouseReleased() {
  if (moveTimer) { //se tiver largado a barra de baixo move a pos da musica 
    music.cue((int)map(mouseX, 0, width, 0, tamanho)); //alter a pos
    music.play();
    carregarRep1();
    moveTimer=false;
  }
  if (moveVolume) {  //se largar o volume 
    moveVolume=false;
    saveFSetting();
  }
  if (moverDiscRep3) { //se largar o disco 
    moverDiscRep3=false; 
    if (posDisc2>barraLat+larguraR/2-vinil.height) { // se largar o disco perto da base, ele vai para a base
      ativarDiscRep3=true;
    }
  }
  if (moverBalance) { //se largar o balance  
    moverBalance=false;
  }
  if (moverVolume) { //se largar o volume
    moverVolume=false;
  }
  if (rodarCD==true) { // se largar o cd
    music.cue((int)constrain(map(xlinha, 0, width, 0, tamanho), 0, tamanho)); //altera poisção da musica
    music.play();
    rodarCD=false;
  }
  scrollControl=true;
  scrollMover=false;
}

void mouseDragged() {
  //Volume -80 (inaudible) to 13 (some vaguely loud level)
  if (moveVolume) { //arrasta o volume
    if (mouseX<conv_width(1170+70)) // limites da bolinha
      xbolavolume=mouseX;
    if (music!=null)
      updateVolume();
    if (menu==3) {
      loadPositionRep3();
    }
  }
  //ScroolBar Músicas
  if (scrollMover) { //se arrastar o scroll lateral das musicas
    if (scrollControl) { 
      posMouseYClick=abs(mouseY-posMouseYClick); //vai para a posição do rato
      scrollControl=false;
    }
    posBarraScroll=mouseY-posMouseYClick; 

    if (posBarraScroll+tamanhoBarraScroll>tamMusicas+tamMusicasBarra) 
      posBarraScroll=tamMusicas+tamMusicasBarra-tamanhoBarraScroll;

    if (posBarraScroll<tamMusicasBarra)
      posBarraScroll=tamMusicasBarra;
  }
  //Mover timer
  if (moveTimer) { 
    xlinha=mouseX; //fica na pos do rato
  }

  if (moverDiscRep3) { // o disco fica na posição do rato
    posDisc2=mouseY-posClickDisc2;
  }

  if (moverBalance && music!=null) { //move o balance
    posBalanceY=constrain(mouseY, alturaR/2+scrollBalanceRep3.height/10, alturaR/2+scrollBalanceRep3.height/10*9-scrollRep3Button.height); //limites
    music.setBalance(map(posBalanceY, alturaR/2+scrollBalanceRep3.height/10, alturaR/2+scrollBalanceRep3.height/10*9-scrollRep3Button.height, -1, 1)); //definir o balance baseado na pos
    //atualiza as bolas
    if (music.getBalance()==-1)
      balance=-1;
    if (music.getBalance()==0)
      balance=0;
    if (music.getBalance()==1)
      balance=1;
  }

  if (moverVolume) { // move o volume
    xbolavolume=map(constrain(mouseY, alturaR/2, alturaR/2+scrollVolumeRep3.height), alturaR/2, alturaR/2+scrollVolumeRep3.height, conv_width(1170)+conv_width(70), conv_width(1170)); //limites
    loadPositionRep3();
    if (music!=null)
      updateVolume();
  }

  if (rodarCD) { //se estiver a rodar o cd a pos da musica atualiza
    xlinha=posxLinha+map(posClickDisc-mouseY, 0, height, 0, width);
  }
}


void mouseWheel(MouseEvent event) { //roda do rato
  if (tamanhoBarraScroll<tamMusicas) {
    posBarraScroll+=event.getCount()*10; //soma o valor recebido na barra
    //se exceder os limites
    if (posBarraScroll+tamanhoBarraScroll>tamMusicas+tamMusicasBarra)
      posBarraScroll=tamMusicas+tamMusicasBarra-tamanhoBarraScroll;
    if (posBarraScroll<tamMusicasBarra)
      posBarraScroll=tamMusicasBarra;
  }
}

void musicaClick() {//clicar numa musica
  if (mouseX>barraLat && mouseX<width-conv_width(10) && mouseY<alturaR) 
    for (int i=0; i<musicas.size(); i++) //verifica a musica clicada
      if (musicas.get(i).mouseHover(mouseX, mouseY+(posBarraScroll-tamMusicasBarra), conv_width(220), conv_width(120+i*20), larguraR-conv_width(10))) { 
        if (mouseButton == RIGHT) { //ao clicar com o botão direito aparece o menu
          resMenu=false;
          rcMenu=true;
          rcX=mouseX;
          rcY=mouseY;
          rcM=i;
          rcMenu_text.get(0).muda_pos(rcX+conv_width(25), rcY+conv_height(25));
          rcMenu_text.get(1).muda_pos(rcX+conv_width(25), rcY+conv_height(50));
          rcMenu_text.get(2).muda_pos(rcX+conv_width(25), rcY+conv_height(75));
        } else if (musicaAtual!=i && menu==0) { //senão atualiza a musica atual
          barraLatNomeText=0;
          musicaAtual=i;
          atualizaTextLat();
          musicas.get(musicaAtual).playMusic();
        }
      }
}

void updateVolume() {  //atualiza o volume
  //Volume -80 (inaudible) to 13 (some vaguely loud level)
  float volume;
  volume=map(xbolavolume, conv_width(1170), conv_width(1170)+conv_width(70), -60, 13); 
  if (volume<-55) {
    volume=-80; 
    xbolavolume=conv_width(1170);
  }
  music.setGain(volume); //dá set ao volume, nivel de ondas que conseguimos ouvir
}
