System[] systemArray;
PVector center; //Precalculated center of mass to simplify physics and reduce error
float totalMass = 0; //Sum of all system masses
float zoom = 2; //used for camera movement
float speed = 1; //Modulates simulation speed
boolean debug = true; //Show debug data toggles with '\' key
PVector displacement; //Amount moved by click and drag
int textSize = 30;
void setup() {
  textSize(textSize);
  fullScreen(P2D);
  systemArray = new System[8000];
  center = new PVector(0, 0);
  for (int i = 0; i < systemArray.length; i++) {
    systemArray[i] = new System(randMass(), randRadius(), random(PI * 2));
    center.add(systemArray[i].location.copy().mult(systemArray[i].mass));
    totalMass += systemArray[i].mass;
  }
  center.div(totalMass);
  frameRate(60);
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
    speed *= 2;
    break;
  case '<':
    speed /= 2;
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
  /*totalMass = 0;
  for (int i = 0; i < ss.length; i++) {
    center.add(ss[i].loc.copy().mult(ss[i].m));
    totalMass+=ss[i].m;
  }
  center.div(totalMass);*/
  if (mousePressed) {
    displacement.x += (mouseX - pmouseX) / zoom;
    displacement.y += (mouseY - pmouseY) / zoom;
  }
  camera(0);
  for (int i = 0; i < systemArray.length; i++) {
    for(int j = 0; j < ceil(speed); j++)systemArray[i].update(center, totalMass);
    systemArray[i].show();
  }
  marker(color(255, 0, 0), 2, center.x, center.y, debug);
  //render debug center of mass
  camera(1);
  if (debug) {
    text("Speed: " + ((float)round(speed * 100)) / 100 + " (change with ,.<>/)", 0, textSize);
    text("FPS: " + ((float)round(frameRate * 10)) / 10, 0, textSize * 2);
    text("Zoom: " + ((float)round(zoom * 10)) / 10 + " (scroll)", 0, textSize * 3);
    text("(\\ = toggles debug)", 0, textSize * 4);
  }
}
float randRadius() {
  return map(log((random(min(width, height) / 2)+1) * 10), 0, log(min(width, height) / 2 * 10 + 10), min(width, height) / 2, 3);
}
float randMass() {
  return sqrt(randRadius() + random(16)) / 15 + ((random(0, 1) > .999)? random(60) : 0) + ((random(0, 1) > .995)? 2 : 0);
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
void camera(int mode){//0 to do the camera stuff 1 to switch it back
  translate(displacement.x*(-mode), displacement.y*(-mode));
  translate(width / 2, height / 2);
  scale(zoom*(1-mode)+mode/zoom);
  translate(-width / 2, -height / 2);
  translate(displacement.x*(1-mode), displacement.y*(1-mode));
}
