
int radius = 20;
PShape rect;
boolean a;
int nshapes;
ShapeContainer shapes = new ShapeContainer(50);
int current_shape;
int current_effect;

color c[] = {#F46036, #D7263D, #C5D86D, #1B998B};
int currentColor=int(random(c.length));

int size1, size2;

void setup() {
  frameRate(30);
  size(500, 400, P2D);
  // rect = createShape(RECT, 0, 0, 50, 50);  // so para testar coisas
  size1 = 30;
  size2 = 60;
  current_shape = 4;
  current_effect = 5;
  rectMode(CENTER);
}

void draw() {
  background(0, 0, 0);
  shapes.draw_and_clean();

  // (da uma olhada nos comentarios das outras tabs para entender 
  //   a implementacao)
  // O que vai acontecer com esse objeto eh o seguinte:
  // - O ShapeContainer vai chamar um draw pra cada objeto que existe na tela.
  // - O objeto feito com makeshape eh da classe FadeEffect.
  // - O FadeEffect.draw() vai chamar fade(), depois vai chamar o draw() do
  //     objeto "abaixo" dele, que eh da classe GrowthEffect
  // - O GrowthEffect.draw() chama o grow() e depois o draw() do Shape
  // - O Shape.draw() desenha o objeto na tela, com os efeitos fade() e grow()


if (mousePressed) {
    Shape s;
    ShapeInterface si;

    switch (current_shape) {
      case 1:
        s = makeshape(ELLIPSE, mouseX, mouseY, size1, size1);
        break;
      case 2:
        s = makeshape(ELLIPSE, mouseX, mouseY, size1, size2);
        break;
      case 3:
        s = makeshape(RECT, mouseX, mouseY, size1, size2);
        break;
      case 4:
        s = makeshape(RECT, mouseX, mouseY, size1, size1);
        break;
      case 5:
        s = makeshape(3, mouseX, mouseY, size1);
        break;
      case 6:
        s = makeshape(5, mouseX, mouseY, size1);
        break;
      case 7:
        s = makeshape(6, mouseX, mouseY, size1);
        break;
      default:
        s = makeshape(RECT, mouseX, mouseY, size1, size1);
        break;
    }
    
    switch (current_effect) {
      case 1:
        si = new FadeEffect(new GrowthEffect(s, 0.2), 0.1, 1); // tunel
      break;
      case 2:
        si = new FadeEffect(new GrowthEffect(s, 0.2), 0.3, 3); // shapes
      break;
      case 3:
        si = new GrowthEffect(new FadeEffect(s, 0.1, 1),0.2);
      break;
      case 4:
        si = new GrowthEffect(new FadeEffect(new RotateEffect(s,0.3), 0.3, 3),0.3); // rotate still
      break;
      case 5:
        si = new GrowthEffect(new FadeEffect(new RotateEffect(s,radians(frameCount%360)), 0.3, 3),0.3); // rotate movement
      break;
      default:
        si = new FadeEffect(new GrowthEffect(s, 0.2), 0.3, 3);
      break;
    }
    
    shapes.add(si);
  }
}

void keyPressed() {
  switch(key) {
  case '1':
    current_shape = 1;
    break;
  case '2':
    current_shape = 2;
    break;
  case '3':
    current_shape = 3;
    break;
  case '4':
    current_shape = 4;
    break;
  case '5':
    current_shape = 5;
    break;
  case '6':
    current_shape = 6;
    break;
  case '7':
    current_shape = 7;
    break;
  case '+':
    size1++; 
    size2++;
    break;
  case '-':
    size1--; 
    size2--;
    break;
  case 'c':
    currentColor=(currentColor+1)%c.length;
    break;
  }
}


Shape makeshape(int type, int x, int y, int w, int h) {
  PShape r = createShape(type, 0, 0, w, h);
  r.setStroke(c[currentColor]);
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
  r.setStroke(c[currentColor]);
  
  Shape s = new Shape(r, x, y);

  return s;
}




// shapes possiveis:
// POINT, LINE, TRIANGLE, QUAD, RECT, ELLIPSE, ARC, BOX, SPHERE