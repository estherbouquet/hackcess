PFont mixMonoReg;
PFont mixMonoXBold;
int x=10;
int y=800;

float angle = 0.00;
float speed = 0.02;

ArrayList<String> messages = new ArrayList();


void setup() {
  size(500, 900); // taille fenêtre
  background(255); //car sinon chargement d'un fond gris pas beau
  mixMonoReg = createFont("TheMixMono-Regular.otf", 25); //on vient charger la typo en corps 100
  mixMonoXBold = createFont("TheMixMono-XBold.otf", 100);  
  textFont(mixMonoReg); //on attribue cette typo au texte
  noCursor();
  message(); //on appelle la fonction message()
  refreshScreen(); // on appelle la fonction refreshScreen()
}

void draw() {

  /*cercle qui simule le chargement*/
  stroke(0, 40); // ! ne marche pas si pas de contour -> pourquoi ? Je ne sais pas
  //noStroke();
  fill(255, 100); // blanc + opacité de 100 
  float d1 = (45 + (sin(angle) * 45))/4; 
  ellipse(width/2, height-18, d1, d1);
  float d2 = (45 + (sin(angle + QUARTER_PI) * 45))/4;
  ellipse(width/2, height-18, d2, d2);
  float d3 = (45 + (sin(angle + HALF_PI) * 45))/4;
  ellipse(width/2, height-18, d3, d3);
  angle += speed;
  
}


void message() { //fonction message()
  String[] Subjects={
    "Marie", "Jules", "Paul", "Alex", "Axel", "Ezra", "Lou", "Tristan", "Quentin", "Léa", "Max"
  }; // on crée un tableau de String qui regroupe tous les prénoms
  String[] Salutations={
    "Hello world", "Hello", "Coucou", "Salut", "Hi", "Salut, ça va ?", "Bonjour"
  }; //on crée un tableau de String qui regroupe toutes les phrases pour la 1re connexion

  int subject = int(random(Subjects.length)); // on crée un int appelé subject qui a une valeur comprise entre 0 et la longueur du tableau
  int salutation = int(random(Salutations.length)); //idem mais avec les phrases  

  String Message = Subjects[subject]+ "\n" +"/"+Salutations[salutation]; // on crée un message avec subject+salutation

  println(Message); //on imprime le message dans la console de debug

  // background(255); // on rafraîchit le background pour effacer le texte d'avant
  textSize(25); //on choisit le corps 30
  fill(0); // on met la typo en noir ! car sinon, même couleur que le cercle, et donc invisible
  messages.add(Message);
  if (messages.size()>20) { //si le nombre total d'éléments dans l'ArrayList est > à 20 éléments
    messages.remove(messages.get(0)); // on ne peut pas lui dire d'enlever le dernier, mais seulement un élement. donc on "contourne" le problème en mettant 0 car 0=1er élément du tableau en partant du haut
  }
}

void refreshScreen() { // fonction refreshScreen()
  background(255);
  int a = x; // on définit la position du message à la base en x
  int b = y; // on définit la position du message à la base en y
  for (int i = messages.size()-1; i >= 0; i--) { //largeur de l'ArrayList messages correspond à (messages.size()). (taille-1) pour qu'on commence par la fin et on décrémente (i--) pour afficher le dernier message entré dans l'ArrayList 
    textAlign(LEFT);
    textFont(mixMonoReg);
    text(messages.get(i), a, b); //text a la valeur "messages.get(i)" et donc s'adapte au niveau du message à afficher en x et en y
    b -= 70; //on change la position en b à chaque fois pour éviter que les messages s'affichent les uns sur les autres
  }

  /*barre du haut*/
  noStroke();
  fill(255);
  rect(0, 0, width, 70);
  textFont(mixMonoXBold);
  fill(0);
  textSize(15);
  textAlign(CENTER);
  text("HACK/CESS", width/2, 20);//on attribue cette typo au texte*/

  /*barre du bas*/
  noStroke();
  fill(0);
  rect(0, 865, width, 35);
}

void mousePressed() {
  message(); // on relance la fonction à chaque fois qu'on appuie sur la souris
  refreshScreen(); // on relance la fonction à chaque fois qu'on appuie sur la souris
}