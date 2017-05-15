import java.util.concurrent.ConcurrentLinkedQueue;

// TYPOGRAPHIES
PFont mixMonoReg;
PFont mixMonoXBold;

// TAILLE FENETRE
final int FRAMEWIDTH = 700;
final int FRAMEHEIGHT = 900;

/*On donne les bornes de l'intervalle dans lequel peut se situer la taille 
 de la police de la seconde partie du message*/
final int MINFONT=30;
final int MAXFONT=40;

// VARIABLES FLUX DE TEXTE
int messageStartX = 10;
int messageStartY = FRAMEHEIGHT-70-2*MAXFONT;
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

ConcurrentLinkedQueue<DetectedTraffic> Packets;

void settings() {
  //On place la fonction size dans settings au lieu de setup afin de pouvoir utiliser des variables comme paramètres
  size(FRAMEWIDTH, FRAMEHEIGHT); // taille fenêtre
}

void setup() {
  Packets = new ConcurrentLinkedQueue<DetectedTraffic>();
  hostnameToSentences.put("twitter", Twitter);
  hostnameToSentences.put("facebook", Facebook);
  hostnameToSentences.put("google", Twitter);
  
  String test = "@project_hackcess";
  println(test.length());
  background(c1); //car sinon chargement d'un fond gris pas beau

  mixMonoReg = createFont("TheMixMono-Bold.otf", 20); //on vient charger la typo en corps 20
  mixMonoXBold = createFont("TheMixMono-XBold.otf", 23);  // idem corps 23

  noCursor(); // pas de curseur apparant dans la fenêtre
  
  thread("capture"); // mettre nom de la fonction pour avoir un thread
  thread("resolver");
}

void draw() {
  DetectedTraffic dt = Packets.poll();
  if (dt != null) {
    addMessage(dt);
  }
  
  topBar();
  loadingCircle();
  displayMessages(); 
}

void displayMessages() { // fonction refreshScreen()
  fill(c1);
  noStroke();
  rect(0, 30, width, height-30);//Refresh l'écran sans masquer le rond du haut

  int blocMessagePosition = messageStartY; // on définit la position du message à la base en y

  for (int i = messagesPart1.size()-1; i>=0 && blocMessagePosition>=0; i--) {//Un seul index (i) car Part1 et Part2 ont la même taille (logiquement)
    int messageShiftY = 0;
    
    // Définition de la couleur + opacité
    color c2 = color(c2R, c2G, c2B, c2Alpha+facteurReductionOpacite*(i-messagesPart1.size()-1)); 
    fill(c2); // on met la couleur du texte car sinon, même couleur que le cercle (conflit)
    
    String currentName = messagesPart1.get(i);
    messageShiftY += displayName(currentName, blocMessagePosition);
    
    String currentMessage = messagesPart2.get(i);//On récupère le message associé au prénom
    ArrayList<String> splitMessage = splitMessage(currentMessage);
    messageShiftY += displayMessage(splitMessage, blocMessagePosition + messageShiftY);
    
    //Ici nous avons écrit la deuxième partie du message
    
    if (i == 0) continue;
    //Repositionne le curseur blocMessagePosition
    //         taille prochain nom + taille prochain message (nombre de lignes * MAXFONT) + une demi ligne vide
    blocMessagePosition -= MAXFONT + MAXFONT * splitMessage(messagesPart2.get(i-1)).size() + MAXFONT * 0.5;
  }

  //barre du bas
  noStroke();
  fill(c2);
  rect(0, height-20, width, 20);
}