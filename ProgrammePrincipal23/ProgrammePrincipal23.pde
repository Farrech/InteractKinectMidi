import KinectPV2.KJoint;
import KinectPV2.*;
import themidibus.*;
import controlP5.*;

// ajout modulation/sustain avec slider (1 - 64)


ControlP5 cp5;
PFont f;
int backColor = 0;
boolean Bloquer_Configuration = false;
color[] couleurs;
PImage imgA, imgB, imgC, imgD, imgE, logo, config;
PFont font;
bouton b=new bouton(false);

boolean confiMode=false;

KinectPV2 kinect;
MidiBus myBus; 
touche[]tableauTouche;
touche toucheEnCours=new touche(0, color(0, 0, 0), new Note(0, 0, 0), 0, 0, false);
int pPositionXRight=0;
int pPositionYRight=0;
int pPositionXLeft=0;
int pPositionYLeft=0;
Slider s1, s2, s3;
ArrayList<touche>touchesJoueesDroite = new ArrayList<touche>();
ArrayList<touche>touchesJoueesGauche = new ArrayList<touche>();

int [][]tabInstru=new int[5][2];
instru mesInstru;




void setup() {
  smooth();
  size(1920, 1080, P3D);
  kinect = new KinectPV2(this);
  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);
  kinect.init();
  myBus = new MidiBus(this, -1, 1);
  tableauTouche=mesTouches(mesNotes());
  cp5 = new ControlP5(this);
  s1 = cp5.addSlider("Modulation", 1, 127, 1, 15, 30, 100, 50);  
  s2 = cp5.addSlider("Reverberation", 1, 127, 1, 15, 100, 100, 50);  


  imgA = loadImage("Icones/piano.png");
  imgB = loadImage("Icones/violin.png");
  imgC = loadImage("Icones/guitar.png");
  imgD = loadImage("Icones/accordion.png");
  imgE = loadImage("Icones/trumpet.png");
  config = loadImage("Icones/checked.png");
  logo = loadImage("Icones/logo.png");
  config = loadImage("Icones/checked.png");
  f = createFont("Arial", 48, true);
  tabInstru[0][0]=1;
  tabInstru[1][0]=77;
  tabInstru[2][0]=25;  
  tabInstru[3][0]=22;
  tabInstru[4][0]=114;

  for (int i=0; i<5; i++) {
    tabInstru[i][1]=0;
  }
  mesInstru=new instru(tabInstru);
}

void draw() {

  background(244, 236, 223);
  tracerTouche(tableauTouche, tabInstru);
  //image(kinect.getColorImage(), 0, 0, width, height);

  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();
      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      drawBody(joints);
      drawHandState(joints[KinectPV2.JointType_HandRight]);
      drawHandState(joints[KinectPV2.JointType_HandLeft]);
      suiviMain(joints, KinectPV2.JointType_HandRight, touchesJoueesDroite);
      suiviMain(joints, KinectPV2.JointType_HandLeft, touchesJoueesGauche);
    }
  }
  myBus.sendControllerChange(0, 1, int(s1.getValue()));
}

void changerInstrument(int byteInstru ) {
  int status_byte = 0xC0;
  int channel = 0;
  int byte2 = 0;
  myBus.sendMessage(status_byte, channel, byteInstru, byte2);
}

void accordMajeur(Note note, boolean jeuArret) {
  if (jeuArret) {
    myBus.sendNoteOn(note);
    note.pitch+=4;
    myBus.sendNoteOn(note);
    note.pitch+=3;
    myBus.sendNoteOn(note);
    note.pitch+=5;
  } else {
    myBus.sendNoteOff(note);
    note.pitch+=4;
    myBus.sendNoteOff(note);
    note.pitch+=3;
    myBus.sendNoteOff(note);
    note.pitch+=5;
  }
  note.pitch-=12;
}

void accordMineur(Note note, boolean jeuArret) {
  if (jeuArret) {
    myBus.sendNoteOn(note);
    note.pitch+=3;
    myBus.sendNoteOn(note);
    note.pitch+=4;
    myBus.sendNoteOn(note);
    note.pitch+=5;
  } else {
    myBus.sendNoteOff(note);
    note.pitch+=3;
    myBus.sendNoteOff(note);
    note.pitch+=4;
    myBus.sendNoteOff(note);
    note.pitch+=5;
  }
  note.pitch-=12;
}

void accord7(Note note, boolean jeuArret) {
  if (jeuArret) {
    myBus.sendNoteOn(note);
    note.pitch+=4;
    myBus.sendNoteOn(note);
    note.pitch+=4;
    myBus.sendNoteOn(note);
    note.pitch+=4;
  } else {
    myBus.sendNoteOff(note);
    note.pitch+=4;
    myBus.sendNoteOff(note);
    note.pitch+=4;
    myBus.sendNoteOff(note);
    note.pitch+=4;
  }
  note.pitch-=12;
}

void mouseClicked() {
  if (mouseX>15 && mouseX<115 && mouseY>200 && mouseY<300) {
    Bloquer_Configuration=Bloquer_Configuration?false:true;
    println(Bloquer_Configuration);
  } else if (mouseX>15 && mouseX<115 && mouseY>400 && mouseY<500) {
    b.survol();
  }
}


void mouseDragged() {// si kinect.getX et kinect.getY ... dans fonction appelée dans mouseDragged
  if (Bloquer_Configuration==false) {
    if (mouseButton==LEFT) {
      for (int i=0; i<12; i++) {
        if (mouseX>tableauTouche[i].x && mouseX<tableauTouche[i].x+100 && mouseY>tableauTouche[i].y && mouseY<tableauTouche[i].y+100)
        {
          println('*');
          tableauTouche[i].x=mouseX-50;
          tableauTouche  [i].y=mouseY-50;
        }
      }
    }
  }
}