void dropEvent(DropEvent theDropEvent) {//evento da biblioteca "drop", caso seja largado um ficheiro no programa
  addMusic(theDropEvent.file()); //adiciona ficheiro às musicas
}
