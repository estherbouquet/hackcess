PFont mixMonoReg;

void setup() {
  size(500, 900); // taille fenêtre

  mixMonoReg = createFont("TheMixMono-Regular.otf", 100); //on vient charger la typo en corps 100
  textFont(mixMonoReg); //on attribue cette typo au texte
  fill(0); // typo en noir

  message(); //on appelle la fonction message()
}

void draw() {
}

void message() { //fonction message
  String[] Subjects={
    "Marie", "Jules", "Paul", "Alex", "Axel", "Ezra", "Lou"
  }; // on crée un tableau de String qui regroupe tous les prénoms
  String[] Salutations={
    "Hello world", "Hello", "Coucou", "Salut", "Hi", "Salut, ça va ?", "Bonjour"
  }; //on crée un tableau de String qui regroupe toutes les phrases pour la 1re connexion

  int subject = int(random(Subjects.length)); // on crée un int appelé subject qui a une valeur comprise entre 0 et la longueur du tableau
  int salutation = int(random(Salutations.length)); //idem mais avec les phrases  

  String Message = Subjects[subject]+ "\n" +Salutations[salutation]; // on crée un message avec subject+salutation
  println(Message); //on imprime le message dans la console de debug

  background(0); // on rafraîchit le background pour effacer le texte d'avant
  textSize(30); //on choisit le corps 30
  text(Message, 10, 100); // la valeur de text sera le Message créé et sera positionné à x=10 et y=100 
}

void mousePressed() {
  message(); // on relance la fonction à chaque fois qu'on appuie sur la souris 
}