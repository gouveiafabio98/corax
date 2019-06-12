void musica() { //menu principal
  pushMatrix();
  translate(0, (posBarraScroll-tamMusicasBarra)*-1); //Dá translate baseado posição do scroll
  textFont(font1, conv_width(20));
  for (int i=0; i<musicas.size(); i++) { // precorre as musicas para as desenhar
    if (i==musicaAtual && music!=null) fill(amarelo); // se estiver a tocar 
    else fill(cinzento_claro);
    //Display do nome
    if (mouseX>conv_width(220) && mouseX<width && mouseY>tamMusicasBarra+tamMusicasEspaco+conv_width(i*20)-conv_width(20) && mouseY<tamMusicasBarra+tamMusicasEspaco+conv_width(i*20) && textWidth(musicas.get(i).getNome()+"  ")>=conv_width(550)) {
      if (musicaDisplayHoverNome!=i) { // se não estiver em cima o texto não move
        barraMusicNomeText=0; 
        musicaDisplayHoverNome=i;
      }
      // o texto move
      text(displayText(musicas.get(i).getNome()+"  ", conv_width(525), (int)barraMusicNomeText), conv_width(220), tamMusicasBarra+tamMusicasEspaco+conv_width(i*20));
      barraMusicNomeText+=.08;
      if (barraMusicNomeText>=(musicas.get(i).getNome()+"  ").length())
        barraMusicNomeText=0;
    } else {  // se não está em cima
      if (musicaDisplayHoverNome==i) { 
        barraMusicNomeText=0; 
        musicaDisplayHoverNome=-1;
      }
      text(musicas.get(i).getNomeLim(conv_width(550)), conv_width(220), tamMusicasBarra+tamMusicasEspaco+conv_width(i*20));
    }
    //Autor
    if (mouseX>conv_width(220) && mouseX<width && mouseY>tamMusicasBarra+tamMusicasEspaco+conv_width(i*20)-conv_width(20) && mouseY<tamMusicasBarra+tamMusicasEspaco+conv_width(i*20) && textWidth(musicas.get(i).getAuthor()+"  ")>=conv_width(280)) {
      if (musicaDisplayHoverAutor!=i) {// se não estiver em cima o texto não move
        barraMusicAutorText=0;
        musicaDisplayHoverAutor=i;
      }
      // o texto move
      text(displayText(musicas.get(i).getAuthor()+"  ", conv_width(270), (int)barraMusicAutorText), conv_width(800), tamMusicasBarra+tamMusicasEspaco+conv_width(i*20));
      barraMusicAutorText+=.08;
      if (barraMusicAutorText>=(musicas.get(i).getAuthor()+"  ").length())
        barraMusicAutorText=0;
    } else {
      if (musicaDisplayHoverAutor==i) { // se não está em cima
        barraMusicAutorText=0; 
        musicaDisplayHoverAutor=-1;
      }
      text(musicas.get(i).getAuthorLim(conv_width(280)), conv_width(800), tamMusicasBarra+tamMusicasEspaco+conv_width(i*20));
    }
    //Album
    if (mouseX>conv_width(220) && mouseX<width && mouseY>tamMusicasBarra+tamMusicasEspaco+conv_width(i*20)-conv_width(20) && mouseY<tamMusicasBarra+tamMusicasEspaco+conv_width(i*20) && textWidth(musicas.get(i).getAlbum()+"  ")>=conv_width(150)) {
      if (musicaDisplayHoverAlbum!=i) { // se não estiver em cima o texto não move
        barraMusicAlbumText=0; 
        musicaDisplayHoverAlbum=i;
      }
      // o texto move
      text(displayText(musicas.get(i).getAlbum()+"  ", conv_width(145), (int)barraMusicAlbumText), conv_width(1100), tamMusicasBarra+tamMusicasEspaco+conv_width(i*20));
      barraMusicAlbumText+=.08;
      if (barraMusicAlbumText>=(musicas.get(i).getAlbum()+"  ").length())
        barraMusicAlbumText=0;
    } else {
      if (musicaDisplayHoverAlbum==i) { // se não está em cima
        barraMusicAlbumText=0; 
        musicaDisplayHoverAlbum=-1;
      }
      text(musicas.get(i).getAlbumLim(conv_width(150)), conv_width(1100), tamMusicasBarra+tamMusicasEspaco+conv_width(i*20));
    }
    opcoes.desenhaPos(conv_width(200), tamMusicasBarra+tamMusicasEspaco+conv_width(i*20)-conv_width(7)); //desenha as opcoes 

    if (verificaOp) {//desenha o menu rc
      if (opcoes.mouseHoverPos(mouseX, mouseY, conv_width(200), tamMusicasBarra+tamMusicasEspaco+conv_width(i*20)-conv_width(7))) {
        resMenu=false;
        rcMenu=true;
        rcX=mouseX;
        rcY=mouseY;
        rcM=i;
        rcMenu_text.get(0).muda_pos(rcX+conv_width(25), rcY+conv_height(25));
        rcMenu_text.get(1).muda_pos(rcX+conv_width(25), rcY+conv_height(50));
        rcMenu_text.get(2).muda_pos(rcX+conv_width(25), rcY+conv_height(75));
        verificaOp=false;
      }
    }
  }
  if (verificaOp) verificaOp=false;

  popMatrix();
  //desenha a info da musica
  noStroke();
  fill(cinzento_medio);
  rect(width-conv_width(10), tamMusicasBarra, conv_width(10), tamMusicas);
  fill(30);
  noStroke();
  rect(0, 0, width, tamMusicasBarra);
  stroke(200);
  strokeWeight(20);
  nome_texto.get(0).desenha();
  nome_texto.get(1).desenha();
  nome_texto.get(2).desenha();
  strokeWeight(1);
  stroke(255);
  line(0, tamMusicasBarra, width, tamMusicasBarra);
  stroke(70);
  shuffle.desenha();
  //se stiver em shuffle o icon muda de cor
  if (random) {
    shuffle.mudaCor(amarelo);
  } else {
    shuffle.mudaCor(color(200));
  }
  stroke(200);
  strokeWeight(50);
  //desenha as setas parar ordenar
  if (oporordem==1) {
    if (boolordem==true) {
      ordenar_titulo.desenha();
    } else {
      ordenar_titulo2.desenha();
    }
  } else if (oporordem==2) {
    if (boolordem==true) {
      ordenar_artista.desenha();
    } else {
      ordenar_artista2.desenha();
    }
  } else if (oporordem==3) { 
    if (boolordem==true) {
      ordenar_album.desenha();
    } else {
      ordenar_album2.desenha();
    }
  }

  //desenha o local do scroll
  if (tamanhoBarraScroll<tamMusicas) {
    noStroke();
    fill(cinzento_claro);
    rect(width-conv_width(10), posBarraScroll, conv_width(10), tamanhoBarraScroll);
  }
}

void ordena() { //ordena as musicas
//se a função estiver OrdenaNome() este será ordenado alfabeticamente, se estiver OrdenaNome().reversed() é o contrário da alfabética
  String nome="";
  if (music!=null)
    nome = musicas.get(musicaAtual).getNome();
  if (oporordem==1) {
    if (boolordem==true) {
      Collections.sort(musicas, new OrdenaNome());
    } else {
      Collections.sort(musicas, new OrdenaNome().reversed());
    }
  } else if (oporordem==2) { 
    if (boolordem==true) {
      Collections.sort(musicas, new OrdenaAutor());
    } else {
      Collections.sort(musicas, new OrdenaAutor().reversed());
    }
  } else if (oporordem==3) {
    if (boolordem==true) {
      Collections.sort(musicas, new OrdenaAlbum());
    } else {
      Collections.sort(musicas, new OrdenaAlbum().reversed());
    }
  }
  if (music!=null)
  //manter a musica atual ao ordenar
    for (int i=0; i<musicas.size(); i++) {
      if (musicas.get(i).getNome().equals(nome)) {
        musicaAtual=i;
      }
    }
}
