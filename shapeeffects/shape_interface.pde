

// A interface eh a classe "raiz" de todas as outras.
// Ela serve para definir os metodos que vao existir em todas as classes.
// Com ela eu posso declarar uma variavel do tipo ShapeInterface que pode
//  receber objetos tanto do tipo Shape quanto do tipo ShapeEffectDectorator
//  (ou qualquer subclasse deles). 
// Essa interface esta montada em cima da classe PShape, do processing.
interface ShapeInterface {
  
  //PShape ps;
  PShape getPShape();

  // desenha na tela
  void draw();

  // marca para ser deletado pelo container
  void markExpired();

  // usado pelo container para saber se deleta
  boolean isExpired();

  float getX();
  void setX(float val);
  
  float getY();
  void setY(float val);
}