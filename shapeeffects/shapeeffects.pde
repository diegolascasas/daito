
int radius = 20;
PShape rect;
boolean a;
int nshapes;
ShapeContainer shapes = new ShapeContainer(200);
int current_shape;

int size1, size2;

void setup() {
  frameRate(30);
  size(500, 400, P2D);
  // rect = createShape(RECT, 0, 0, 50, 50);  // so para testar coisas
  size1 = 30;
  size2 = 60;
  current_shape = 4;
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
    ShapeInterface s;
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
    default:
      s = makeshape(RECT, mouseX, mouseY, size1, size1);
      break;
    }
    shapes.add(s);
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
  case '+':
    size1++; size2++;
    break;
  case '-':
    size1--; size2--;
    break;
  }
}


ShapeInterface makeshape(int type, int x, int y, int w, int h) {
  PShape r = createShape(type, 0, 0, w, h);
  r.setStroke(color(127,127,255));
  Shape s = new Shape(r,x,y);
  return new FadeEffect(new GrowthEffect(s, 0.2), 0.3, 3);
 }


// shapes possiveis:
// POINT, LINE, TRIANGLE, QUAD, RECT, ELLIPSE, ARC, BOX, SPHERE