void rcMenu() { //menu de opções das musicas
  fill(cinzento_medio);
  stroke(0, 50);
  rect(rcX, rcY, rcWidth, rcHeight, 5);
  fill(cinzento_claro); 
  //altera a cor quando o rato está por cima
  if (mouseX>rcMenu_text.get(0).getX()-conv_width(25) && mouseX<rcMenu_text.get(0).getX()-conv_width(25)+rcWidth && mouseY>rcMenu_text.get(0).getY()-rcMenu_text.get(0).getHeight() && mouseY<rcMenu_text.get(0).getY()-rcMenu_text.get(0).getHeight()+rcMenu_text.get(0).getHeight()+conv_height(5)) {
    rect(rcMenu_text.get(0).getX()-conv_width(25), rcMenu_text.get(0).getY()-rcMenu_text.get(0).getHeight(), rcWidth, rcMenu_text.get(0).getHeight()+conv_height(5));
  }
  if (mouseX>rcMenu_text.get(1).getX()-conv_width(25) && mouseX<rcMenu_text.get(1).getX()-conv_width(25)+rcWidth && mouseY>rcMenu_text.get(1).getY()-rcMenu_text.get(1).getHeight() && mouseY<rcMenu_text.get(1).getY()-rcMenu_text.get(1).getHeight()+rcMenu_text.get(1).getHeight()+conv_height(5)) {
    rect(rcMenu_text.get(1).getX()-conv_width(25), rcMenu_text.get(1).getY()-rcMenu_text.get(1).getHeight(), rcWidth, rcMenu_text.get(1).getHeight()+conv_height(5));
  }
  if (musicas.get(rcM).getImgLink()!=null && mouseX>rcMenu_text.get(2).getX()-conv_width(25) && mouseX<rcMenu_text.get(2).getX()-conv_width(25)+rcWidth && mouseY>rcMenu_text.get(2).getY()-rcMenu_text.get(2).getHeight() && mouseY<rcMenu_text.get(2).getY()-rcMenu_text.get(2).getHeight()+rcMenu_text.get(2).getHeight()+conv_height(5)) {
    rect(rcMenu_text.get(2).getX()-conv_width(25), rcMenu_text.get(2).getY()-rcMenu_text.get(2).getHeight(), rcWidth, rcMenu_text.get(2).getHeight()+conv_height(5));
  }

  rcMenu_text.get(0).desenha();
  rcMenu_text.get(1).desenha();

  //se não tem imagem adicionada pelo utilizador 
  if (musicas.get(rcM).getImgLink()==null) {
    rcMenu_text.get(2).desenhaCor(125);
  } else {
    rcMenu_text.get(2).desenha();
  }
}


void resMenu() {//menu do resize
  fill(cinzento_claro, 250);
  noStroke();
  rect(resX, resY, resWidth, resHeight, 2);
  resMenu_text.add(new Texto(font1, "1920x1080", 0, 0, conv_width(13), color(255)));
  resMenu_text.add(new Texto(font1, "1280x720", 0, 0, conv_width(13), color(255)));
  resMenu_text.add(new Texto(font1, "640x360", 0, 0, conv_width(13), color(255)));
  resMenu_text.add(new Texto(font1, "Full Screen", 0, 0, conv_width(13), color(255)));

  //altera a cor quando o rato está por cima
  //se o tamanho atual for ... essa dimensão fica bloqueada
  if (mouseX>resMenu_text.get(0).getX()-conv_width(25) && mouseX<resMenu_text.get(0).getX()-conv_width(25)+resWidth && mouseY>resMenu_text.get(0).getY()-resMenu_text.get(0).getHeight() && mouseY<resMenu_text.get(0).getY()-resMenu_text.get(0).getHeight()+resMenu_text.get(0).getHeight()+conv_height(5) ) {
    if (screenSize.equals("1920x1080")) { 
      noFill();
      noStroke();
    } else {
      fill(cinzento_medio, 200);
    }
    rect(resMenu_text.get(0).getX()-conv_width(5), resMenu_text.get(0).getY()-resMenu_text.get(0).getHeight(), resWidth, resMenu_text.get(0).getHeight()+conv_height(5));
  }
  if (mouseX>resMenu_text.get(1).getX()-conv_width(25) && mouseX<resMenu_text.get(1).getX()-conv_width(25)+resWidth && mouseY>resMenu_text.get(1).getY()-resMenu_text.get(1).getHeight() && mouseY<resMenu_text.get(1).getY()-resMenu_text.get(1).getHeight()+resMenu_text.get(1).getHeight()+conv_height(5)) {
    if (screenSize.equals("1280x720")) {
      noFill();
      noStroke();
    } else {
      fill(cinzento_medio, 200);
    }
    rect(resMenu_text.get(1).getX()-conv_width(5), resMenu_text.get(1).getY()-resMenu_text.get(1).getHeight(), resWidth, resMenu_text.get(1).getHeight()+conv_height(5));
  }
  if (mouseX>resMenu_text.get(2).getX()-conv_width(25) && mouseX<resMenu_text.get(2).getX()-conv_width(25)+resWidth && mouseY>resMenu_text.get(2).getY()-resMenu_text.get(2).getHeight() && mouseY<resMenu_text.get(2).getY()-resMenu_text.get(2).getHeight()+resMenu_text.get(2).getHeight()+conv_height(5)) {
    if (screenSize.equals("640x360")) {
      noFill();
      noStroke();
    } else {
      fill(cinzento_medio, 200);
    }
    rect(resMenu_text.get(2).getX()-conv_width(5), resMenu_text.get(2).getY()-resMenu_text.get(2).getHeight(), resWidth, resMenu_text.get(2).getHeight()+conv_height(5));
  }

  if (mouseX>resMenu_text.get(3).getX()-conv_width(25) && mouseX<resMenu_text.get(3).getX()-conv_width(25)+resWidth && mouseY>resMenu_text.get(3).getY()-resMenu_text.get(3).getHeight() && mouseY<resMenu_text.get(3).getY()-resMenu_text.get(3).getHeight()+resMenu_text.get(3).getHeight()+conv_height(5) ) {
    if (screenSize.equals("fullScreen")) {
      noFill();
      noStroke();
    } else {
      fill(cinzento_medio, 200);
    }
    rect(resMenu_text.get(3).getX()-conv_width(5), resMenu_text.get(3).getY()-resMenu_text.get(3).getHeight(), resWidth, resMenu_text.get(3).getHeight()+conv_height(5));
  }


  resMenu_text.get(0).desenha();
  resMenu_text.get(1).desenha();
  resMenu_text.get(2).desenha();
  resMenu_text.get(3).desenha();


  if (screenSize.equals("1920x1080")) {
    resMenu_text.get(0).desenhaCor(cinzento_medio);
  }

  if (screenSize.equals("1280x720")) {
    resMenu_text.get(1).desenhaCor(cinzento_medio);
  }
  if (screenSize.equals("640x360")) {
    resMenu_text.get(2).desenhaCor(cinzento_medio);
  }
  if (screenSize.equals("fullScreen")) {
    resMenu_text.get(3).desenhaCor(cinzento_medio);
  }
}
