class Portail {
  PVector location;
  float extent;
  boolean active;
  
  color fillColor;
  
  PVector destination;
  
  String text = "";
  
  Portail () {
    location = new PVector(random(150, width - 150), random(150, height - 150));
    active = true;
    extent = 100;
    fillColor = color(random(255), random(255), random(255));
  }
  
  void setDestination(PVector destination) {
    this.destination = destination.copy();
  }
  
  void teleport(Mover m) {
    if (active) {
      if (location.dist(m.location) <= extent / 2) {
        PVector distance = m.location.sub(location);
        distance.mult(-1.2);
        
        m.location = destination.copy();
        m.location.add(distance);
      }
    }
  }
  
  void display() {
    if (active) {
      noStroke();
      fill(fillColor);
      circle(location.x, location.y, extent);
      
      fill(255);
      text(text, location.x + 50, location.y - 50);
    }
  }
  
  void changeState() {
    if (active) {
      active = false;
    } else {
      active = true;
    }
  }
}
