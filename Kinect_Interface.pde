//import KinectPV2.KJoint;
//import KinectPV2.*;
import themidibus.*;
import processing.sound.*;

//KinectPV2 kinect;
MidiBus myBus; 
Note NoteTest;

void setup() {
  fullScreen();
  //size(1280, 700, P3D);
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  //               Parent  In     Out
  //                 |     |       |
myBus = new MidiBus(this, -1, "VMPK Input");
NoteTest = new Note(0, 50, 127); // Pour creer les notes especifiques! Pendante
}

void draw() {
  background(50);
  int channel = 0;
  int pitch = 60; // Initial
  int ecarteur = 6; //Separer
  int velocity = 127;
  int speed = abs(mouseX-pmouseX) + abs(mouseY-pmouseY);
  int delay_ = 200 - (speed/5); 
  
  fill(255, 0, 0);
  tint(255,100);
  dessinClavier();
  
  // DO
  if((mouseX > 0 && mouseX < width/7) && (mouseY > height*2/3 && mouseY < height)){
    myBus.sendNoteOn(channel, pitch, speed + 60);
    fill(115, 242, 220);
    rect(0, height*2/3, width/7, height);
    if (mousePressed){
      fill(82, 105, 247);
      rect(0, height*2/3, width/7, height);
       pitch += ecarteur*3/2;
       myBus.sendNoteOn(channel, pitch, velocity*3); 
       //delay(-100);
    }
    delay(delay_); 
  } 
  // RE
  if((mouseX > width/7 && mouseX < width*2/7) && (mouseY > height*2/3 && mouseY < height)){
    pitch += ecarteur;
    myBus.sendNoteOn(channel, pitch, speed + 60);  
    fill(115, 242, 220);
    rect(width/7, height*2/3, width/7, height); 
    if (mousePressed){
      fill(82, 105, 247);
      rect(width/7, height*2/3, width/7, height);
      pitch += ecarteur*3/2;
      myBus.sendNoteOn(channel, pitch, velocity*3); 
      //delay(-100);
    }
    delay(delay_);
  } 
  // MI
  if((mouseX > width*2/7 && mouseX < width*3/7) && (mouseY > height*2/3 && mouseY < height)){
    pitch += ecarteur*2;
    myBus.sendNoteOn(channel, pitch, speed + 60); 
    fill(115, 242, 220);
    rect(width*2/7, height*2/3, width/7, height); 
    if (mousePressed){
      fill(82, 105, 247);
      rect(width*2/7, height*2/3, width/7, height);
      pitch += ecarteur*3/2;
      myBus.sendNoteOn(channel, pitch, velocity*3); 
      //delay(-100);
    }
    delay(delay_);
  }
  // FA
  if((mouseX > width*3/7 && mouseX < width*4/7) && (mouseY > height*2/3 && mouseY < height)){
    pitch += ecarteur*3;
    myBus.sendNoteOn(channel, pitch, speed + 60); 
    fill(115, 242, 220);
    rect(width*3/7, height*2/3, width/7, height); 
    if (mousePressed){
      fill(82, 105, 247);
      rect(width*3/7, height*2/3, width/7, height);
      pitch += ecarteur*3/2;
       myBus.sendNoteOn(channel, pitch, velocity*3); 
       //delay(-100);
    }
    delay(delay_);
  } 
  // SOL
  if((mouseX > width*4/7 && mouseX < width*5/7) && (mouseY > height*2/3 && mouseY < height)){
    pitch += ecarteur*4;
    myBus.sendNoteOn(channel, pitch, speed + 60); 
    fill(115, 242, 220);
    rect(width*4/7, height*2/3, width/7, height); 
    if (mousePressed){
      fill(82, 105, 247);
      rect(width*4/7, height*2/3, width/7, height);
      pitch += ecarteur*3/2;
      myBus.sendNoteOn(channel, pitch, velocity*3); 
      //delay(-100);
    }
    delay(delay_);
  } 
  // LA
  if((mouseX > width*5/7 && mouseX < width*6/7) && (mouseY > height*2/3 && mouseY < height)){
    pitch += ecarteur*5;
    myBus.sendNoteOn(channel, pitch, speed + 60); 
    fill(115, 242, 220);
    rect(width*5/7, height*2/3, width/7, height); 
    if (mousePressed){
      fill(82, 105, 247);
      rect(width*5/7, height*2/3, width/7, height);
      pitch += ecarteur*3/2;
      myBus.sendNoteOn(channel, pitch, velocity*3); 
      //delay(-100);
    }
    delay(delay_);
  } 
  // SI
  if((mouseX > width*6/7 && mouseX < width) && (mouseY > height*2/3 && mouseY < height)){
    pitch += ecarteur*6;
    myBus.sendNoteOn(channel, pitch, speed + 60); 
    fill(115, 242, 220);
    rect(width*6/7, height*2/3, width/7, height); 
    if (mousePressed){
      fill(82, 105, 247);
      rect(width*6/7, height*2/3, width/7, height);
      pitch += ecarteur*3/2;
      myBus.sendNoteOn(channel, pitch, velocity*3); 
      //delay(-100);
    }
    delay(delay_);
  } 
  
  noTint();
  text(frameRate, 30, 30);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

void dessinClavier() {

  // Boutons blancs
  stroke(0);
  fill(255); //blanc
  for (int i=0; i<width; i+=width/7 + 1 ){ // + 1 car le limite est repeté a chaque iteration et on perd l'espace a la fin
    rect(i, height*2/3, width/7, height);
  }
  
  //Boutons noirs (optional)
  fill(0); //noir
  rect(width/7 - 20, height*2/3, 40, height/6, 0, 0, 5, 5);
  rect(width*2/7 - 20, height*2/3, 40, height/6, 0, 0, 5, 5);
  rect(width*4/7 - 20, height*2/3, 40, height/6, 0, 0, 5, 5);
  rect(width*5/7 - 20, height*2/3, 40, height/6, 0, 0, 5, 5);
  rect(width*6/7 - 20, height*2/3, 40, height/6, 0, 0, 5, 5);
  
  //Text des boutons
  fill(0, 102, 153);
  textSize(30); //etait 32
  text("DO", width/14 -20, height-50);
  text("RE", width*3/14 -20, height-50);
  text("MI", width*5/14 -20, height-50);
  text("FA", width*7/14 -20, height-50);
  text("SOL", width*9/14 -25, height-50);
  text("LA", width*11/14 -20, height-50);
  text("SI", width*13/14 -20, height-50);
  //text("DO", 1460, 935); //c'est necessaire de repeter?

}