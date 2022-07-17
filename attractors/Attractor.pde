class Attractor {

  PVector pos;
  float mag, x, y;
  
  Attractor(float x_, float y_, float mag_) {
    pos = new PVector(x_,y_);
    mag = mag_;
    x = x_;
    y = y_;
  }
  
  void move(float step, float r) {
    pos.x = x + cos(step) * r * map(noise(step),0,1,0.8,1);
    pos.y = y + sin(step) * r * map(noise(step),0,1,0.8,1);
  }
  
  void show() {
    noStroke();
    fill(255,0,0);
    ellipse(pos.x, pos.y, 2, 2);
  }
}
