//Importation des librairies
import KinectPV2.*;
import themidibus.*;
import controlP5.*;

// Variables graphiques
ControlP5 cp5; 
PFont f;
int backColor = 0;
color[] couleurs; // couleurs des touches
PImage imgA, imgB, imgC, imgD, imgE, logo, config;
PFont font;
bouton b=new bouton(false);
Slider s1, s2, s3;

// Variables options
boolean Bloquer_Configuration = false;
boolean confiMode=false;

// Variables vitesse (stocke la position à la frame précédente des mains droite et gauche)
int pPositionXRight=0;
int pPositionYRight=0;
int pPositionXLeft=0;
int pPositionYLeft=0;

// Variables principales
KinectPV2 kinect;
MidiBus myBus; 
touche[]tableauTouche;
touche toucheEnCours=new touche(0, color(0, 0, 0), new Note(0, 0, 0), 0, 0, false);
ArrayList<touche>touchesJoueesDroite = new ArrayList<touche>();
ArrayList<touche>touchesJoueesGauche = new ArrayList<touche>();
int [][]tabInstru=new int[5][2];
instru mesInstru;

// Initialisation du programme
void setup() {
  smooth();
  size(1920, 1080, P3D);
  kinect = new KinectPV2(this);
  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);
  kinect.init();
  myBus = new MidiBus(this, -1, "PortOutProg");
  tableauTouche=mesTouches(mesNotes());
  cp5 = new ControlP5(this);
  s1 = cp5.addSlider("Modulation", 1, 127, 1, 15, 30, 100, 50);  
  s2 = cp5.addSlider("Reverb", 1, 127, 1, 15, 100, 100, 50);  
  s3 = cp5.addSlider("Volume", 1, 100, 15, 170, 100, 50); 
  imgA = loadImage("Icones/piano.png");
  imgB = loadImage("Icones/violin.png");
  imgC = loadImage("Icones/guitar.png");
  imgD = loadImage("Icones/accordion.png");
  imgE = loadImage("Icones/trumpet.png");
  config = loadImage("Icones/checked.png");
  logo = loadImage("Icones/logo.png");
  config = loadImage("Icones/checked.png");
  f = createFont("Arial", 48, true);
  tabInstru[0][0]=1; // Choix des instruments, voir norme MIDI
  tabInstru[1][0]=77;
  tabInstru[2][0]=25;  
  tabInstru[3][0]=22;
  tabInstru[4][0]=114;
  for (int i=0; i<5; i++) {
    tabInstru[i][1]=0;
  }
  mesInstru=new instru(tabInstru);
}

// Boucle principale à 60 FPS, coeur du programme
void draw() {
  background(244, 236, 223);
  tracerTouche(tableauTouche, tabInstru); // Dessin interface
  //image(kinect.getColorImage(), 0, 0, width, height); // Permet d'afficher l'image vidéo capturer par la Kinect plutôt qu'un background coloré
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
  for (int i = 0; i < skeletonArray.size(); i++) { 
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {// Identification du corps de l'utilisateur
      KJoint[] joints = skeleton.getJoints();
      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      drawBody(joints); // Dessins du squelette
      drawHandState(joints[KinectPV2.JointType_HandRight]);
      drawHandState(joints[KinectPV2.JointType_HandLeft]);
      // Identification des commandes des mains
      suiviMain(joints, KinectPV2.JointType_HandRight, touchesJoueesDroite);
      suiviMain(joints, KinectPV2.JointType_HandLeft, touchesJoueesGauche);
    }
  }
  // Application des effets optionnelles (modulation, reverb et volume)
  myBus.sendControllerChange(0, 1, int(s1.getValue()));
  myBus.sendControllerChange(0, 5, int(s1.getValue()));
  myBus.sendControllerChange(0, 7, int(s1.getValue()));
}


void mouseClicked() { // Gère les options clicables
  if (mouseX>1790 && mouseX<1890 && mouseY>50 && mouseY<150) {
    Bloquer_Configuration=Bloquer_Configuration?false:true;
  } else if (mouseX>1790 && mouseX<1890 && mouseY>200 && mouseY<300) {
    b.survol();
  }
}