class Vehicle {

/************************/ 
//    Variables
/************************/ 
PVector location, velocity, acceleration, target;
float maxSpeed, maxForce, r;
color c;

/************************/ 
//    Constructor
/************************/ 
Vehicle(PVector loc, PVector vel, color c_) {
    velocity = vel;
    acceleration = new PVector(0,0);
    location = loc;
    r = 3.0;
    maxSpeed = 20.0;
    maxForce = 0.1;
    c = c_;
}

/************************/ 
//    Update
/************************/ 
void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
}

/************************/ 
//    Apply Force
/************************/ 
void applyForce(PVector force) {
    acceleration.add(force);
}


/************************/ 
//    Seek
/************************/ 

void seek(PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    
    applyForce(steer);
}


/************************/ 
//    Attractor
/************************/ 

void attr(Attractor a) {
    PVector desired = PVector.sub(a.pos, location);
    desired.normalize();
    
    float d = dist(location.x, location.y, a.pos.x, a.pos.y);
    desired.mult(maxSpeed/d * a.mag);
    
    
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    if(d> a.mag) {
      applyForce(steer);
    } else {
      applyForce(steer.mult(-0.5));
    }
    
    if(velocity.mag()< 1) {
      float r = random(vehN);
      float x = width/2 + cos(TWO_PI/vehN * r) * (300 - frameCount*0.1);
      float y = height/2 + sin(TWO_PI/vehN * r) * (300 - frameCount*0.1);
      
      //float x = width/2 + cos(TWO_PI/vehN * r) * (300);
      //float y = height/2 + sin(TWO_PI/vehN * r) * (300);
      location = new PVector(x,y);
    }
}


/************************/ 
//    arrive (seek + rallentamento finale)
/************************/ 
void arrive(PVector target) {
    PVector desired = PVector.sub(target,location);
    float d = desired.mag();
    desired.normalize();
    
    if(d<100) {
        float m = map(d,0,100,0,maxSpeed);
        desired.mult(m);
    } else {
        desired.mult(maxSpeed);
    }
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
}

/************************/ 
//    wandering
/************************/ 
void wandering() {
    PVector desired = PVector.sub(location,location);
    float theta = random(TWO_PI);
    desired.x = desired.x + 100 * sin(theta);
    desired.y = desired.y + 100 * cos(theta);
    float d = desired.mag();
    desired.normalize();    
    if(d<100) {
        float m = map(d,0,100,0,maxSpeed);
        desired.mult(m);
        } else {
        desired.mult(maxSpeed);
    }
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
}


/************************/ 
//    display
/************************/  

void display() {
    float theta = velocity.heading()  + PI/2;
    fill(255);
    noStroke();
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape();
        vertex(0,-r*2);
        vertex(-r,r*2);
        vertex(r,r*2);
        endShape(CLOSE);
    popMatrix();
    }
    
  void draw() {
    stroke(255, 100);
      point(location.x, location.y);
    if(velocity.mag()> 0.5) {
      
    }
    
  }
}
