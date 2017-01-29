// Tableau de note, associées ensuite à une touche 

Note[]mesNotes() {
  Note[]tabNote=new Note[12];
  int c=60;
  for (int i=0; i<tabNote.length; i++) {
    tabNote[i]=new Note(0, c, 127);
    c++;
  }
  tabNote[1]=new Note(0, 55, 127);
  return tabNote;
}

//Tableau des touches et association à une note

touche[]mesTouches(Note[]tabNote) {
  touche[]tabTouche=new touche[12];
  color c1 = color(251, 208, 151);
  color c2 = color(226, 192, 146);
  color c3 = color(202, 176, 142);
  color c4= color(177, 160, 137);
  color c5 = color(152, 144, 132);
  color c6 = color(128, 128, 128);
  color c7 = color(103, 111, 123);
  color c8 = color(78, 95, 118);
  color c9 = color(53, 79, 113);
  color c10 = color(29, 63, 109);
  color c11 = color(4, 47, 124);
  color c12 = color(0, 20, 150);
  couleurs = new color[]{c12, c11, c10, c9, c8, c7, c6, c5, c4, c3, c2, c1};
  tabTouche[0] = new touche(0, c1, tabNote[0], 538, 510, false);
  tabTouche[1] = new touche(0, c2, tabNote[1], 612, 452, false);
  tabTouche[2] = new touche(0, c3, tabNote[2], 686, 384, false);
  tabTouche[3] = new touche(0, c4, tabNote[3], 760, 319, false);
  tabTouche[4] = new touche(0, c5, tabNote[4], 834, 261, false);
  tabTouche[5] = new touche(0, c6, tabNote[5], 908, 221, false);
  tabTouche[6] = new touche(0, c7, tabNote[6], 982, 221, false);
  tabTouche[7] = new touche(0, c8, tabNote[7], 1056, 261, false);
  tabTouche[8] = new touche(0, c9, tabNote[8], 1130, 319, false);
  tabTouche[9] = new touche(0, c10, tabNote[9], 1204, 384, false);
  tabTouche[10] = new touche(0, c11, tabNote[10], 1278, 452, false);
  tabTouche[11] = new touche(0, c12, tabNote[11], 1352, 510, false);

  return tabTouche;
}