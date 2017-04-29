PFont mixMonoReg;
int x=10;
int y=800;

ArrayList<String> messages = new ArrayList();


void setup() {
  size(500, 900); // taille fenêtre
  background(255);
  mixMonoReg = createFont("TheMixMono-Regular.otf", 100); //on vient charger la typo en corps 100
  textFont(mixMonoReg); //on attribue cette typo au texte
  fill(0); // typo en noir

  message(); //on appelle la fonction message()
  refreshScreen();
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

  String Message = Subjects[subject]+ "\n" +"\""+Salutations[salutation]+"\""; // on crée un message avec subject+salutation

  println(Message); //on imprime le message dans la console de debug

  // background(255); // on rafraîchit le background pour effacer le texte d'avant
  textSize(30); //on choisit le corps 30
  messages.add(Message);
  if (messages.size()>20) {
    messages.remove(messages.get(0)); // on ne peut pas lui dire d'enlever le dernier, mais seulement un élement. 0=1er élément du tableau en partant du haut
  }
}

void refreshScreen() {
  background(255);
  int a = x;
  int b = y;
  for (int i = messages.size()-1; i >= 0; i--) { //largeur de l'ArrayList=(.size()) et on décrémente pour afficher le dernier message entré dans l'ArrayList 
    text(messages.get(i), a, b); //text a la valeur "messages.get(i)" et donc s'adapte
    b -= 80;
  }
}

void mousePressed() {
  message(); // on relance la fonction à chaque fois qu'on appuie sur la souris
  refreshScreen();
}