float ampMusic; //Amplitude atual da musica
float alt=0; //Altura dos retangulos
int nRect; //Numero de retangulos

ArrayList <Effect1> efeito1 = new ArrayList(); //Array de efeito tipo 1
ArrayList <Effect2> efeito2 = new ArrayList(); //Array de efeito tipo 2

FFT fftlog, fft; //Análise do fft

void reprodutor2() {
  fftlog.forward(music.mix); //Recebe o fft
  beat.detect(music.mix); //Análise do beat atual
  ampMusic=music.mix.level(); //Guarda a amplitude atual

  if (beat.isKick()) //Se acontecer um beat do tipo kick é adicionado um efeito com a cor baseada na ampliyufr
    efeito1.add(new Effect1(larguraR/2+barraLat, alturaR/2, larguraR/2+barraLat, color(255-map(ampMusic, 0, 1, 0, 255), 255-map(ampMusic, 0, 1, 0, 255), 0), (int)conv_width(200)));

  strokeWeight(1);
  stroke(255);
  for (int i=0; i<efeito1.size(); i++) { //Desenha o efeito 1
    efeito1.get(i).run(); //Movimenta o efeito 1
    if (efeito1.get(i).dead()) //Se a particula tiver chegado ao final da sua vida é removida
      efeito1.remove(i);
  }

  strokeWeight(5);
  noStroke();
  for (int i=0; i<efeito2.size(); i++) { //Desenha o efeito 2
    pushMatrix();
    translate(larguraR/2+barraLat, alturaR/2);
    rotate(efeito2.get(i).getRot()); //Rotate dos efeitos a volta do centro

    alt=music.mix.get((int)map(i, 0, nRect, 0, music.bufferSize())); //Altura dos retangulos baseados na amplitude

    efeito2.get(i).desenha(alt, fftlog.getAvg(1)); //Desenha o efeito

    popMatrix();
  }

  fill(0);
  noStroke();
  ellipse(larguraR/2+barraLat, alturaR/2, conv_width(200), conv_height(200));
  pushMatrix();
  translate(larguraR/2+barraLat, alturaR/2);
  scale(1-ampMusic); //Escala da lua baseada na amplitude
  pushMatrix();
  rotate(map(music.position(), 0, tamanho, 0, TWO_PI)); //Lua roda baseada no tempo atual
  moon.desenha();
  popMatrix();
  popMatrix();
}

void carregarRep2() {
  efeito1.clear(); //Remover todos os efeitos
  if (music!=null) {
    for (int i=0; i<efeito2.size(); i++) {
      efeito2.get(i).limpar();
    }
    beat = new BeatDetect();
    fftlog = new FFT(music.bufferSize(), music.sampleRate());
    fftlog.logAverages(22, 3);
    beat = new BeatDetect(music.bufferSize(), music.sampleRate());
  }
}
