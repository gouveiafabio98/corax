void barra() { //desneha barra lateral
  //barra
  fill(50);
  noStroke();
  rect(0, 0, barraLat, conv_height(628));
  logo.desenha();

  //bola add
  stroke(200);
  if (dist(mouseX, mouseY, conv_width(62.5+15), conv_height(150))<conv_width(30)) {
    stroke(255);
  }
  strokeWeight(20);
  noFill();
  add.desenha();
  strokeWeight(5);
  //caso esteja no menu principal 
  if (menu==0) {
    barra_texto.get(0).desenhaCor(amarelo);
  } else {
    barra_texto.get(0).desenhaCor(color(200));
  }
  barra_texto.get(1).desenha();

  if (show) { //se a barra dos reprodutores estiver aberta
    if (menu==1) {
      barra_texto.get(2).desenhaCor(amarelo);
    } else {
      barra_texto.get(2).desenhaCor(color(200));
    }
    if (menu==2) {
      barra_texto.get(3).desenhaCor(amarelo);
    } else {
      barra_texto.get(3).desenhaCor(color(200));
    }
    if (menu==3) {
      barra_texto.get(4).desenhaCor(amarelo);
    } else {
      barra_texto.get(4).desenhaCor(color(200));
    }
    s2.desenha();
  } else {
    s.desenha();
  }
  strokeWeight(30);
  stroke(200);
  //se estiver em cima em cima do exit
  if (mouseX>conv_width(20-10/2) && mouseX<conv_width(20+10/2) && mouseY>conv_height(15-10/2) && mouseY< conv_height(15+10/2)) {
    stroke(255);
  }
  exit.desenha();
  stroke(200);
  //se estiver em cima em cima do resize
  if (mouseX>conv_width(40-13/2) && mouseX<conv_width(40+13/2) && mouseY>conv_height(15-13/3) && mouseY< conv_height(15+13/3)) {
    stroke(255);
  }
  resize.desenha();
  noFill();
  if (music!=null) {//se estiver a tocar uma musica
    musicas.get(musicaAtual).desenhaCapa(); //desenha a capa da musica atual
    noStroke();
    fill(50, 180);
    rect(conv_width(0), conv_height(580), barraLat, conv_height(50));

    textSize(conv_width(15));
    if (displayNomeBarra) { //texto a mexer
    //atualiza a caixa de texto com o novo texto que será exibido no final do mesmo
      barra_texto.get(5).muda(displayText(musicas.get(musicaAtual).getNome()+"  ", barraLat-conv_width(40), (int)barraLatNomeText));
      barraLatNomeText+=.1; //contador para display do nome
      if (barraLatNomeText>=musicas.get(musicaAtual).getNome().length()) //se chegar ao final o contador recomeça
        barraLatNomeText=0;
    }
    barra_texto.get(5).desenha();

    textSize(conv_width(12));
    if (displayArtistaBarra) { //texto a mexer
    //atualiza a caixa de texto com o novo texto que será exibido no final do mesmo
      barra_texto.get(6).muda(displayText(musicas.get(musicaAtual).getAuthor()+"  ", barraLat-conv_width(40), (int)barraLatArtistaText));
      barraLatArtistaText+=.1; //contador para display do nome
      if (barraLatArtistaText>=musicas.get(musicaAtual).getAuthor().length()) //se chegar ao final o contador recomeça
        barraLatArtistaText=0;
    }
    barra_texto.get(6).desenha();
  }
}
