//import java.util.Iterator;


// A classe Shape eh a versao concreta da ShapeInterface.
// Podemos dizer que a ShapeInterface declara o que da pra fazer, e a
//  Shape implementa essas acoes. Os metodos definidos nos decorators
//  geralmente vao fazer alguma coisa e chamar a shape.
class Shape implements ShapeInterface{
  int x, y;
  boolean expired; // so para ficar mais facil de limpar no ShapeContainer.
  PShape ps;

  Shape(PShape ps_, int x_, int y_) {
    x = x_;
    y = y_;
    ps = ps_;
    expired = false;
  }

  PShape getPShape(){
     return ps; 
  }

  void draw() {
    shape(ps, x, y);
  }

  boolean isExpired(){
    return expired;
  }

  void markExpired(){
    expired = true;
  }
}



class ShapeContainer {
  ArrayList<ShapeInterface> shapes;
  int maxsize;

  ShapeContainer(int maxsize_) {
    shapes = new ArrayList<ShapeInterface>();
    maxsize = maxsize_;
  }
  
  ShapeContainer() {
    this(100);
  }

  void add(ShapeInterface s) {
    if (this.shapes.size()>= maxsize)
      this.shapes.remove(0);
    this.shapes.add(s);
  }

  void draw_and_clean() {     
    Iterator<ShapeInterface> it = shapes.iterator();
    while(it.hasNext()) {
        ShapeInterface s = it.next();
        if (s.isExpired()){
          it.remove();
        } else{
          s.draw();
        }
     }
  }
}


// Implementacao alternativa: 
//    Usar heranca para gerar objetos com efeitos mais sofisticados.
//    Para poucos efeitos ela vale a pena, mas usar decorators eh mais modular. 
// 
//class Shape {
//  PShape s;
//  int x, y;
//  boolean remove; // so para ficar mais facil de limpar no ShapeContainer.

//   Shape(PShape s_, int x_, int y_) {
//    x = x_;
//    y = y_;
//    s = s_;
//    remove = false;
//  }

//  void draw() {
//    shape(s, x, y);
//  }
//}

//public class GrowingShape extends Shape {
//  float growth_rate;

//  GrowingShape(PShape s_, int x_, int y_, float growth_rate_) {
//    super(s_, x_, y_);
//    growth_rate = growth_rate_;
//  }

//  GrowingShape(PShape s_, int x_, int y_) {
//    this(s_, x_, y_, 0.1);
//  }

//  void grow() {
//    s.scale(1+growth_rate);
//  }

//  void draw() {
//    grow();
//    super.draw();
//  }
//}


//public class PulsingShape extends GrowingShape {
//  float fade_rate;
//  float weight;

//  public PulsingShape(PShape s_, int x_, int y_, float growth_rate_, float fade_rate_, float initial_weight) {
//    super(s_, x_, y_, growth_rate_);
//    fade_rate = fade_rate_;
//    weight = initial_weight;
//    s.setStrokeWeight(weight); 
//    s.setFill(false);
//  }

//  public PulsingShape(PShape s_, int x_, int y_) {
//    this(s_, x_, y_, 0.1, 0.3, 2);
//  }

//  void fade() {
//    weight = weight*(1-fade_rate);
//    s.setStrokeWeight(weight);
//    if (weight < 0.1)
//      s.setVisible(false);
//    //s.setFill(1+growth_rate);
//  }

//  void draw() {
//    fade();
//    super.draw();
//  }
//}