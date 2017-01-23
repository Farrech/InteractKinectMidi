class touche {
  int x, y;
  color col;
  Note note;
  boolean jouer;
  int num;
  touche(int Num, color Col, Note myNote, int X, int Y, boolean Jouer) {
    num=Num;
    num=Num;
    note=myNote;
    col=Col;
    x=X;
    y=Y;
    jouer=Jouer;
  }
}

class instru {
  int[][]listeInstru= new int[6][2];
  instru() {
  }
  instru(int[][]ListeInstru) {
    listeInstru=ListeInstru;
  }
  void selectionInstru(int index) {
    for (int i=0; i<5; i++) {
      if (i!=index) {
        listeInstru[i][1]=0;
      } else {
        listeInstru[i][1]=1;
      }
    }
  }
}

class bouton{
  boolean active=false;
  bouton(boolean Active){
    active=Active;
  }
  
  void survol(){
    if(this.active){
      active=false;
    }else{
      active=true;
    }
  }
}