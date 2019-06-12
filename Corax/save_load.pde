void saveF() {//guarda o ficheiro de muiscas
  String [] listaM = new String[musicas.size()*2]; //cria o array com o dobro do tamaho para guardar o link da musica e da capa
  for (int i=0, j=0; i<musicas.size()*2; i+=2, j++) {
    //adiciona a musica
    listaM[i]="Música: "+musicas.get(j).getLink(); 
    listaM[i+1]="Capa: "+musicas.get(j).getImgLink();
  }
  saveStrings("data/musicas.txt", listaM);
}

void saveFSetting() {//guarda o volume e o tamanho do ecrAN
  String [] settings = {str(map(xbolavolume, conv_width(1170), conv_width(1170+70), 0, 100)), screenSize};
  saveStrings("data/settings.txt", settings);
}

void loadFMusic() { //carrega as musicas
  String [] listaM = loadStrings("data/musicas.txt");

  for (int i=0; i<listaM.length; i+=2) {//adiciona ao ficheiro
    if (listaM[i].startsWith("Música: ") && listaM[i+1].startsWith("Capa: ")) {
      loadMusic(new File(listaM[i].substring("Música: ".length())), new File(listaM[i+1].substring("Capa: ".length())));
    }
  }
}

void loadFSettings() { //adiciona ao ficheiro
  String [] settings = loadStrings("data/settings.txt");

  if (settings!=null) {
    xbolavolume=map(Float.parseFloat(settings[0]), 0, 100, conv_width(1170), conv_width(1170+70)); //converte de string para float e atualiza a posição da bola 
    screenSize=settings[1];
  } else
    xbolavolume=conv_width(1170)+conv_width(40);
}

void loadMusic(File musica, File imagem) { //adiciona ao ficheiro
  //carrega a musica
  if (musica != null && musica.exists()) { 
    String imgLink=null;
    String name = musica.getName();
    int i;
    for (i=0; i<mtype.length-1 && !name.endsWith(mtype[i]); i++); //Verificar se o formato existe na array de tipos
    String type=mtype[i];
    name=name.replace(type, "");
    //carrega a capa
    if (imagem!=null && imagem.exists()) {
      String nameImg = imagem.getName();
      int j;
      for (j=0; j<itype.length-1 && !nameImg.endsWith(itype[j]); j++); //Verificar se o formato existe na array de tipos
      String typeImg=itype[j];
      name=name.replace(type, "");
      if (itype[j].equals(typeImg)) { //Se o tipo existir
        imgLink=imagem.getAbsolutePath();
      }
    }
    //adiciona à array
    if (mtype[i].equals(type)) { //Se o tipo existir
      for (i=0; i<musicas.size() && !musicas.get(i).getNome().equals(name); i++); //Procurar nome igual
      if (i==musicas.size()) {
        for (i=0; i<musicas.size() && musicas.get(i).getNome().charAt(0)<name.charAt(0); i++); //Organizar alfabeticamente
        load = minim.loadFile(musica.getAbsolutePath());
        meta = load.getMetaData();
        musicas.add(i, new Musica(name, musica.getAbsolutePath(), type, meta.author(), meta.album(), imgLink));
        saveF();
      }
    }
  }
  float musicatam=height-height/8-conv_width(90);
  float medida=map(musicatam, 0, tamanhoAtualScroll+tamMusicasEspaco, 0, 1);
  tamanhoBarraScroll=(height-height/8-conv_height(90))*medida;
}
