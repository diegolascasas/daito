
ShapeContainer shapes = new ShapeContainer(200);
int total_shapes=7;
int current_shape=0;

int total_effects=4;
int current_effect=0;

color c[] = {#F46036, #D7263D, #C5D86D, #1B998B, #5F55A0};
int current_color=int(random(c.length));

int size1=30;
int size2=60;

void desenhaFormas(){
  rectMode(CENTER);
  
  // trocar essas variáveis pelas referentes ao kinect
  boolean hand = mousePressed; // aberta/fechada/seilá 
  int handX = mouseX;
  int handY = mouseY;
  
  shapes.draw_and_clean();
  
  if (hand) {
    Shape s = createMyShape(handX, handY);
    ShapeInterface si = addEffect(s);
    shapes.add(si);
  }
}

void changeColor(){
  current_color=(current_color+1)%c.length;
}

void changeShape(){
  current_shape=(current_shape+1)%total_shapes;
}

void changeEffect(){
  current_effect=(current_effect+1)%total_effects;
}


Shape createMyShape(int x, int y){
  Shape s;
  switch (current_shape) {
      case 0:
        s = makeshape(ELLIPSE, x, y, size1, size1);
        break;
      case 1:
        s = makeshape(ELLIPSE, x, y, size1, size2);
        break;
      case 2:
        s = makeshape(RECT, x, y, size1, size2);
        break;
      case 3:
        s = makeshape(RECT, x, y, size1, size1);
        break;
      case 4:
        s = makeshape(3, x, y, size1);
        break;
      case 5:
        s = makeshape(5, x, y, size1);
        break;
      case 6:
        s = makeshape(6, x, y, size1);
        break;
      default:
        s = makeshape(RECT, x, y, size1, size1);
        break;
    }
    return s;
}

ShapeInterface addEffect(Shape s){
  ShapeInterface si;
  switch (current_effect) {
      case 0:
        si = new FadeEffect(new GrowthEffect(s, 0.2), 0.1, 1); // tunel
      break;
      case 1:
        si = new FadeEffect(new GrowthEffect(s, 0.2), 0.3, 3); // shapes
      break;
      case 2:
        si = new GrowthEffect(new FadeEffect(new RotateEffect(s,0.3), 0.3, 3),0.3); // rotate still
      break;
      case 3:
        si = new GrowthEffect(new FadeEffect(new RotateEffect(s,radians(frameCount%360)), 0.5, 5),0.5); // rotate movement
      break;
      default:
        si = new FadeEffect(new GrowthEffect(s, 0.2), 0.3, 3);
      break;
    }
    return si;
}


Shape makeshape(int type, int x, int y, int w, int h) {
  PShape r = createShape(type, 0, 0, w, h);
  r.setStroke(c[current_color]);
  Shape s = new Shape(r, x, y);
  return s;
}

// Função pra criar formas diferentes (como triângulos, pentágonos e hexágonos)
Shape makeshape(int npoints, int x, int y, float radius) {
  PShape r = createShape();
  float angle = TWO_PI / npoints;
  r.beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = 0 + cos(a) * radius;
    float sy = 0 + sin(a) * radius;
    r.vertex(sx, sy);
  }
  r.endShape(CLOSE);
  r.setStroke(c[current_color]);
  
  Shape s = new Shape(r, x, y);

  return s;
}