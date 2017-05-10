// TYPOGRAPHIES
PFont mixMonoReg;
PFont mixMonoXBold;

// TAILLE FENETRE
final int FRAMEWIDTH = 700;
final int FRAMEHEIGHT = 500;

/*On donne les bornes de l'interval dans lequel peut se situer la taille 
 de la police de la seconde partie du message*/
final int MINFONT=35;
final int MAXFONT=40;

// VARIABLES FLUX DE TEXTE
int x = 10;
int y = FRAMEHEIGHT-70-3*MAXFONT;
int e = 5;

// VARIABLES POUR LE CERCLE
float angle = 0.00;
float speed = 0.04;

//VARIABLES COULEURS
color c1 = color (70, 100, 217); // couleur background
color c2 = color(231, 205, 112); // couleur flux de texte
color c3 = color(255); // couleur [HACK/CESS] + cercle

int c2R=231;
int c2G=205;
int c2B=112;

//Jouer avec l'opacité de départ et le facteur de réduction afin d'obtenir l'effet désiré
int c2Alpha=255;
int facteurReductionOpacite=30;


ArrayList<String> messagesPart1 = new ArrayList(); // correspond aux prénoms
ArrayList<String> messagesPart2 = new ArrayList(); // correspond aux phrases écrites


void settings() {
  //On place la fonction size dans settings au lieu de setup afin de pouvoir utiliser des variables comme paramètres
  size(FRAMEWIDTH, FRAMEHEIGHT); // taille fenêtre
}

void setup() {
  String test = "@project_hackcess";
  println(test.length());
  background(c1); //car sinon chargement d'un fond gris pas beau

  mixMonoReg = createFont("TheMixMono-Bold.otf", 20); //on vient charger la typo en corps 20
  mixMonoXBold = createFont("TheMixMono-XBold.otf", 23);  // idem corps 23

  noCursor(); // pas de curseur apparant dans la fenêtre

  loadMessage(); //on appelle la fonction message()
  refreshScreen(); // on appelle la fonction refreshScreen()
}

void scanIP() {
  //println("coucou"); // ce que m'aura filé Quentin
}

void draw() {
  thread("scanIP"); // mettre nom de la fonction pour avoir un thread

  //barre du haut
  noStroke();
  fill(c1);
  rect(0, 0, width, 30);

  textFont(mixMonoReg); //on attribue cette typo au texte
  fill(c3);
  textSize(15);
  textAlign(CENTER);
  text("[HACK/CESS]", width/2, 22);


  // CERCLE QUI SIMULE CHARGEMENT
  stroke(190, 20); // ! ne marche pas si pas de contour -> pourquoi ? Je ne sais pas
  //noStroke();
  fill(c3, 20); // blanc + opacité de 100 
  float d1 = 65 + (sin(angle) * 45);
  ellipse(width/2, 42, d1/5, d1/5);
  float d2 = 65 + (sin(angle + QUARTER_PI) * 45);
  ellipse(width/2, 42, d2/5, d2/5);
  float d3 = 65 + (sin(angle + HALF_PI) * 45);
  ellipse(width/2, 42, d3/5, d3/5);
  angle += speed;
}


void loadMessage() { //fonction message()
  String[] Subjects={
    "Marie", "Lou", "Nina", "Marion", "Lisa", 
    "Anna", "Flo", "Alice", "Emma", "Louise", 
    "Lola", "Lucie", "Eva", "Rose", "Elsa", 
    "Sarah", "Alicia", "Lily", "Luna", "Alix", 
    "Lucas", "Hugo", "Tom", "Sacha", "Eliot", 
    "Jules", "Paul", "Alex", "Axel", "Ezra", 
    "Dorian", "Diego", "Charles", "Max", "Marc", 
    "Will", "Isaac", "Victor", "Sam", "Mathis"

  }; // on crée un tableau de String qui regroupe tous les prénoms

  String[] Salutations={
    "Hello world", "Hello", "Coucou", "Salut", "Hi", 
    "Salut, ça va ?", "Bonjour", "Eh oh, je suis là !"
  }; //on crée un tableau de String qui regroupe toutes les phrases pour la 1re connexion

  String[] Twitter={
    "#BackOnTwitter", "Bien le bonjour chers twittos", "@Twitter, c'est mieux qu'avant", 
    "#TeamTwitter", "#FollowBack ?", "Quels sont les derniers #TT ?", "Salut Twitter !", 
    "Mon avis tient en 140 signes.", "Quoi de neuf dans ma #TL ?", "Going on @Twitter via @hackcess", 
    "On peut se parler par #DM", "Oh, un nouveau #RT", "#FF @project_hackcess", "J'actualise en ce moment ma #TL"
  }; //on crée un tableau de String qui regroupe toutes les phrases pour la 1re connexion

  int subject = int(random(Subjects.length)); // on crée un int appelé subject qui a une valeur comprise entre 0 et la longueur du tableau
  int salutation = int(random(Salutations.length)); //idem mais avec les bonjour/hello  
  int twitter = int(random(Twitter.length));

  String messageSubject = Subjects[subject]; // on crée un messageSubject avec subject
  println(subject+ " " +messageSubject); //on imprime le message dans la console de debug au cas-où
  String messageSentence = "« "+Twitter[twitter]+" »"; // on crée un messageSentence avec twitter
  println(messageSentence);

  messagesPart1.add(messageSubject); //on divise le message en 2. Part1=le prénom
  if (messagesPart1.size()>15) { //si le nombre total d'éléments dans l'ArrayList est > à 20 éléments
    messagesPart1.remove(messagesPart1.get(0)); // on ne peut pas lui dire d'enlever le dernier, mais seulement un élement. donc on "contourne" le problème en mettant 0 car 0=1er élément du tableau en partant du haut
  }

  messagesPart2.add(messageSentence); //Part2=la phrase prononcée
  if (messagesPart2.size()>15) { //si le nombre total d'éléments dans l'ArrayList est > à 20 éléments
    messagesPart2.remove(messagesPart2.get(0)); // on ne peut pas lui dire d'enlever le dernier, mais seulement un élement. donc on "contourne" le problème en mettant 0 car 0=1er élément du tableau en partant du haut
  }
}

void refreshScreen() { // fonction refreshScreen()
  fill(c1);
  noStroke();
  rect(0, 30, width, height-30);//Refresh l'écran sans masquer le rond du haut

  int a = x; // on définit la position du message à la base en x
  int b = y; // on définit la position du message à la base en y
  /*int c = x+PADDING;
   int d = b+26;*/

  for (int i = messagesPart1.size()-1; i>=0; i--) {//Un seul index (i) car Part1 et Part2 ont la même taille (logiquement)
    String currentName = messagesPart1.get(i);
    textFont(mixMonoXBold);
    textAlign(LEFT);
    color c2 = color(c2R, c2G, c2B, c2Alpha+facteurReductionOpacite*(i-messagesPart1.size()-1)); 
    fill(c2); // on met la couleur du texte car sinon, même couleur que le cercle (conflit)
    text(currentName, a, b); //text a la valeur "messages.get(i)" et donc s'adapte au niveau du message à afficher en x et en y
    //Ici nous avons affiché le prénom, il faut maintenant afficher la deuxième partie du message

    a=x;//On remet a au bord de la fenêtre pour écrire le message
    b +=MAXFONT; //On descend b pour écrire le message en dessous du prénom
    String currentMessage = messagesPart2.get(i);//On récupère le message associé au prénom
    textAlign(LEFT);
    textSize(15);
    textFont(mixMonoReg);
    //fill(c2); // on met la couleur du texte car sinon, même couleur que le cercle (conflit)
    //text(messagesPart2.get(i), c, d); //text a la valeur "messages.get(i)" et donc s'adapte au niveau du message à afficher en x et en y

    //On affiche ici le message caractère par caractère
    int largeurLigneCourante = x;
    //On découpe le message courant mot à mot
    String[] mots = split(currentMessage, ' ');
    
    int nbLine=2;//Compte le nombre de ligne que comporte le message courrant
    
    //La gestion du retour à la ligne se fait mot à mot
    for (int indexMots=0; indexMots<mots.length; indexMots++) {
      String currentWord = mots[indexMots];
      //Si le mot ne peut tenir sur la ligne on en change
      if (largeurLigneCourante + currentWord.length()*MAXFONT > FRAMEWIDTH - x) {
        largeurLigneCourante = x;
        a=x;
        b+=MAXFONT;//On descend b si une deuxième ligne est nécessaire
        nbLine++;
      }

      for (int j = 0; j < currentWord.length(); j++) {
        textSize(random(MINFONT, MAXFONT));  
        largeurLigneCourante += textWidth(currentWord.charAt(j));    
        text(currentWord.charAt(j), a, b); // text("Ceci est mon texte", x, y);
        // textWidth() spaces the characters out properly.
        a += textWidth(currentWord.charAt(j));
      }
      //On a perdu les espaces lors du split, il faut donc les gérer à la main
      if (indexMots!=0 && indexMots !=mots.length-2) {
        text(' ', a, b);
        a+= textWidth(' ');
        largeurLigneCourante+= textWidth(' ');
      }
    }
    //Ici nous avons écrit la deuxième partie du message

    //Nous devons maintenant remonter le curseur et le réaligner afin d'écire le message précédent
    a=x;
    //Gerer espacement inter message
    /* si il n'y à qu'un seul message on ne fait rien*/
    if(messagesPart1.size()==1){
    }
    //Si i est le dernier élement de la liste on ne fait rien
    else if(i==0){ 
    }
    
    else{
      int nbLineSpace=0;
      if(((messagesPart2.get(i-1).length()+2)*MAXFONT)/FRAMEWIDTH > 1){
        nbLineSpace=2;
      }
      else{
        nbLineSpace=1;
      }
      b-=(nbLine+nbLineSpace+1)*MAXFONT;
      if(i==messagesPart2.size()-1 && messagesPart2.size()>2){
        println("divison :"+((messagesPart2.get(i-1).length()+2)*MAXFONT)/FRAMEWIDTH);
        println("espacement :"+ (nbLine+nbLineSpace+1));
      }
    } 
  }


  //barre du bas
  noStroke();
  fill(c2);
  rect(0, height-20, width, 20);
}

void mousePressed() {
  loadMessage(); // on relance la fonction à chaque fois qu'on appuie sur la souris
  refreshScreen(); // on relance la fonction à chaque fois qu'on appuie sur la souris
}