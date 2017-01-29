// Détection et suivi des mains : en paramètre l'ensemble des joints du corps, le joint voulu (main gauche ou droite) et la liste de touche en cours

void suiviMain(KJoint[]joints, int joint, ArrayList<touche>listeTouche) { 
  int vitesse;
  for (int i=0; i<listeTouche.size(); i++) {// Pour chaque touche, on regarde si la main en cours la survole
    if (joints[joint].getX()>tableauTouche[i].x && joints[joint].getX()<tableauTouche[i].x+100 && joints[joint].getY()>tableauTouche[i].y && joints[joint].getY()<tableauTouche[i].y+100)
    {//Si oui
      toucheEnCours=tableauTouche[i]; // toucheEnCours = touche activée
      if (joints[joint].getState()== KinectPV2.HandState_Lasso && Bloquer_Configuration) { // Si on est en mode déplacement, et que la main est en mode lasso : déplacement de la touche en cours
        toucheEnCours.x=int(joints[joint].getX())-50;
        toucheEnCours.y=int(joints[joint].getY())-50;
      } else if (!toucheEnCours.jouer)//Sinon, si la touche n'as pas encore été jouée
      {

        if (joint==KinectPV2.JointType_HandRight) {
          toucheEnCours.num=2; // (2) pour différencier la main droite de la main gauche (3)
          vitesse=calculVitesse(pPositionXRight, int(joints[joint].getX()), pPositionYRight, int(joints[joint].getY())); // Calcul de la vitesse
          pPositionXRight=int(joints[joint].getX()); 
          pPositionYRight=int(joints[joint].getY());
        } else {
          toucheEnCours.num=3;
          vitesse=calculVitesse(pPositionXLeft, int(joints[joint].getX()), pPositionYLeft, int(joints[joint].getY()));
          pPositionXLeft=int(joints[joint].getX());
          pPositionYLeft=int(joints[joint].getY());
        }
        if (joints[joint].getState()== KinectPV2.HandState_Closed&&toucheEnCours.num!=5) {
          toucheEnCours.num=1; // touche tenue
        }
        (toucheEnCours.note).velocity=vitesse; // Non optimal, pour désactiver, remplacer vitesse par 127 (velocity maximal)
        listeTouche.add(toucheEnCours);// on stock les touches activées
        toucheEnCours.jouer=true; // la touche est jouée 
        if (!b.active) { // choix entre jeu libre ou accord
          myBus.sendNoteOn (toucheEnCours.note);
        } else {
          switch(toucheEnCours.num) {
          case 1:
            accordMineur(toucheEnCours.note, true);
            break;
          case 2:
            accordMajeur(toucheEnCours.note, true);
            break;
          case 3:
            accordMajeur(toucheEnCours.note, true);
            break;
          case 8:
            accord7(toucheEnCours.note, true);
            break;
          }
        }
      } else if (toucheEnCours.num==5) { // Si la touche est déjà jouée, et qu'elle est tenue, un nouveau survol l'éteint
        for (int j = listeTouche.size() - 1; j >= 0; j--) {
          touche part = listeTouche.get(j); // Extinction d'une note jouée : on l'enlève de la liste des touches jouées
          if (part==toucheEnCours) {
            myBus.sendNoteOff(toucheEnCours.note);
            toucheEnCours.num=6;
          }
        }
      }
      i=11;
    } else if (listeTouche.size()!=0 && toucheEnCours.jouer && i==11) { // Sinon, si aucune touche n'est survolée
      for (int j = listeTouche.size() - 1; j >= 0; j--) { 
        touche part = listeTouche.get(j);
        if (!b.active) {
          if (part.num!=1 && part.num!=5 && part.num!=0 && part.num !=8 && part.num==toucheEnCours.num) { // Extinction des notes si ce n'est pas une note tenue et si ce n'est pas un accord
            myBus.sendNoteOff(part.note);
            part.jouer=false;
            part.num=0;
            listeTouche.remove(j);
          } else if (part.num==1) { // Sinon, si elle est tenue, on modifie le numéro pour savoir que le survol est terminé, afin de pouvoir l'éteindre ultérieurement
            part.num=5;
          } else if (part.num==6) {
            part.jouer=false;
            part.num=0;
            listeTouche.remove(j);
          } 
        } else { // Sinon, si c'est un accord
          switch(toucheEnCours.num) {
          case 1:
            accordMineur(toucheEnCours.note, false);
            break;
          case 2:
            accordMajeur(toucheEnCours.note, false);
            break;
          case 3:
            accordMajeur(toucheEnCours.note, false);
            break;
          case 8:
            accord7(toucheEnCours.note, false);
            break;
          }
          part.jouer=false;
          part.num=0;
          listeTouche.remove(j);
        }
      }
    }
    // Selection de l'instrument de jeu
    if (joints[joint].getX()>200 && joints[joint].getX()<300) {
      if (joints[joint].getY()>240 &&joints[joint].getY()<350) {
        changerInstrument(mesInstru.listeInstru[0][0]);
        mesInstru.selectionInstru(0);
      } else if (joints[joint].getY()>360 &&joints[joint].getY()<460) {
        changerInstrument(mesInstru.listeInstru[1][0]);
        mesInstru.selectionInstru(1);
      } else if (joints[joint].getY()>470 &&joints[joint].getY()<570) {
        changerInstrument(mesInstru.listeInstru[2][0]);
        mesInstru.selectionInstru(2);
      } else if (joints[joint].getY()>580 &&joints[joint].getY()<680) {
        changerInstrument(mesInstru.listeInstru[3][0]);
        mesInstru.selectionInstru(3);
      } else if (joints[joint].getY()>690 &&joints[joint].getY()<790) {
        changerInstrument(mesInstru.listeInstru[4][0]);
        mesInstru.selectionInstru(4);
      }
    }
  }
}

// fonction de calcul de vitesse
int calculVitesse(int x, int X, int y, int Y) {
  float dx = abs(x - X);
  float dy = abs(y - Y);
  return int(dx + dy);
}