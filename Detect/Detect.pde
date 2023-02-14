
int DOT_RESOLUTION = 20;
String PICFILE = "us-temps.png";

PImage art;
boolean showDots;
int resolution;

/*================================
  You should leave setup alone, with the exception
  of changing the size if not using the provided boats.jpg
  imgage.
================================*/
void setup() {
  size(770, 550);
  showDots = false;
  resolution = DOT_RESOLUTION;
  art = loadImage(PICFILE);
  art.loadPixels();
}//setup

/*================================
  You should leave draw alone.
================================*/
void draw() {
  background(255);
  image(art, 0, 0);
  if (showDots) {
    dots(art, resolution);
  }
}//draw


/*================================
  keyPressed
  `r`: reset back to the original image.
  `g`: grayScale the image
  `e`: perform edge detection on the image (this will be added tomorrow)
================================*/
void keyPressed() {
  if (key == 'h') {
    art = highlightRed(art);
    art.updatePixels();
  }
  else if (key == 'd') {
    showDots = !showDots;
  }//edge detect
  else if (key == 'r') {
    art = loadImage(PICFILE);
    art.loadPixels();
  }//reset image
}//keyPressed


/*================================
  Returns the grayScale value of a color
================================*/
int calculateGray(color c) {
  int g = int((red(c) + green(c) + blue(c)))/3;
  return g;
}//calculateGray
/*================================
  Returns the correct pixel index for img based on the provided x and y values.
================================*/
int getIndexFromXY(int x, int y, PImage img) {
  return y * img.width + x;
}//getIndexFromXY


PImage highlightRed(PImage img) {
  
  for (int i = 0; i < img.pixels.length; i++) {
    
    color c = img.pixels[i];
    float r = red(c);
    
    float g = green(c);
    float b = blue(c);
    float gray = (.5 * r + .25 * g + .25 * b);
    
    img.pixels[i] = color(gray);
  }
  
  return img;
}//higlightRed







void dots(PImage img, int resolution) {
  noStroke();
  for (int y = 0; y < (img.pixels.length/img.width) - 1; y+= resolution) {
    for (int x = 0; x < img.width - 1; x+= resolution) {
      color c = img.pixels[getIndexFromXY(x, y, img)];
      if (red(c) > (green(c) + blue(c))*0.5) {
        fill(#FA3F19);
      }
      else {
        fill(#0085CF);
      }
      circle(x, y, resolution/2);
    }
  }

}//dots
