// essa funcao eu nao entendi exatamente o que faz, ainda vo para pra estuda-la
// em especial essa linha for (PVector point : contour.getPolygonApproximation ().getPoints()) {
void openCV() { 
  desenhaEsqueleto = false;
  // muda polygonFactor de tempo em tempo
  // o 30 * 5 é frameCount x segundos para trocar
  // nao sei porque nao funcionou utilizando second() % 5 nem frameCount * 5 ao inves de 30 * 5
  if (second() > 1 && second() % 5 == 0)
  {
    polygonFactor += somaPolygonFactor;
    somaPolygonFactor += somaPolygonFactor;
    if (polygonFactor > 210) polygonFactor = 1;
    println("poligono= " + polygonFactor);
  }
  
  desenhaEsqueleto = false;
  noFill();
  strokeWeight(3);
  threshold = 200; //acontecia quando apertava b, e parece ser o melhor valor,

  opencv.loadImage(kinect.getBodyTrackImage());
  opencv.gray();
  opencv.threshold(threshold);
  //PImage dst = opencv.getOutput();

  ArrayList<Contour> contours = opencv.findContours(false, false);

  if (contours.size() > 0) {
    for (Contour contour : contours) {

      contour.setPolygonApproximationFactor(polygonFactor);
      if (contour.numPoints() > 50) {

        stroke(0, 200, 200);
        beginShape();

        for (PVector point : contour.getPolygonApproximation ().getPoints()) {
          //mapeados para outro valor
          //
          //float xContorno = map(point.x, 0, 512, wmap, 0); 
          //float yContorno = map(point.y, 0, 424, 0, hmap); 
          //vertex(xContorno, yContorno);
          
          //nao mapeados nao precisa criar variavel
          vertex(point.x, point.y);
        }
        endShape();
      }
    }
  }
  
  //quadrado tampando desenho nas bordas
  strokeWeight(5);
  stroke(0);
  rect(0, 0, width, height);
  
  kinect.setLowThresholdPC(minD);
  kinect.setHighThresholdPC(maxD);
}