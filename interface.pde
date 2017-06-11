void topBar() {
   //barre du haut
  noStroke();
  fill(c1);
  rect(0, 0, width, 48);

  textFont(mixMonoReg); //on attribue cette typo au texte
  fill(45,44,50);
  textSize(25);
  textAlign(CENTER);
  text("[HACK:CESS]", width/2, 58);
}

void loadingCircle() {
  // CERCLE QUI SIMULE CHARGEMENT
  stroke(190, 10); // ! ne marche pas si pas de contour -> pourquoi ? Je ne sais pas
  //noStroke();
  fill(45,40,50, 20); // blanc + opacité de 100 
  float d1 = 65 + (sin(angle) * 45);
  ellipse(width/2, 84, d1/5, d1/5);
  float d2 = 65 + (sin(angle + QUARTER_PI) * 45);
  ellipse(width/2, 84, d2/5, d2/5);
  float d3 = 65 + (sin(angle + HALF_PI) * 45);
  ellipse(width/2, 84, d3/5, d3/5);
  angle += speed;
}