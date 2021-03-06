import java.util.Iterator;

// Os efeitos sao decorators.
// Um decorator eh uma classe que "embala" os metodos de outra classe.
// Dai voce pode sobrecarregar um metodo para fazer alguma coisa antes (ou depois)
//  do metodo da classe base. Voce precisa de um "decorator pai" que soh embala os 
//  metodos e nao faz nada. Com isso voce pode criar subclasses dele que fazem coisas.
// A vantagem de usar decorators eh que voce pode combinar varios deles a vontade.
// Uma desvantagem (meio especifica do Java) eh que a sintaxe para criar objetos fica 
//  um pouco mais suja. Pra isso eh interessante criar "factories" ou "builders" de 
//  objetos que montam ele. A makeshape() eh uma factory simplezinha.

abstract class ShapeEffectDecorator implements ShapeInterface {
  ShapeInterface base_shape;

  ShapeEffectDecorator(ShapeInterface s) {
    base_shape = s;
  }

  PShape getPShape() {
    return base_shape.getPShape();
  };

  void draw() {
    base_shape.draw();
  };

  // marca para ser deletado pelo container
  void markExpired() {
    base_shape.markExpired();
  };

  // usado pelo container para saber se deleta
  boolean isExpired() {
    return base_shape.isExpired();
  };

  float getX() {
    return base_shape.getX();
  }

  void setX(float val) {
    base_shape.setX(val);
  }

  float getY() {
    return base_shape.getY();
  }

  void setY(float val) {
    base_shape.setY(val);
  }
}


public class GrowthEffect extends ShapeEffectDecorator {
  float growth_rate;

  GrowthEffect(ShapeInterface s, float growth_rate_) {
    super(s);
    growth_rate = growth_rate_;
  }

  GrowthEffect(ShapeInterface s) {
    this(s, 0.1);
  }

  void grow() {
    base_shape.getPShape().scale(1+growth_rate);
  }

  void draw() {
    grow();
    base_shape.draw();
  }
}


public class FadeEffect extends ShapeEffectDecorator {
  float fade_rate;
  float weight;

  public FadeEffect(ShapeInterface s, float fade_rate_, float initial_weight) {
    super(s);
    fade_rate = fade_rate_;
    weight = initial_weight;
    base_shape.getPShape().setStrokeWeight(weight);
    base_shape.getPShape().setFill(false);
  }

  public FadeEffect(ShapeInterface s) {
    this(s, 0.3, 2);
  }

  void fade() {
    weight = weight*(1-fade_rate);
    base_shape.getPShape().setStrokeWeight(weight);
    if (weight < 0.1)
      base_shape.markExpired();
    //s.setFill(1+growth_rate);
  }

  void draw() {
    fade();
    base_shape.draw();
  }
}

public class RotateEffect extends ShapeEffectDecorator {
  float rotate_angle;

  public RotateEffect(ShapeInterface s, float rotate_angle_) {
    super(s);
    rotate_angle = rotate_angle_;
    //base_shape.getPShape().setFill(false);
  }

  public RotateEffect(ShapeInterface s) {
    this(s, 0.3);
  }

  void rotate() {
    base_shape.getPShape().rotate(rotate_angle);
  }

  void draw() {
    rotate();
    base_shape.draw();
  }
}


public class FallEffect extends ShapeEffectDecorator {
  Motion m;
  float acceleration;
  float v;

  public FallEffect(ShapeInterface s, float acceleration_) {
    super(s);
    acceleration = acceleration_;
    v = 0;
    m = new Motion(s.getX(), s.getY());
  }

  public FallEffect(ShapeInterface s) {
    this(s, 1);
  }

  void fall() {
    v += acceleration;
    m.setVelocity(0, v);
    m.move();
    base_shape.setX(m.getX());
    base_shape.setY(m.getY());
  }

  void draw() {
    fall();
    base_shape.draw();
  }
}