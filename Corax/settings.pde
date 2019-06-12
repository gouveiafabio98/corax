//Bibliotecas //<>//
import geomerative.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import javax.swing.JOptionPane;
import javax.swing.ImageIcon;
import javax.swing.UIManager;
import javax.swing.plaf.ColorUIResource;
import drop.*;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import java.util.*;
import java.io.ByteArrayInputStream;

SDrop drop;
ImageIcon UIicon;
Minim minim;
AudioPlayer music, load;
AudioMetaData meta;
BeatDetect beat;

int menu=0; //janela atual
boolean show=false;//aba dos reprodutores (aberto ou fechado)
float barraLatNomeText=0, barraLatArtistaText=0, barraMusicNomeText=0, barraMusicAutorText=0, barraMusicAlbumText=0; //contador de posição
int musicaDisplayHoverNome=-1, musicaDisplayHoverAutor=-1, musicaDisplayHoverAlbum=-1; //se o rato estiver em cima
//Settings
String screenSize;

//Formas
Botao play, pause, musicaanterior, musicaseguinte, add, volume0, volume1, volume2, volume3, logo, s, s2, shuffle, exit, resize, ordenar_titulo, ordenar_titulo2, ordenar_artista, ordenar_artista2, ordenar_album, ordenar_album2, opcoes, moon, r, l, b_n, b_l, b_r, b_pause, b_play;

//Músicas
ArrayList <Musica> musicas = new ArrayList();

//Cores
color cinzento_claro=color(170), cinzento_medio=color(50), cinzento_escuro=color(30), amarelo=color(255, 255, 100);
color music_text=color(200);

//Fontes
PFont font1, font2;

//Texto
ArrayList<Texto> nome_texto=new ArrayList();
ArrayList<Texto> barra_texto=new ArrayList();
ArrayList<Texto> player=new ArrayList();
ArrayList<Texto>rcMenu_text=new ArrayList();
ArrayList<Texto>resMenu_text=new ArrayList();

//Tempo
int tamanho=0;
String tempoA="00:00", tempoT="00:00";
int tM=0, tS=0; //Tempo atual da música, minutos e segundos

//Volume
float xbolavolume, xlinha=0;

//Música
int musicaAtual=-1;
boolean pauseB=false;
boolean moveTimer=false, moveVolume=false;
int oporordem=1;
boolean boolordem=true;
boolean random=false;
boolean displayNomeBarra=false, displayArtistaBarra=false;

//ScrollBar
float tamanhoAtualScroll=20, tamanhoBarraScroll=1, posBarraScroll;
//tamanhoAtualScroll -> Tamanho total ocupado na página
//tamanhoBarraScroll -> Tamanho da barra que mexe
//posBarraScroll -> Posição y onde a barra está
float posMouseYClick=0;
boolean scrollControl=true, scrollMover=false;

//Imagem
PImage iconPre, reproductorPre;

//Menu Right-Click
boolean rcMenu=false, resMenu=false, verificaOp;
float rcX, rcY, resX, resY, rcWidth, rcHeight, resWidth, resHeight;
int rcM;

//Tamanhos
float tamMusicas, tamMusicasBarra, tamMusicasEspaco, barraLag, barraLat;

//Formatos aceites
String itype[] = {".jpg", ".png"};
String mtype[] = {".mp3", ".wmv", ".mp4"};

//Rep3 Balance
float balance=0; //-1 = Esquerda, 0 = Centro, 1 = Direita

void load() {
  shapeMode(CENTER);
  tams();
  drop = new SDrop(this);
  RG.init(this);
  RG.setPolygonizer(RG.UNIFORMLENGTH);

  //Fontes
  font1=createFont("fonts/FrutigerLTStd-BoldCn.otf", conv_width(40));
  font2=createFont("fonts/digital.ttf", conv_width(40));

  //Imagem
  reproductorPre=loadImage("img/corax.jpg");
  reproductorPre.resize(larguraR, alturaR);
  iconPre=loadImage("img/corax.jpg");
  iconPre.resize((int)barraLat, (int)barraLat);
  maskDisc=loadImage("img/maskDisc.png");
  maskDisc.resize((int)conv_width(130), (int)conv_width(130));
  vinil=loadImage("img/vinil.png");
  vinil.resize((int)conv_width(400), (int)conv_width(400));
  speaker=loadImage("img/speaker.png");
  speaker.resize((int)conv_width(80), (int)conv_width(80));
  scrollBalanceRep3=loadImage("img/scrollBalanceRep3.png");
  scrollBalanceRep3.resize((int)conv_width(30), (int)conv_width(160));
  scrollVolumeRep3=loadImage("img/scrollVolumeRep3.png");
  scrollVolumeRep3.resize((int)conv_width(30), (int)conv_width(160));
  scrollRep3Button=loadImage("img/scrollRep3Button.png");
  scrollRep3Button.resize((int)conv_width(35), (int)conv_width(15));
  speakerDigital=loadImage("img/speakerDigital.png");
  speakerDigital.resize((int)conv_width(60), (int)conv_width(100));
  seta=loadImage("img/seta.png");
  seta.resize((int)conv_width(120), (int)conv_width(130));
  agulha=loadImage("img/agulha.png");
  agulha.resize((int)conv_width(150), (int)conv_width(200));
  baseAgulha=loadImage("img/baseAgulha.png");
  baseAgulha.resize((int)conv_width(80), (int)conv_width(80));
  playRep3=loadImage("img/playRep3.png");
  playRep3.resize((int)conv_width(50), (int)conv_width(50));
  rep3Digital=loadImage("img/speakerDigital.png");
  rep3Digital.resize((int)conv_width(100), (int)conv_width(100));
  baseDisco=loadImage("img/baseDisco.png");
  baseDisco.resize((int)conv_width(410), (int)conv_width(410));
  digitalScreen=loadImage("img/digitalScreen.png");
  digitalScreen.resize((int)conv_width(280), (int)conv_width(220));

  //Texto( PFont _font, String _text, float _x, float _y, float _t_letra, color _c) {
  nome_texto.add(new Texto(font1, "Title", conv_width(220), conv_height(80), conv_width(15), color(255))); 
  nome_texto.add(new Texto(font1, "Artist", conv_width(800), conv_height(80), conv_width(15), color(255)));
  nome_texto.add(new Texto(font1, "Album", conv_width(1100), conv_height(80), conv_width(15), color(255))); 
  barra_texto.add(new Texto(font1, "Music", conv_width(20), conv_height(210), conv_width(20), music_text)); //0
  barra_texto.add(new Texto(font1, "Reproductor", conv_width(20), conv_height(210+30), conv_width(20), color(200)));
  barra_texto.add(new Texto(font1, "Old TV", conv_width(20+10), conv_height(210+50), conv_width(13), color(200)));
  barra_texto.add(new Texto(font1, "Moon", conv_width(20+10), conv_height(210+70), conv_width(13), color(200)));
  barra_texto.add(new Texto(font1, "DJ", conv_width(20+10), conv_height(210+90), conv_width(13), color(200)));
  barra_texto.add(new Texto(font1, " ", conv_width(10), conv_height(600), conv_width(15), color(200)));
  barra_texto.add(new Texto(font1, " ", conv_width(10), conv_height(615), conv_width(12), color(200)));

  player.add(new Texto(font1, "--:--", conv_width(500), conv_height(680), conv_width(12), color(200)));
  player.add(new Texto(font1, "--:--", conv_width(755), conv_height(680), conv_width(12), color(200)));

  rcMenu_text.add(new Texto(font1, "Remove Music", 0, 0, conv_width(15), color(255)));
  rcMenu_text.add(new Texto(font1, "Add Image", 0, 0, conv_width(15), color(255)));
  rcMenu_text.add(new Texto(font1, "Remove Image", 0, 0, conv_width(15), color(255)));

  if (rcMenu_text.get(0).getWidth()>rcWidth)
    rcWidth=rcMenu_text.get(0).getWidth()+conv_width(50);
  if (rcMenu_text.get(1).getWidth()>rcWidth)
    rcWidth=rcMenu_text.get(1).getWidth()+conv_width(50);
  if (rcMenu_text.get(2).getWidth()>rcWidth)
    rcWidth=rcMenu_text.get(2).getWidth()+conv_width(50);

  rcHeight=rcMenu_text.get(0).getHeight()*rcMenu_text.size()+conv_height(45);

  resMenu_text.add(new Texto(font1, "1920x1080", 0, 0, conv_width(13), color(255)));
  resMenu_text.add(new Texto(font1, "1280x720", 0, 0, conv_width(13), color(255)));
  resMenu_text.add(new Texto(font1, "640x360", 0, 0, conv_width(13), color(255)));
  resMenu_text.add(new Texto(font1, "Full Screen", 0, 0, conv_width(13), color(255)));

  if (resMenu_text.get(0).getWidth()>resWidth)
    resWidth=resMenu_text.get(0).getWidth()+conv_width(10);
  if (resMenu_text.get(1).getWidth()>resWidth)
    resWidth=resMenu_text.get(1).getWidth()+conv_width(10);
  if (resMenu_text.get(2).getWidth()>resWidth)
    resWidth=resMenu_text.get(2).getWidth()+conv_width(10);
  if (resMenu_text.get(3).getWidth()>resWidth)
    resWidth=resMenu_text.get(3).getWidth()+conv_width(10);

  resHeight=resMenu_text.get(0).getHeight()*resMenu_text.size()+conv_height(55);

  minim = new Minim(this);
  beat = new BeatDetect();

  //Botao (float x1, float y1, float l, color c, PShape img) {
  play=new Botao(width/2+conv_width(2), height-height/16, conv_width(20), cinzento_claro, loadShape("forms/play.svg"), conv_width(20));
  pause = new Botao (width/2, height-height/16, conv_width(18), cinzento_claro, loadShape("forms/pause.svg"), conv_width(20));
  musicaanterior = new Botao (width/2-conv_width(47), height-height/16, conv_width(14), cinzento_claro, loadShape("forms/musicaanterior.svg"), conv_width(15));
  musicaseguinte = new Botao (width/2+conv_width(47), height-height/16, conv_width(14), cinzento_claro, loadShape("forms/musicaseguinte.svg"), conv_width(15));
  volume0=new Botao(conv_width(1150), conv_height(675), conv_width(17), color(255, 0), loadShape("forms/volume0.svg"), 0);
  volume1=new Botao(conv_width(1150), conv_height(675), conv_width(17), color(255, 0), loadShape("forms/volume1.svg"), 0);
  volume2=new Botao(conv_width(1150), conv_height(675), conv_width(17), color(255, 0), loadShape("forms/volume2.svg"), 0);
  volume3=new Botao(conv_width(1150), conv_height(675), conv_width(17), color(255, 0), loadShape("forms/volume3.svg"), 0);
  add=new Botao(conv_width(62.5+15), conv_height(150), conv_width(30), color(255, 0), loadShape("forms/add.svg"), 0);
  logo=new Botao(conv_width(175/2), conv_height(40), barraLat, conv_height(80), color(255), loadShape("forms/logo.svg"), 0);
  s=new Botao(conv_width(140), conv_height(210+25), conv_width(8), conv_height(8), color(200), loadShape("forms/s.svg"), 0);
  s2=new Botao(conv_width(140), conv_height(210+25), conv_width(8), conv_height(8), color(200), loadShape("forms/s2.svg"), 0);
  shuffle=new Botao(conv_width(202), conv_height(75), conv_width(13), conv_height(13), color(200), loadShape("forms/shuffle.svg"), 0);
  exit=new Botao(conv_width(20), conv_height(15), conv_width(10), conv_height(10), color(200), loadShape("forms/exit.svg"), 0);
  resize=new Botao(conv_width(40), conv_height(15), conv_width(13), conv_height(13), color(50), loadShape("forms/resize.svg"), 0);
  ordenar_titulo=new Botao(conv_width(220+35), conv_height(80-5), conv_width(8), conv_height(7), color(cinzento_escuro), loadShape("forms/ordenar.svg"), 0);
  ordenar_titulo2=new Botao(conv_width(220+35), conv_height(80-5), conv_width(8), conv_height(7), color(cinzento_escuro), loadShape("forms/ordenar2.svg"), 0);
  ordenar_artista=new Botao(conv_width(800+43), conv_height(80-5), conv_width(8), conv_height(7), color(cinzento_escuro), loadShape("forms/ordenar.svg"), 0);
  ordenar_artista2=new Botao(conv_width(800+43), conv_height(80-5), conv_width(8), conv_height(7), color(cinzento_escuro), loadShape("forms/ordenar2.svg"), 0);
  ordenar_album=new Botao(conv_width(1100+50), conv_height(80-5), conv_width(8), conv_height(7), color(cinzento_escuro), loadShape("forms/ordenar.svg"), 0);
  ordenar_album2=new Botao(conv_width(1100+50), conv_height(80-5), conv_width(8), conv_height(7), color(cinzento_escuro), loadShape("forms/ordenar2.svg"), 0);
  opcoes=new Botao(0, 0, conv_width(10), conv_height(10), color(200), loadShape("forms/opcoes.svg"), 0);
  moon=new Botao(0, 0, conv_width(200), conv_height(200), color(150), loadShape("forms/moon.svg"), 0);
  b_r=new Botao(conv_width(1225), conv_height(700), conv_width(9), conv_height(9), color(cinzento_escuro), loadShape("forms/ellipse.svg"), 0);
  b_n=new Botao(conv_width(1185+((1230-1185)/2)), conv_height(700), conv_width(9), conv_height(9), color(cinzento_escuro), loadShape("forms/ellipse.svg"), 0);
  b_l=new Botao(conv_width(1190), conv_height(700), conv_width(9), conv_height(9), color(cinzento_escuro), loadShape("forms/ellipse.svg"), 0);
  r=new Botao(conv_width(1245), conv_height(700), conv_width(10), conv_height(10), color(cinzento_claro), loadShape("forms/r.svg"), 0);
  l=new Botao(conv_width(1170), conv_height(700), conv_width(10), conv_height(10), color(cinzento_claro), loadShape("forms/l.svg"), 0);
  b_play=new Botao(conv_width(1130), conv_height(528), conv_width(10), conv_height(10), color(cinzento_claro), loadShape("forms/Botão_play.svg"), 0);
  b_pause=new Botao(conv_width(1143), conv_height(528), conv_width(10), conv_height(10), color(cinzento_claro), loadShape("forms/Botão_pause.svg"), 0);

  loadFMusic();

  UISettings();
}

void tams() { //carrega os tamanhos baseados na janela
  barraLat=conv_width(175);
  barraLag=conv_width(90);
  tamMusicasBarra=conv_width(90);
  tamMusicas=height-height/8-tamMusicasBarra;
  posBarraScroll=tamMusicasBarra;
  tamMusicasEspaco=conv_width(120)-conv_width(90);

  larguraR=int(width-barraLat);
  alturaR=int(conv_height(628));

  //Reprodutor 2
  nRect=(int)conv_width(80);
  for (int i=0; i<nRect; i++) {
    efeito2.add(new Effect2(0, conv_height(100), TWO_PI/nRect*i));
  }

  movementLerp=conv_width(0.2);
  movementLerp2=conv_width(0.03);
}

void UISettings() { //configura o JOptionPane
  UIManager UI=new UIManager();
  UI.put("OptionPane.background", new ColorUIResource(50, 50, 50));
  UI.put("Panel.background", new ColorUIResource(50, 50, 50));
  UI.put("OptionPane.messageForeground", new ColorUIResource(255, 255, 255));
  UI.put("OptionPane.yesButtonText", "Sim");
  UI.put("OptionPane.noButtonText", "Não");  
  UI.put("OptionPane.okButtonText", "Ok");
  UIicon=new ImageIcon(sketchPath()+"/data/crow.gif");
}

float conv_width(float n) { //Conversor de medidas em x para todos os monitores
  return width*n/1280;
}

float conv_height(float n) { //Conversor de medidas em y para todos os monitores
  return height*n/720;
}

String convMili(int tempo) { //converte em segundos
  String tempof;
  int segundos=tempo/1000;
  int minutos=segundos/60;
  segundos=segundos-minutos*60;
  if (segundos>=10)
    tempof=minutos+":"+segundos;
  else
    tempof=minutos+":0"+segundos;
  return tempof;
}

public static BufferedImage getAlbumCover(File file) { // usando as funcionalidades do java e da biblioteca mp3agic é retirada a capa do ficheiro e retornada em formato BufferedImage
  try {
    final Mp3File song = new Mp3File(file.getAbsolutePath());
    if (song.hasId3v2Tag()) {
      return ImageIO.read(new ByteArrayInputStream(song.getId3v2Tag().getAlbumImage()));
    }
  } 
  catch (Exception e) {
    return null;
  }
  return null;
}
