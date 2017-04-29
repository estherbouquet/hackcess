PFont mixMonoReg;

void setup(){
  size(500,900);
  
  mixMonoReg = createFont("TheMixMono-Regular.otf", 30);
  textFont(mixMonoReg);
  fill(0);
}

void draw(){
 background(255);
 text("ceci est un  test", 10, 100);
}