void tracerTouche(touche[]tabTouche, int[][]tabInstru) {
  strokeWeight(3);
  line(180, 0, 180, 1080);
  for (int i=0; i<12; i++) {
    fill(tabTouche[i].col=couleurs[i]);

    if (tabTouche[i].num==5||tabTouche[i].num==1) {
      strokeWeight(3);
      stroke(255, 0, 0);
    } else if (tabTouche[i].num!=0) {
      strokeWeight(3);
      stroke(0, 255, 0);
    } else {
      strokeWeight(1);
      stroke(0);
    }
    rect(tabTouche[i].x, tabTouche[i].y, 50, 100, 20);

    if ( i<5) {
      if (tabInstru[i][1]==1) {
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

  image(imgA, 220, 255);
  image(imgB, 220, 365);
  image(imgC, 220, 475); 
  image(imgD, 220, 585);
  image(imgE, 220, 695);
  image(logo, 680, 30);
  fill(155);
  rect(0, 0, 180, 1080);
  strokeWeight(3);
  rect(1740, 0, 180, 1080);

  fill(204, 0, 0);
  rect(15, 200, 100, 100);
  if (!Bloquer_Configuration) {
    image(config, 35, 215);
  }
  fill(255);
  rect(15, 400, 100, 100);
  if (b.active) {
    textSize(60);
    fill(0);
    text("A", 40, 470);
  } else {
    textSize(60);
    fill(0);
    text("J", 55, 470);
  }
}