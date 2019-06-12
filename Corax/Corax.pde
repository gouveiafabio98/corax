void settings() {
  loadFSettings(); //carrega definições do ficheiro
  if (screenSize.equals("fullScreen")) { //verifica se é full screen
    fullScreen();
  } else {//converter para o tamanho indicado
    size(Integer.parseInt(screenSize.substring(0, screenSize.lastIndexOf('x'))), Integer.parseInt(screenSize.substring(screenSize.lastIndexOf('x')+1)));
  }
}

void setup() {
  load();//carrega programa
  loadFSettings(); //carrega definições do ficheiro
}

void draw() {
  background(30);
  //mudança de local
  if (menu==0) {
    musica(); //janela principal
  } else {
    if (music!=null && menu==1) {
      reprodutor1();
    } else if (music!=null && menu==2) {
      reprodutor2();
    } else if (menu==3) {
      reprodutor3();
    }
  }
  barra();//barra lateral
  noStroke();
  player();//barra de controlo

  if (rcMenu) {
    rcMenu(); //painel de definições de música
  }
  if (resMenu) {
    resMenu();//painel de redimensionamento da janela
  }
}
