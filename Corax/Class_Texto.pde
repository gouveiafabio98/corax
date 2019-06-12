class Texto { 
  //declaração de variáveis
  PFont font;
  float t_letra, t_text;
  float x, y, xo;
  String text;
  int nl;
  color c;

  Texto(PFont _font, String _text, float _x, float _y, float _t_letra, color _c) { //construtor do texto
    font=_font;
    x=_x;
    y=_y;
    t_letra=_t_letra;
    textFont(font, t_letra);
    text=_text;
    t_text=textWidth(text);
    nl=text.length();//numero de letras
    c=_c;
  }

  void desenha() { //desenha o texto
    xo=x;
    textFont(font, t_letra);
    for (int i=0; i<nl; i++) {//desenha letra a letra 
      fill(c);
      text(text.charAt(i), xo, y);
      xo+=textWidth(text.charAt(i));//é espaçada de acordo com a anterior
    }
  }

  void desenhaCor(color _c) { //desenha com uma cor
    xo=x;
    textFont(font, t_letra);
    for (int i=0; i<nl; i++) {//desenha letra a letra 
      fill(_c);
      text(text.charAt(i), xo, y);
      xo+=textWidth(text.charAt(i));//é espaçada de acordo com a anterior
    }
  }

  void mudacor(color cor) {//recebe uma cor e muda para essa
    c=cor;
  }

  void muda(String f) {//recebe um texto
    text=f;//atualiza o texto
    nl=text.length();//atualiza o tamanho do texto
  }

  boolean mouseHover(float mx, float my) { //Dá return true caso o rato se encontra em cima do texto
    if (mx>x && mx<x+t_text && my>y-t_letra && my<y) {
      return true;
    } else {
      return false;
    }
  }

  boolean mouseHoverPlusLim(float mx, float my, float limx) { //Dá return true caso o rato se encontra em cima do texto
    if (mx>x && mx<x+limx && my>y-t_letra && my<y) {
      return true;
    } else return false;
  }

  void muda_pos(float a, float b) { //muda posição
    x=a;
    y=b;
  }

  float getWidth() { //retorna o espaço ocupado pelo texto
    return t_text;
  }

  float getHeight() { //retorna a altura do texto
    return t_letra;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  String getText() { //retorna o texto
    return text;
  }
}
