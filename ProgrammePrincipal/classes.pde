class touche {
  int x, y; // Coordonées
  color col;// Couleur
  Note note; // Note associée
  boolean jouer; // Différencie le jeu ou non de la note
  int num; // Permet de savoir l'état de la note
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

class instru { // Initialisation d'un tableau de 6 instruments
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

class bouton {
  boolean active=false;
  bouton(boolean Active) {
    active=Active;
  }

  void survol() {
    if (this.active) {
      active=false;
    } else {
      active=true;
    }
  }
}