void addMusic(File selection) { //recebe ficheiro para ser adicionado
  if (selection != null) { //verifica  se o ficheiro existe
    if (!selection.exists()) {
      //aparece uma janela (JOptionPane) do java com uma mensagem caso nao exista o ficheiro
      JOptionPane.showMessageDialog(null, "A música \""+selection.getName()+"\" não existe.", "Ficheiro não encontrado:", JOptionPane.INFORMATION_MESSAGE, UIicon);
    } else {
      String name = selection.getName();
      int i;
      for (i=0; i<mtype.length && !name.endsWith(mtype[i]); i++); //Verificar se o formato existe na array de tipos

      if (i<mtype.length) { //Se o tipo existir
        String type=mtype[i];
        name=name.replace(type, "");
        for (i=0; i<musicas.size() && !musicas.get(i).getNome().equals(name); i++); //Procurar nome igual
        //se o nome existir aparece uma janela (JOptionPane) do java com uma mensagem a perguntar se pretendemos adicionar à mesma
        if (i==musicas.size() || 0==JOptionPane.showConfirmDialog(null, "A música \""+name+"\" já se encontra na sua biblioteca, pertende continuar?", "Música duplicada:", JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE, UIicon)) {
          load = minim.loadFile(selection.getAbsolutePath());
          meta = load.getMetaData(); //recebe a info do ficheiro
          musicas.add(new Musica(name, selection.getAbsolutePath(), type, meta.author(), meta.album(), null)); //adiciona à array a nova musica
          saveF(); //atualiza ficheiro
        }
      } else { 
        //aparece uma janela (JOptionPane) do java com uma mensagem caso nao seja suportado
        JOptionPane.showMessageDialog(null, "O ficheiro que tentou inserir não é suportado.", "Formato não suportado:", JOptionPane.INFORMATION_MESSAGE, UIicon);
      }
    }
  }
  float musicatam=height-height/8-conv_width(90);
  float medida=map(musicatam, 0, tamanhoAtualScroll+tamMusicasEspaco, 0, 1);
  //atualiza o tamanho ocupado pelas musicas
  tamanhoBarraScroll=(height-height/8-conv_height(90))*medida;
  //ordena musicas 
  if (musicas.size()>=2)
    ordena();
  //se estivermos no reprodutor 3 e adicionarmos uma musica é atualizdo
  if (menu==3 && music!=null)
    carregarRep3();
}
