void corposFormas() {
  desenhaEsqueleto = false;

  PImage img = kinect.getBodyTrackImage();
  int [] rawData = kinect.getRawBodyTrack();
  foundUsers = false;
  //iterate through 1/5th of the data
  for (int i = 0; i < rawData.length; i+=5) {
    if (rawData[i] != 255) {
      //found something
      foundUsers = true;
      break;
    }
  }

  int skip = 15;

  for (int x = 0; x < img.width; x += skip) {
    for (int y = 0; y < img.height; y += skip) {
      int index = x + y * img.width;
      float brilho = brightness(img.pixels[index]);
      //float z = map(brilho, 0, 255, 150, -150);
      if (brilho < 50) {
        noFill();

        strokeWeight(1);
        if (x > img.width/2) {
          rect(x, y, skip, skip);
        } else {
          ellipse(x, y, skip, skip);
        }
      }
    }
  }
}

void corposASC() {
  desenhaEsqueleto = false;
  int grupo1[] = {33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47}; 
  int grupo2[] = {48, 49, 58, 59, 60, 61, 62, 63, 64, 91, 92, 93, 94, 95, 96};
  int grupo3[] = {65, 67, 75, 87, 89, 90, 77, 70, 100, 101, 105, 109, 110, 113};

  PImage img = kinect.getBodyTrackImage();
  int [] rawData = kinect.getRawBodyTrack();
  foundUsers = false;
  //iterate through 1/5th of the data
  for (int i = 0; i < rawData.length; i+=5) {
    if (rawData[i] != 255) {
      //found something
      foundUsers = true;
      break;
    }
  }

  int skip = 16;
  textSize(18);
  int numero = 0;

  for (int x = 0; x < img.width; x += skip) {
    for (int y = 0; y < img.height; y += skip) {
      int index = x + y * img.width;
      float brilho = brightness(img.pixels[index]);
      //float z = map(brilho, 0, 255, 150, -150);
      if (brilho < 50) {
        fill(0, 255, 100);
        //char caractere = char(grupo[int(random(10))]);
        if (x < img.width/3) {
          //fill(255, 0, 0);
          numero = grupo1[int(random(grupo1.length))];
        } else if (x > img.width/3 && x < img.width/3 * 2) {
          //fill(0, 255, 0);
          numero = grupo2[int(random(grupo2.length))];
        } else {
          //fill(0, 0, 255);
          numero = grupo3[int(random(grupo3.length))];
        }
        char caractere = char (numero); 
        text(caractere, x, y);
      }
    }
  }
}