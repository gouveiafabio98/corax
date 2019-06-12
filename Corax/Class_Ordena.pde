//ordenar alfabeticamente
//usando as bibliotecas do java (comparator), verificamos a array de musicas e ordenamo-la afabeticabemente ou por autor, ou nome, ou album
class OrdenaNome implements Comparator <Musica> {  
  public int compare(Musica m0, Musica m1) {
    return (int) m0.getNome().compareTo(m1.getNome());
  }
}

class OrdenaAutor implements Comparator <Musica> {
  public int compare(Musica m0, Musica m1) {
    return (int) m0.getAuthor().compareTo(m1.getAuthor());
  }
}

class OrdenaAlbum implements Comparator <Musica> {
  public int compare(Musica m0, Musica m1) {
    return (int) m0.getAlbum().compareTo(m1.getAlbum());
  }
}
