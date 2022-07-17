ArrayList<Attractor> attractors;
ArrayList<Vehicle> vehicles;
int attrN, vehN;
float step;
boolean start;

void setup() {
    size(800,800);
    attrN = 8;
    vehN = 120;
    attractors = new ArrayList<Attractor>();
    vehicles = new ArrayList<Vehicle>();
    step = 0.01;
    start = false;
    
    for(int i = 1; i<attrN; i++) {

      //float x = width/2 + randomGaussian() * 300;
      //float y = height/2 + randomGaussian() * 300;
      //attractors.add(new Attractor(x,y, random(300)));
    }

    
    for(int i = 0; i<vehN; i++) {
      float x = width/2 + cos(TWO_PI/vehN * i) * 300;
      float y = height/2 + sin(TWO_PI/vehN * i) * 300;
      vehicles.add(new Vehicle(new PVector(x,y), new PVector(0,0), color(255,255,0)));
    }
    
    background(0); 
}

void draw() {
    
  for(Attractor a : attractors) {
    //a.move(step, a.mag);
    a.show();
    
    if(start) {
      for(Vehicle v : vehicles) {
        v.attr(a);
      }
    }
  }

  for(Vehicle v : vehicles) {
    v.update();
    v.draw();
  }


  step+=0.01;
  
}

void mousePressed() {
   start = true;
   attractors.add(new Attractor(mouseX, mouseY, random(300)));
}
