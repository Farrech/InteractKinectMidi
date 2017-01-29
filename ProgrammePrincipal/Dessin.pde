void tracerTouche(touche[]tabTouche, int[][]tabInstru) {
  strokeWeight(3);
  line(180, 0, 180, 1080);
  for (int i=0; i<tabTouche.length; i++) { //tracé des touches
    fill(tabTouche[i].col=couleurs[i]);
    if (tabTouche[i].num==5||tabTouche[i].num==1) { // touche activée et tenue, coloration contour rouge
      strokeWeight(3);
      stroke(255, 0, 0);
    } else if (tabTouche[i].num!=0) { // touche activée et non tenue, coloration contour vert
      strokeWeight(3);
      stroke(0, 255, 0);
    } else { // sinon coloration classique
      strokeWeight(1);
      stroke(0);
    }
    rect(tabTouche[i].x, tabTouche[i].y, 50, 100, 20); // tracé aux coordonées de la touche

    if ( i<5) { // dessin des options de sélection d'instrument
      if (tabInstru[i][1]==1) { // contour bleu si sélectionné
        strokeWeight(3);
        stroke(0, 0, 255);
      } else {
        strokeWeight(1);
        stroke(0);
      }
      fill(244, 236, 223);
      rect(200, 240+110*i, 100, 100);
    }
    stroke(0);
  }
  //placement des différentes images
  image(imgA, 220, 255);
  image(imgB, 220, 365);
  image(imgC, 220, 475); 
  image(imgD, 220, 585);
  image(imgE, 220, 695);
  image(logo, 680, 30);
  fill(155);
  rect(0, 0, 180, 1080); //tracé des rectangles d'options
  strokeWeight(3);
  rect(1740, 0, 180, 1080);
  fill(204, 0, 0);
  rect(1790, 50, 100, 100);
  if (!Bloquer_Configuration) {
    image(config, 1810, 70);
  }
  fill(255);
  rect(1790, 200, 100, 100);
  if (b.active) {// Affichage de A ou J selon activation de l'option de jeu
    textSize(60);
    fill(0);
    text("A", 1820, 265);
  } else {
    textSize(60);
    fill(0);
    text("J", 1830, 270);
  }
}