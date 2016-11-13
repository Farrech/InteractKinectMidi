
import KinectPV2.KJoint;
import KinectPV2.*;
import themidibus.*;
import processing.sound.*;

KinectPV2 kinect;
MidiBus myBus; 
boolean Test=false;
void setup() {
  size(1920, 1080, P3D);

  kinect = new KinectPV2(this);
  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);
  kinect.init();
  myBus = new MidiBus(this, -1, "Microsoft MIDI Mapper");
}

void draw() {
  background(0);



  image(kinect.getColorImage(), 0, 0, width, height);

  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
  int channel = 0;
  int pitch=0;
  int velocity = 127;

  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {


    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      //drawBody(joints);

      //draw different color for each hand state
      drawHandState(joints[KinectPV2.JointType_HandRight]);
      textSize(60);
      //text(joints[KinectPV2.JointType_HandRight].getX(), 400, 50);
      text(joints[KinectPV2.JointType_HandRight].getY(), 400, 50);


      if (joints[KinectPV2.JointType_HandRight].getY()>0&&joints[KinectPV2.JointType_HandRight].getY()<100) {
        pitch=36;
      } else if (joints[KinectPV2.JointType_HandRight].getY()>100&&joints[KinectPV2.JointType_HandRight].getY()<200) {
        pitch=38;
      } else if (joints[KinectPV2.JointType_HandRight].getY()>200&&joints[KinectPV2.JointType_HandRight].getY()<300) {
        pitch=40;
      } else if (joints[KinectPV2.JointType_HandRight].getY()>300&&joints[KinectPV2.JointType_HandRight].getY()<400) {
        pitch=41;
      } else if (joints[KinectPV2.JointType_HandRight].getY()>400&&joints[KinectPV2.JointType_HandRight].getY()<500) {
        pitch=43;
      } else if (joints[KinectPV2.JointType_HandRight].getY()>500&&joints[KinectPV2.JointType_HandRight].getY()<600) {
        pitch=45;
      } else if (joints[KinectPV2.JointType_HandRight].getY()>600&&joints[KinectPV2.JointType_HandRight].getY()<700) {
        pitch=47;
      } else if (joints[KinectPV2.JointType_HandRight].getY()>700&&joints[KinectPV2.JointType_HandRight].getY()<800) {
        pitch=48;
      }

      if (joints[KinectPV2.JointType_HandRight].getState()==KinectPV2.HandState_Open && Test==false)
      {
        myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
        Test=true;
      }
      // delay(200);
      if (joints[KinectPV2.JointType_HandRight].getState()==KinectPV2.HandState_Closed)
      {
        myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
        Test=false;
      }


      drawHandState(joints[KinectPV2.JointType_HandLeft]);
    }
  }

  fill(255, 0, 0);
  tint(255,100);
  dessinClavier();
  noTint();
  text(frameRate, 50, 50);
}

//DRAW BODY
void drawBody(KJoint[] joints) {
  drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
  drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
  drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);

  // Right Arm
  drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
  drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
  drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);

  // Left Arm
  drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
  drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);

  // Right Leg
  drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
  drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
  drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);

  // Left Leg
  drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
  drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
  drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);

  drawJoint(joints, KinectPV2.JointType_HandTipLeft);
  drawJoint(joints, KinectPV2.JointType_HandTipRight);
  drawJoint(joints, KinectPV2.JointType_FootLeft);
  drawJoint(joints, KinectPV2.JointType_FootRight);

  drawJoint(joints, KinectPV2.JointType_ThumbLeft);
  drawJoint(joints, KinectPV2.JointType_ThumbRight);

  drawJoint(joints, KinectPV2.JointType_Head);
}

//draw joint
void drawJoint(KJoint[] joints, int jointType) {
  pushMatrix();
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
}

//draw bone
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}

//draw hand state
void drawHandState(KJoint joint) {
  noStroke();
  handState(joint.getState());
  pushMatrix();
  translate(joint.getX(), joint.getY(), joint.getZ());
  ellipse(0, 0, 70, 70);
  popMatrix();
}

/*
Different hand state
 KinectPV2.HandState_Open
 KinectPV2.HandState_Closed
 KinectPV2.HandState_Lasso
 KinectPV2.HandState_NotTracked
 */
void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    fill(0, 255, 0);
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0);
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255);
    break;
  case KinectPV2.HandState_NotTracked:
    fill(255, 255, 255);
    break;
  }
}
void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}
void dessinClavier() {


  stroke(0);
  fill(80, 0, 153);
  rect(1400, 0, 1920, 1080);
  for (int i=100; i<1000; i+=100) {
    line(1400, i, 1920, i);
  }
  fill(0, 102, 153);
  textSize(32);
  text("DO", 1400, 50);
  text("RE", 1400, 150);
  text("MI", 1400, 250);
  text("FA", 1400, 350);
  text("SOL", 1400, 450);
  text("LA", 1400, 550);
  text("SI", 1400, 650);
  text("DO", 1400, 750);

}