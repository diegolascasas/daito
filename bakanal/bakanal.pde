import java.util.ArrayList;
import KinectPV2.KJoint;
import KinectPV2.*;
import gab.opencv.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

KinectPV2 kinect;
OpenCV opencv;

//coisas da deteccao de borda
float polygonFactor = 1;      
float somaPolygonFactor = 0.2;
int threshold = 10;            //*** por em interface osc para calibrar
//Distance in cm
int maxD = 4500; //4.5m
int minD = 500;  //50cm

int tempoMudanca = 10;
int maxInteracoes = 3; 
int interacao = 2;
int contadorInteracao = 0;
int wmap = 1920;
int hmap = 1080;
int minutos = 0;
int currentMinute = minute();
int fRate = 30;
//variaveis para receberem valores x e y de diferentes pontos do corpo
//criei elas ao inves de usar diretamente a funcao porque fica mais facil para escrever e ler
float mao_xe, mao_ye, mao_ze, mao_xd, mao_yd, mao_zd;
float pe_xe, pe_ye, pe_ze, pe_xd, pe_yd, pe_zd;
float neck_x, neck_y, neck_z, head_x, head_y, head_z;
float spineMid_x, spineMid_y, spineMid_z, spineBase_x, spineBase_y, spineBase_z; 

boolean desenhaEsqueleto = true;
boolean foundUsers = false;


void setup() {
  size(512, 424, P3D);
  //fullScreen(P3D, 1);
  //size(1920, 1080, P3D);
  frameRate(fRate);
  noCursor();

  oscP5 = new OscP5(this, 7000);

  opencv = new OpenCV(this, 512, 424);
  kinect = new KinectPV2(this);
  kinect.enableSkeletonDepthMap(true); //para esqueleto
  kinect.enableBodyTrackImg(true);     //para silhuete
  kinect.init();
}

void draw() {
  background(0);
  strokeWeight(5);
  // mandar como argumento qual a interacao (por enquanto desenho que sai das maos), foi so assim
  // que consegui fazer desenhar porque precisa estar dentro do loop para usar as joints, ver funcao
  interacoes(interacao); 
  if (retornaMinutos() != 0 && retornaMinutos() % tempoMudanca == 0) interacao++;
  //println(interacao);
  if (interacao >= maxInteracoes){
    interacao = 0;
  }
  
  // algo parecido com isso abaixo que funcionasse talvez seria melhor 
  // asterisco(joints[KinectPV2.JointType_HandLeft], joints[KinectPV2.JointType_HandRight]);
  // talvez com as variaveis recebendo os x e y dos pontos colocar uma funcao aqui no draw controla qual a interacao
  // ativa no momento e chama a funcao com as variaveis globais que tem os valores dos pontos
  // ta tudo muito concentrado em uma funcao no f_kinect, chamada esqueletoKinect();


  //fill(255, 0, 0);
  //text(frameRate, 50, 50);

  //saveFrame("teste-######.png");
}


void oscEvent(OscMessage mensagemOSC) {
  // tem esse contador porque o botao do programa osc manda mensagem duas vezes, uma quando aperta
  // e outra quando solta o botao, ainda vo resolver isso na hora de fazer o botao la mas por enquanto
  // isso aqui ta resolvendo
  if (mensagemOSC.checkAddrPattern("/sorteia")) {
    contadorInteracao++;
    if (contadorInteracao % 2 == 0)
      interacao = int(random(6));
  }
}

void keyPressed() {
  // fiz esse aqui porque o OSC nao tava rolando na casa do rafa por nao ter wifi
  if (key == 'i') interacao = int(random(6));

  //relativo a deteccao de bordas
  if (key == 'a') threshold+=1;
  if (key == 's') threshold-=1;
  if (key == '1') minD += 10;
  if (key == '2') minD -= 10;
  if (key == '3') maxD += 10;
  if (key == '4') maxD -= 10;
  if (key == '5') polygonFactor += 0.1;
  if (key == '6') polygonFactor -= 0.1;
}

//retorna quantos minutos desde que comecou a rodar
int retornaMinutos(){
  if (minute() != currentMinute) minutos ++;
  currentMinute = minute();
  return minutos;  
}