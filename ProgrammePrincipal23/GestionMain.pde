void suiviMain(KJoint[]joints, int joint, ArrayList<touche>listeTouche) {//Send Note Off qui bug quand on enleve alors qu'une autre note jouée
  int vitesse;

  for (int i=0; i<12; i++) {
    if (joints[joint].getX()>tableauTouche[i].x && joints[joint].getX()<tableauTouche[i].x+100 && joints[joint].getY()>tableauTouche[i].y && joints[joint].getY()<tableauTouche[i].y+100)
    {
      println(toucheEnCours.note.pitch);
      toucheEnCours=tableauTouche[i];
      if (joints[joint].getState()== KinectPV2.HandState_Lasso && Bloquer_Configuration) {
        toucheEnCours.x=int(joints[joint].getX())-50;
        toucheEnCours.y=int(joints[joint].getY())-50;
      } else if (!toucheEnCours.jouer)
      {

        if (joint==KinectPV2.JointType_HandRight) {
          toucheEnCours.num=2;
          vitesse=calculVitesse(pPositionXRight, int(joints[joint].getX()), pPositionYRight, int(joints[joint].getY()));
          pPositionXRight=int(joints[joint].getX());
          pPositionYRight=int(joints[joint].getY());
        } else {
          toucheEnCours.num=3;
          vitesse=calculVitesse(pPositionXLeft, int(joints[joint].getX()), pPositionYLeft, int(joints[joint].getY()));
          pPositionXLeft=int(joints[joint].getX());
          pPositionYLeft=int(joints[joint].getY());
        }
        if (joints[joint].getState()== KinectPV2.HandState_Closed&&toucheEnCours.num!=5) {
          toucheEnCours.num=1;
        } else if (joints[joint].getState()== KinectPV2.HandState_Lasso) {
          toucheEnCours.num=8;
        }
        (toucheEnCours.note).velocity=vitesse*3; // // // //
        listeTouche.add(toucheEnCours);
        toucheEnCours.jouer=true;
        if (!b.active) {
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
      } else if (toucheEnCours.num==5) {
        for (int j = listeTouche.size() - 1; j >= 0; j--) {
          touche part = listeTouche.get(j);
          if (part==toucheEnCours) {
            myBus.sendNoteOff(toucheEnCours.note);
            toucheEnCours.num=6;
          }
        }
      }
      i=11;
    } else if (listeTouche.size()!=0 && toucheEnCours.jouer && i==11) {
      for (int j = listeTouche.size() - 1; j >= 0; j--) {
        touche part = listeTouche.get(j);
        if (!b.active) {
          if (part.num!=1 && part.num!=5 && part.num!=0 && part.num !=8 && part.num==toucheEnCours.num) {
            myBus.sendNoteOff(part.note);
            part.jouer=false;
            part.num=0;
            listeTouche.remove(j);
          } else if (part.num==1) {
            part.num=5;
          } else if (part.num==6) {
            part.jouer=false;
            part.num=0;
            listeTouche.remove(j);
          } else if (part.num==8) {
            accordMajeur(part.note, false);
            part.jouer=false;
            part.num=0;
            listeTouche.remove(j);
          }
        } else {
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

int calculVitesse(int x, int X, int y, int Y) {
  float dx = abs(x - X);
  float dy = abs(y - Y);
  return int(dx + dy);
}