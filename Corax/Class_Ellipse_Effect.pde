class Ellipse_Effect { //efeito do reprodutor 1
  int x, y;
  float raio;

  Ellipse_Effect(float _x, float _y, float _raio) { //construtor do efeito 1
    x=(int)_x;
    y=(int)_y;
    raio=_raio;
  }

  float getRaio() { 
    return raio;
  }

  int getX() {
    return x;
  }

  int getY() {
    return y;
  }
}
