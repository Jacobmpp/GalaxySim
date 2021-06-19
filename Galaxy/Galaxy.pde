System[] systemArray;
PVector center;
float totalMass = 0;
float zoom = 2;
int speed = 1;
boolean debug = true;
PVector displacement;
int textSize = 30;
void setup() {
  textSize(textSize);
  fullScreen(P2D);
  systemArray = new System[8000];
  center = new PVector(0, 0);
  for (int i = 0; i < systemArray.length; i++) {
    systemArray[i] = new System(
        sqrt(randRadius() + random(16)) / 15 + 
        ((random(0, 1) > .999)? random(60) : 0) + 
        ((random(0, 1) > .995)? 2 : 0), 
      randRadius(), 
      random(PI * 2));
    center.add(systemArray[i].location.copy().mult(systemArray[i].mass));
    totalMass += systemArray[i].mass;
  }
  center.div(totalMass);
  for (int i = 0; i < systemArray.length*300; i++) {
    //ss[i%ss.length].update(center,m);
  }
  frameRate(40);
  displacement = new PVector(width / 2, height / 2);
  background(0);
}
void mouseWheel(MouseEvent event) {
  zoom *= 1 - (pow((float)event.getCount(), 3)) / 100;
  zoom = constrain(zoom, .5, 100);
}
void keyPressed() {
  println(key);
  switch(key) {
  case '\\':
    debug=!debug;
    break;
  case '.':
    speed++;
    break;
  case ',':
    speed--;
    break;
  case '>':
    speed += 5;
    break;
  case '<':
    speed -= 5;
    break;
  case '/':
    speed = 1;
    break;
  }
  if (speed < 0)speed = 0;
}
void draw() {
  background(0, 0, 0);
  strokeWeight(1);
  stroke(255);
  if (debug) {
    text("Speed: " + speed, 0, textSize);
    text("FPS: " + ((float)round(frameRate * 10)) / 10, 0, textSize * 2);
    text("Zoom: " + ((float)round(zoom * 10)) / 10, 0, textSize * 3);
  }
  /*totalMass = 0;
  for (int i = 0; i < ss.length; i++) {
    center.add(ss[i].loc.copy().mult(ss[i].m));
    totalMass+=ss[i].m;
  }
  center.div(totalMass);*/
  if (mousePressed) {
    displacement.x += (mouseX - pmouseX) / zoom;
    displacement.y += (mouseY - pmouseY) / zoom;
    background(0);
  }
  translate(width / 2, height / 2);
  scale(zoom);
  translate(-width / 2, -height / 2);
  translate(displacement.x, displacement.y);
  for (int i = 0; i < systemArray.length * speed; i++) {
    systemArray[i % systemArray.length].update(center, totalMass);
  }
  for (int i = 0; i < systemArray.length; i++) {
    systemArray[i].show();
  }
  marker(color(255, 0, 0), 2, center.x, center.y, debug);
}
float randRadius() {
  return map(log((random(min(width, height) / 2)+1) * 10), 0, log(min(width, height) / 2 * 10 + 10), min(width, height) / 2, 3);
}
void marker(color c, int weight, float x, float y, boolean onOff) {
  if (onOff) {
    marker(c,weight,x,y);
  }
}
void marker(color c, int weight, float x, float y) {
  stroke(c);
  strokeWeight(weight);
  point(x, y);
}
