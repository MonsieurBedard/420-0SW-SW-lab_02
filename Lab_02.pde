int currentTime;
int previousTime;
int deltaTime;

ArrayList<Mover> flock;
int flockSize = 20;

Portail portail1;
Portail portail2;

boolean debug = false;

void setup () {
  //fullScreen(P2D);
  size (800, 600);
  currentTime = millis();
  previousTime = millis();
  
  init();
}

void init() {
  flock = new ArrayList<Mover>();
  
  for (int i = 0; i < flockSize; i++) {
    //Mover m = new Mover(new PVector(random(0, width), random(0, height)), new PVector(random (-2, 2), random(-2, 2)));
    Mover m = new Mover(new PVector(width / 2, height / 2), new PVector(random (-2, 2), random(-2, 2)));
    m.fillColor = color(random(255), random(255), random(255));
    flock.add(m);
  }
  
  boolean ok = false;
  while(!ok) {
    portail1 = new Portail();
    portail2 = new Portail();
  
    if (portail1.location.dist(portail2.location) > 200) {
      ok = true;
    }  
  }
  
  portail1.setDestination(portail2.location);
  portail1.text = "Portail 1";
  portail2.setDestination(portail1.location);
  portail2.text = "Portail 2";
}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update(deltaTime);
  display();  
}

/***
  The calculations should go here
*/
void update(int delta) {
  
  for (Mover m : flock) {
    m.flock(flock);
    m.update(delta);

    portail1.teleport(m);
    portail2.teleport(m);
  }
}

/***
  The rendering should go here
*/
void display () {
  background(0);
  
  for (Mover m : flock) {
    m.display();
  }
  
  portail1.display();
  portail2.display();
}

void keyPressed() {
  switch (key) {
    case 'd':
      flock.get(0).debug = !flock.get(0).debug;
      break;
    case 'r':
      init();
      break;
    case ' ':
      portail1.changeState();
      portail2.changeState();
  }
}

void mouseClicked() {
  Mover m = new Mover(new PVector(mouseX, mouseY), new PVector(random (-2, 2), random(-2, 2)));
  m.fillColor = color(random(255), random(255), random(255));
  flock.add(m);
}
