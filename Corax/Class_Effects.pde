class Effect1 { //Class efeito1 (Ondas)
  float x, y, max;
  int size;
  color cor;

  Effect1(float x1, float y1, float max1, color cor1, int size1) { //Construtor do efeito 1
    x=x1;
    y=y1;
    max=max1;
    cor=cor1;
    size=size1;
  }

  void run() { //Efeito 1
    noFill();
    stroke(cor, 255-map(size, 0, max, 0, 255));
    ellipse(x, y, size, size);
    size+=15; //Tamanho das ondas
  }

  boolean dead() { //Devolve se as ondas morreram ou não
    if (size>max)
      return true;
    else 
    return false;
  }
}

class Effect2 {
  float x, y, rot, comp;
  ArrayList <PointPart> particula = new ArrayList(); //Array de particulas para cada retangulo
  ArrayList <Effect3> explosao = new ArrayList(); //Array do efeito explosão

  Effect2(float x1, float y1, float rot1) { //Construtor do efeito 2
    x=x1;
    y=y1;
    rot=rot1;
  }

  float getRot() { //Rotação aplicada a cada efeito
    return rot;
  }

  void desenha(float alt, float amp) { //Desenho dos retangulos
    noStroke();
    fill(255-map(alt, 0, 1, 0, 255), 255-map(alt, 0, 1, 0, 255), random(100)); //Cor dos retangulos baseado na altura recebida
    rect(0, conv_width(100), 5, map(alt, 0, 1, 10, conv_width(100)), 10);
    if (alt>0.6) { //Se a altura chegar a um valor de 0.6 é adicionada uma particula do tipo point
      particula.add(new PointPart());
    }
    for (int i=0; i<particula.size(); i++) { //Desenha todas as particulas
      particula.get(i).desenha();
      if (particula.get(i).dead()) { //Se a particula morrer é removida e criado o efeito explosão
        explosao.add(new Effect3(0, particula.get(i).getAlt(), (int)random(4, 8), particula.get(i).getCor(), amp));
        particula.remove(i);
      }
    }
    for (int i=0; i<explosao.size(); i++) { //Desenha todos os efeitos de explosão
      explosao.get(i).desenha();
      if (explosao.get(i).dead()) //Se o efeito tiver acabado é removido
        explosao.remove(i);
    }
  }

  void limpar() { //Limpa as arrays de efeitos
    particula.clear();
    explosao.clear();
  }
}

class PointPart { //Class de particulas points
  color cor;
  float alt, vida, comp;

  PointPart() { //Construtor da class
    cor=color(random(150, 255), random(150, 255), random(150, 255));
    alt=0;
    vida=255;
    comp=random(width/8, width/2);
  }

  void desenha() { //Desenha as particulas
    noFill();
    strokeWeight(2);
    stroke(cor, vida);
    point(0, alt);

    alt+=5; //Move as particulas

    if (alt>comp) //As particulas começam a morrer quando ultrapssam o seu comp
      vida-=20;
  }

  float getAlt() { //Return da posição da particula
    return alt;
  }

  color getCor() { //Return da cor
    return cor;
  }

  boolean dead() { //Return se a particula está viva
    if (vida<0) {
      return true;
    } else
      return false;
  }
}

class Effect3 { //Class do efeito 3
  int nbolas, vida;
  float x, y, raio;
  color cor;
  boolean exp=false; //Se a particula vai explodir ou não


  Effect3(float x1, float y1, int nbolas1, color cor1, float amp) { //Construtor ds class
    x=x1;
    y=y1;
    nbolas=nbolas1;
    cor=cor1;
    raio=0;
    vida=255;
    if (amp>200) { //Se a amp for superior a 200 a particula explode
      exp=true;
    }
  }

  void desenha() { //Desenha o efeito
    stroke(cor, vida);
    if (exp) { //Se existir explosão desenha bolas a partir do centro que se espalham
      strokeWeight(5);
      for (float ang=0; ang<TWO_PI; ang+=TWO_PI/nbolas) {
        point(x+raio*cos(ang), y+raio*sin(ang));
      }
    } else
      ellipse(x, y, 2, 2);
    raio+=10; //O raio do efeito aumenta
    vida-=10; //A vida do efeito diminui
  }

  boolean dead() { //Devolve se o efeito acabou
    if (vida<0)
      return true;
    else
      return false;
  }
}
