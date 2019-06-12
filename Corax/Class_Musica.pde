class Musica { 
  File ficheiro;
  //info da música
  String nome, link, extencao, author, album, imgLink=null;
  //imagens da música
  PImage capa=null, capaRep=null;
  //Desenhar Texto
  float t_letra=conv_width(20);

  Musica(String n, String l, String e, String author1, String album1, String _capa) { //construtor da musica
    nome=n;
    link=l;
    extencao=e;
    author=author1;
    album=album1;
    //verifica se o ficheiro possui ou não capa
    if (_capa!=null)
      setCapa(_capa);
    else //se não exitir capa 
      albumCover();

    tamanhoAtualScroll+=t_letra; //verifica o tamanho que as musicas ocupam para desenhar o scroll 
  }

  void desenhaNome(float x, float y, float lim) { //desenha o nome num espaço limitado
    textFont(font1, t_letra);
    String _x;
    float xo=x;
    int _i;
    _x=nome;
    //desenha letra a letra
    for (_i=0; _i<_x.length() && xo<lim-textWidth("(...) "); _i++)
      xo+=textWidth(_x.charAt(_i));
    if (_i<_x.length())
      _x=_x.substring(0, _i)+"(...)";

    text(_x, x, y);
  }

  void desenhaAutor(float x, float y, float lim) { //desenha o autor num espaço limitado
    textFont(font1, t_letra);

    String _x;
    float xo=x;
    int _i;
    _x=author;
    //desenha letra a letra
    for (_i=0; _i<_x.length() && xo<lim-textWidth("(...) "); _i++)
      xo+=textWidth(_x.charAt(_i));
    if (_i<_x.length())
      _x=_x.substring(0, _i)+"(...)";

    text(_x, x, y);
  }

  void desenhaAlbum(float x, float y, float lim) { //desenha o album num espaço limitado
    textFont(font1, t_letra);

    String _x;
    float xo=x;
    int _i;
    _x=album;
    //desenha letra a letra
    for (_i=0; _i<_x.length() && xo<lim-textWidth("(...) "); _i++)
      xo+=textWidth(_x.charAt(_i));
    if (_i<_x.length())
      _x=_x.substring(0, _i)+"(...)";

    text(_x, x, y);
  }

  String getNome() {
    return nome;
  }

  String getNomeLim(float lim) { //retorna o nome num espaço limitado
    String x="";
    float tamx=0;
    for (int i=0; i<nome.length() && tamx<lim; i++) {
      x+=nome.charAt(i);
      tamx+=textWidth(nome.charAt(i));
    }
    return x;
  }

  String getAuthor() {
    return author;
  }

  String getAuthorLim(float lim) {//retorna o autor num espaço limitado
    String x="";
    float tamx=0;
    for (int i=0; i<author.length() && tamx<lim; i++) {
      x+=author.charAt(i);
      tamx+=textWidth(author.charAt(i));
    }
    return x;
  }

  String getAlbum() {
    return album;
  }

  String getAlbumLim(float lim) {//retorna o album num espaço limitado
    String x="";
    float tamx=0;
    for (int i=0; i<album.length() && tamx<lim; i++) {
      x+=album.charAt(i);
      tamx+=textWidth(album.charAt(i));
    }
    return x;
  }

  boolean mouseHover(float mx, float my, float x, float y, float limx) { //Dá return true caso o rato se encontra em cima do texto
    if (mx>x && mx<x+limx && my>y-t_letra && my<y) {
      return true;
    } else return false;
  }

  void playMusic() { //play music
  //se existir a musica atual mete em pausa
    if (music!=null) music.pause(); 
    music = minim.loadFile(link, sampleRate); //load da musica
    tamanho=music.length(); //atualiza o tempo total a mus.
    player.get(1).muda(convMili(music.length())); //tauliza caixa de texto com o tempo atual depois de convertido
    music.play(); //play da musica atual
    updateVolume(); //atualia o volume

    barra_texto.get(5).muda(musicas.get(musicaAtual).getNome()); //atualiza caixa de texto com o nome da musica atual
    barra_texto.get(6).muda(musicas.get(musicaAtual).getAuthor()); //atualiza caixa de texto com o autor da musica atual
  }

  String getLink() { //retorna a localização do ficheiro
    return link;
  }

  void setCapa(String _capa) {  //escolha da capa
    imgLink=_capa;
    capa=loadImage(_capa);
    capa.resize((int)barraLat, (int)barraLat);
    capaRep=loadImage(_capa);
    capaRep.resize(larguraR, alturaR);
  }

  void albumCover() {
    try { 
      BufferedImage _capa = getAlbumCover(new File(link)); //vai buscar a capa da musica
      capa = new PImage(_capa);
      capa.resize((int)barraLat, (int)barraLat);
      capaRep = new PImage(_capa);
      capaRep.resize(larguraR, alturaR);
    } 
    catch(NullPointerException e) {
    }
  }

  void desenhaCapa() { //desenha capa
    if (capa!=null) { 
      image(capa, 0, height-height/8-barraLat);
    } else { //se não houver capa desenha uma predifinida
      image(iconPre, 0, height-height/8-barraLat);
    }
  }

  PImage capaRep() {
    return capaRep;
  }

  void remove_capa() { //remover a capa
    imgLink=null;
    capa=null;
    capaRep=null;
    albumCover(); //verifica se o ficheiro tem capa 
  }

  String getImgLink() {
    return imgLink;
  }
}
