// TYPOGRAPHIES
PFont mixMonoReg;
PFont mixMonoXBold;

// VARIABLES FLUX DE TEXTE
int x = 10;
int y = 840;

// VARIABLES POUR LE CERCLE
float angle = 0.00;
float speed = 0.04;

//VARIABLES COULEURS
color c2 = color(231, 205, 112); // couleur background
color c1 = color (99, 132, 247); // couleur flux de texte
color c3 = color(255); // couleur [HACK/CESS] + cercle

ArrayList<String> messages = new ArrayList();


void setup() {
  size(500, 900); // taille fenêtre
  background(c1); //car sinon chargement d'un fond gris pas beau

  mixMonoReg = createFont("TheMixMono-Regular.otf", 25); //on vient charger la typo en corps 25
  mixMonoXBold = createFont("TheMixMono-XBold.otf", 25);  // idem
  textFont(mixMonoReg); //on attribue cette typo au texte

  noCursor(); // pas de curseur apparant

  message(); //on appelle la fonction message()
  refreshScreen(); // on appelle la fonction refreshScreen()
}

void draw() {

  // CERCLE QUI SIMULE CHARGEMENT
  stroke(190, 10); // ! ne marche pas si pas de contour -> pourquoi ? Je ne sais pas
  //noStroke();
  fill(c3, 10); // blanc + opacité de 100 
  float d1 = 65 + (sin(angle) * 45);
  ellipse(width/2, 45, d1/5, d1/5);
  float d2 = 65 + (sin(angle + QUARTER_PI) * 45);
  ellipse(width/2, 45, d2/5, d2/5);
  float d3 = 65 + (sin(angle + HALF_PI) * 45);
  ellipse(width/2, 45, d3/5, d3/5);
  angle += speed;
}


void message() { //fonction message()
  String[] Subjects={
    "Marie", "Jules", "Paul", "Alex", "Axel", "Ezra", "Lou", "Tristan", "Quentin", "Léa", "Max", "Ninon", "Marc"
  }; // on crée un tableau de String qui regroupe tous les prénoms
  String[] Salutations={
    "Hello world", "Hello", "Coucou", "Salut", "Hi", "Salut, ça va ?", "Bonjour"
  }; //on crée un tableau de String qui regroupe toutes les phrases pour la 1re connexion

  String[] Twitter={
    "#BackOnTwitter", "Bien le bonjour Twitter", "Twitter c'était mieux avant", "On voit que ça sur Twitter", "#TeamTwitter", "00", "00"
  }; //on crée un tableau de String qui regroupe toutes les phrases pour la 1re connexion

  int subject = int(random(Subjects.length)); // on crée un int appelé subject qui a une valeur comprise entre 0 et la longueur du tableau
  int salutation = int(random(Salutations.length)); //idem mais avec les phrases  

  String Message = Subjects[subject]+ "\n" +"/"+Salutations[salutation]; // on crée un message avec subject+salutation
  println(Message); //on imprime le message dans la console de debug au cas-où

  fill(c2); // on met la couleur du texte car sinon, même couleur que le cercle (conflit)
  messages.add(Message);
  if (messages.size()>20) { //si le nombre total d'éléments dans l'ArrayList est > à 20 éléments
    messages.remove(messages.get(0)); // on ne peut pas lui dire d'enlever le dernier, mais seulement un élement. donc on "contourne" le problème en mettant 0 car 0=1er élément du tableau en partant du haut
  }
}

void refreshScreen() { // fonction refreshScreen()
  background(c1);

  int a = x; // on définit la position du message à la base en x
  int b = y; // on définit la position du message à la base en y
  for (int i = messages.size()-1; i >= 0; i--) { //largeur de l'ArrayList messages correspond à (messages.size()). (taille-1) pour qu'on commence par la fin et on décrémente (i--) pour afficher le dernier message entré dans l'ArrayList 
    textAlign(LEFT);
    textFont(mixMonoXBold);
    text(messages.get(i), a, b); //text a la valeur "messages.get(i)" et donc s'adapte au niveau du message à afficher en x et en y
    b -= 70; //on change la position en b à chaque fois pour éviter que les messages s'affichent les uns sur les autres
  }

  /*barre du haut*/
  noStroke();
  fill(c1);
  rect(0, 0, width, 40);

  textFont(mixMonoReg);
  fill(c3);
  textSize(15);
  textAlign(CENTER);
  text("[HACK/CESS]", width/2, 22);//on attribue cette typo au texte*/

  /*
  //barre du bas
   noStroke();
   fill(0);
   rect(0, 865, width, 35);
   */
}

void mousePressed() {
  message(); // on relance la fonction à chaque fois qu'on appuie sur la souris
  refreshScreen(); // on relance la fonction à chaque fois qu'on appuie sur la souris
}