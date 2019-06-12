class Botao { //classe para shapes
  float x, y, larg, comp=0, hitbox; //hitbox=raio da hitbox
  color cor;
  PShape imagem;

  Botao (float x1, float y1, float l, color c, PShape img, float _hitbox) {//construtor de botão
    x=x1;
    y=y1;
    larg=l;
    cor=c;
    hitbox=_hitbox;
    imagem=img;
    imagem.disableStyle();
  }

  Botao (float x1, float y1, float l, float c_, color c, PShape img, float _hitbox) {//construtor de botão retangular
    x=x1;
    y=y1;
    larg=l;
    comp=c_;
    cor=c;
    hitbox=_hitbox;
    imagem=img;
    imagem.disableStyle();
  }

  void desenha() {
    fill(cor);
    if (comp==0) //se é retangular ou não
      shape(imagem, x, y, larg, larg);
    else
      shape(imagem, x, y, larg, comp);
  }

  void desenhaCor(color x) {
    if (comp==0) //se é retangular ou não
      shape(imagem, x, y, larg, larg);
    else
      shape(imagem, x, y, larg, comp);
  }

  void mudaCor(color c) { //altera a cor do botão
    cor=c;
  }

  void desenhaPos(float xpos, float ypos) { //desenha noutra posição
    noStroke();
    fill(cor);
    shape(imagem, xpos, ypos, larg, larg);
  }

  boolean mouseHover(float mx, float my) { //se está em cima ou não do botão
    if (hitbox==0) {
      if (dist(mx, my, x, y)<larg/2) {
        return true;
      }
      return false;
    } else {
      if (dist(mx, my, x, y)<hitbox) {
        return true;
      }
      return false;
    }
  }

  boolean mouseHoverPos(float mx, float my, float x1, float y1) { //se está em cima ou não do botão numa determinada posição
    if (hitbox==0) {
      if (dist(mx, my, x1, y1)<larg/2) {
        return true;
      }
      return false;
    } else {
      if (dist(mx, my, x1, y1)<hitbox) {
        return true;
      }
      return false;
    }
  }
}
