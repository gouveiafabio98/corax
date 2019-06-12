void addImage(File selection) { //recebe um ficheiro
  if (selection != null) { //se a imagem existe
    if (!selection.exists()) {
      //aparece uma janela (JOptionPane) do java com uma mensagem caso nao exista o ficheiro
      JOptionPane.showMessageDialog(null, "A imagem \""+selection.getName()+"\" não existe.", "Ficheiro não encontrado:", JOptionPane.INFORMATION_MESSAGE, UIicon); 
      
    } else {
      String name = selection.getName(); //recebe o nome do ficheiro
      int i;
      for (i=0; i<itype.length && !name.endsWith(itype[i]); i++); //Verificar se o formato existe na array de tipos (se é imagem)
      
      if (i<itype.length) { //Se for uma imagem
        musicas.get(rcM).setCapa(selection.getAbsolutePath());//define nova capa
        saveF(); //atualiza ficheiro
      } else {
        //aparece uma janela (JOptionPane) do java com uma mensagem caso o tipo não seja suportado
        JOptionPane.showMessageDialog(null, "O ficheiro que tentou inserir não é suportado.", "Formato não suportado:", JOptionPane.INFORMATION_MESSAGE, UIicon);
      }
    }
  }
}
