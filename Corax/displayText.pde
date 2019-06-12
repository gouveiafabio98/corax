String displayText(String text, float lim, int letra) { //retorna o texto visível
  int tamx=0;
  String rText="";

  for (int i=letra; tamx<lim; i++) {//começa a variavel i na posicão da primeira letra, se o tamanho ocupado pelo texto for menor que o limite adiciona letras novas
    if (i==text.length()) { //se for a ultima letra recomeça
      i=0;
    }
    tamx+=textWidth(text.charAt(i)); //tamanho ocupado pelas letras
    rText+=text.charAt(i); //adiciona as letras
  }

  return rText;
}

void atualizaTextLat() { //barra lateral
  textSize(conv_width(15));
  if (textWidth(musicas.get(musicaAtual).getNome())>barraLat-conv_width(40)) { //se o nome ocupar mais espaço que a barra
    displayNomeBarra=true;
  } else {
    displayNomeBarra=false;
  }
  textSize(conv_width(12));
  if (textWidth(musicas.get(musicaAtual).getAuthor())>barraLat-conv_width(40)) { //se o artista ocupar mais espaço que a barra
    displayArtistaBarra=true;
  } else {
    displayArtistaBarra=false;
  }
  barraLatNomeText=0;
  barraLatArtistaText=0;
}
