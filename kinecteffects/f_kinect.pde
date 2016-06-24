//Pega as posicoes, checa se esta trackeado, escolhe cor, desenha esqueleto usando outras funcoes abaixo
void interacoes(int desenho) {
  //get the skeletons as an Arraylist of KSkeletons
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonDepthMap();
  //individual joints
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    //if the skeleton is being tracked compute the skleton joints
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();
      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      
      //mapea juntas usadas do tamanho da imagem do kinect para outros tamanhos de tela
      //
      //head_x = map(joints[KinectPV2.JointType_Head].getX(), 0, 512, wmap, 0);
      //head_y = map(joints[KinectPV2.JointType_Head].getY(), 0, 424, 0, 1080);
      //head_z = joints[KinectPV2.JointType_Head].getZ();
      //neck_x = map(joints[KinectPV2.JointType_HandLeft].getX(), 0, 512, wmap, 0);
      //neck_y = map(joints[KinectPV2.JointType_HandLeft].getX(), 0, 424, 0, 1080);
      //neck_z = joints[KinectPV2.JointType_Neck].getZ();
      
      //spineMid_x = map(joints[KinectPV2.JointType_SpineBase].getX(), 0, 512, wmap, 0);
      //spineMid_y = map(joints[KinectPV2.JointType_SpineBase].getY(), 0, 424, 0, hmap);
      //spineMid_z = joints[KinectPV2.JointType_SpineBase].getZ();
      //spineBase_x = map(joints[KinectPV2.JointType_SpineBase].getX(), 0, 512, wmap, 0);
      //spineBase_y = map(joints[KinectPV2.JointType_SpineBase].getY(), 0, 424, 0, hmap);
      //spineBase_z = joints[KinectPV2.JointType_SpineBase].getZ();

      //mao_xe = map(joints[KinectPV2.JointType_HandLeft].getX(), 0, 512, wmap, 0);
      //mao_ye = map(joints[KinectPV2.JointType_HandLeft].getY(), 0, 424, 0, hmap);
      //mao_ze = joints[KinectPV2.JointType_HandLeft].getZ();
      //mao_xd = map(joints[KinectPV2.JointType_HandRight].getX(), 0, 512, wmap, 0);
      //mao_yd = map(joints[KinectPV2.JointType_HandRight].getY(), 0, 424, 0, hmap);
      //mao_zd = joints[KinectPV2.JointType_HandRight].getZ();
      
      //pe_xe = joints[KinectPV2.JointType_AnkleLeft].getX(), 0, 512, wmap, 0);
      //pe_ye = map(joints[KinectPV2.JointType_AnkleLeft].getY(), 0, 424, 0, hmap);
      //pe_ze = joints[KinectPV2.JointType_AnkleLeft].getZ();
      //pe_xd = map(joints[KinectPV2.JointType_AnkleRight].getX(), 0, 512, wmap, 0);
      //pe_yd = map(joints[KinectPV2.JointType_AnkleRight].getY(), 0, 424, 0, hmap);
      //pe_zd = joints[KinectPV2.JointType_AnkleRight].getZ();
      
      //atribui valores a variaveis para fica mais facil usar
      //
      head_x = joints[KinectPV2.JointType_Head].getX();
      head_y = joints[KinectPV2.JointType_Head].getY();
      head_z = joints[KinectPV2.JointType_Head].getZ();
      neck_x = joints[KinectPV2.JointType_HandLeft].getX();
      neck_y = joints[KinectPV2.JointType_HandLeft].getX();
      neck_z = joints[KinectPV2.JointType_Neck].getZ();
      
      spineMid_x = joints[KinectPV2.JointType_SpineBase].getX();
      spineMid_y = joints[KinectPV2.JointType_SpineBase].getY();
      spineMid_z = joints[KinectPV2.JointType_SpineBase].getZ();
      spineBase_x = joints[KinectPV2.JointType_SpineBase].getX();
      spineBase_y = joints[KinectPV2.JointType_SpineBase].getY();
      spineBase_z = joints[KinectPV2.JointType_SpineBase].getZ();
      
      mao_xe = joints[KinectPV2.JointType_HandLeft].getX();
      mao_ye = joints[KinectPV2.JointType_HandLeft].getY();
      mao_ze = joints[KinectPV2.JointType_HandLeft].getZ();
      mao_xd = joints[KinectPV2.JointType_HandRight].getX();
      mao_yd = joints[KinectPV2.JointType_HandRight].getY();
      mao_zd = joints[KinectPV2.JointType_HandRight].getZ();
      
      pe_xe = joints[KinectPV2.JointType_AnkleLeft].getX();
      pe_ye = joints[KinectPV2.JointType_AnkleLeft].getY();
      pe_ze = joints[KinectPV2.JointType_AnkleLeft].getZ();
      pe_xd = joints[KinectPV2.JointType_AnkleRight].getX();
      pe_yd = joints[KinectPV2.JointType_AnkleRight].getY();
      pe_zd = joints[KinectPV2.JointType_AnkleRight].getZ();
      
      //esse if faz os desenhos piscarem de tempo em tempo, uma opcao quem sabe pra acontecer de vez em quando
      //if (frameCount % 5 == 0) {
      if (desenhaEsqueleto) drawBody(joints);
      
      if (desenho == 0) openCV();
      else if (desenho == 1) corposFormas();
      else if (desenho == 2) corposASC();
      //else if (desenho == 3) desenhaFormas();
      //guardei para se futuramente for usar interacao com handState ja ter algo pronto p ver como funciona
      //drawHandState(joints[KinectPV2.JointType_HandRight]);
      //drawHandState(joints[KinectPV2.JointType_HandLeft]);
      //}
    }
  }
}

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
}

//draw a bone from two joints
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  //mapeados para outro tamanho
  //
  //float x = map(joints[jointType1].getX(), 0, 512, wmap, 0);
  //float y = map(joints[jointType1].getY(), 0, 424, 0, hmap);
  //float x2 = map(joints[jointType2].getX(), 0, 512, wmap, 0);
  //float y2 = map(joints[jointType2].getY(), 0, 424, 0, hmap);
  
  //nao mapeados
  //
  float x = joints[jointType1].getX();
  float y = joints[jointType1].getY();
  float x2 = joints[jointType2].getX();
  float y2 = joints[jointType2].getY();
  
  translate(x, y, joints[jointType1].getZ());
  //ellipse(0, 0, 25, 25);
  popMatrix();
  line(x, y, joints[jointType1].getZ(), x2, y2, joints[jointType2].getZ());
}

//draw a ellipse depending on the hand state
//guardei para se futuramente for usar interacao com handState ja ter algo pronto p ver como funciona
void drawHandState(KJoint joint) {
  noStroke();
  handState(joint.getState());
  pushMatrix();
  translate(joint.getX(), joint.getY(), joint.getZ());
  ellipse(0, 0, 70, 70);
  popMatrix();
}

//Depending on the hand state change the color
//guardei para se futuramente for usar interacao com handState ja ter algo pronto p ver como funciona
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
    fill(100, 100, 100);
    break;
  }
}