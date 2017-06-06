import net.jodah.expiringmap.ExpiringMap;

void setTextSizeFromCursor(int cursor) {
  textSize(abs(cos(cursor)) * (MAXFONT - MINFONT) + MINFONT);  // cf calcul feuille
}

void fetchMessages(ConcurrentLinkedQueue<DetectedTraffic> packets, Map<String, Boolean> recentConnections) {
  DetectedTraffic dt = null;
  
  // Tant qu'il y a des paquets dans la file d'attente
  while ((dt = packets.poll()) != null) {
    String packetKey = dt.src + "@" + dt.identifiedAs;
    if (recentConnections.containsKey(packetKey)) {
      // On a déjà ajouté un message pour ce couple (personne, service) récemment
      // On passe au paquet suivant sans rien faire
      continue;
    }
    
    recentConnections.put(packetKey, true);
    addMessage(dt);
  }
}

void addMessage(DetectedTraffic dt) { //fonction message()

  String messageSubject = ipToSubject.get(dt.src);
  if (messageSubject == null) {
    if (Subjects.size() <= 0) {
      messageSubject = "Jonathan";
    } else {
      int selection = int(random(Subjects.size())); // on crée un int appelé subject qui a une valeur comprise entre 0 et la longueur du tableau
      totalConnexions++;
      println("addMessage - ceci est le nombre de personnes connectées au total :"+totalConnexions);
      messageSubject = Subjects.get(selection); // on crée un messageSubject avec subject
      Subjects.remove(messageSubject);
      ipToSubject.put(dt.src, messageSubject);
    }
  }

  //int salutation = int(random(Salutations.length)); //idem mais avec les bonjour/hello  
  int selectedSentence = int(random(hostnameToSentences.get(dt.identifiedAs).length));  
  //cf feuille ligne décomposée

  String messageSentence = hostnameToSentences.get(dt.identifiedAs)[selectedSentence]; // on crée un messageSentence avec la phrase sélectionnée du tableau correspond au hostname détecté
  
  messagesPart1.add(messageSubject); //on divise le message en 2. Part1=le prénom
  if (messagesPart1.size()>20) { //si le nombre total d'éléments dans l'ArrayList est > à 20 éléments
    messagesPart1.remove(messagesPart1.get(0)); // on ne peut pas lui dire d'enlever le dernier, mais seulement un élement. donc on "contourne" le problème en mettant 0 car 0=1er élément du tableau en partant du haut
  }

  messagesPart2.add(messageSentence); //Part2=la phrase prononcée
  if (messagesPart2.size()>20) { //si le nombre total d'éléments dans l'ArrayList est > à 20 éléments
    messagesPart2.remove(messagesPart2.get(0)); // on ne peut pas lui dire d'enlever le dernier, mais seulement un élement. donc on "contourne" le problème en mettant 0 car 0=1er élément du tableau en partant du haut
  }
  
  println("message "+messageSubject+ " : "+messageSentence);
}

/* 
 * Entrée --> Une string d'une longueur quelconque
 * Sortie <-- Une liste de string dont chaque string tient dans la largeur de la fenêtre
 */
ArrayList<String> splitMessage(String currentMessage) {
  int largeurLigneCourante = messageStartX;
  int lineIndex = 0;
  String[] mots = split(currentMessage, ' ');
  int curseurX = messageStartX;
  int curseurY = messageStartY;
  ArrayList<String> splitMessage = new ArrayList<String>();
  splitMessage.add("");

  textAlign(LEFT);
  textSize(15);
  textFont(mixMonoReg);

  //La gestion du retour à la ligne se fait mot à mot
  for (int indexMots=0; indexMots<mots.length; indexMots++) {
    String currentWord = mots[indexMots] + " ";
    int currentWordLength = 0;
    
    // Pour chaque lettre, on regarde la taille qu'elle prend et on l'ajoute à currentWordLength
    for (int j = 0; j < currentWord.length(); j++) {
      setTextSizeFromCursor(lineIndex);
      currentWordLength += textWidth(currentWord.charAt(j));
      lineIndex++;
    }
    
    largeurLigneCourante += currentWordLength;
    
    // Si notre ligne dépasse, on en rajoute une autre
    if (largeurLigneCourante > FRAMEWIDTH - messageStartX) {
      splitMessage.add("");
      largeurLigneCourante = messageStartX;
      lineIndex = 0;
    }
    
    String newLine = splitMessage.get(splitMessage.size() - 1) + currentWord;
    splitMessage.set(splitMessage.size() - 1, newLine);
  }

  return splitMessage;
}

int displayName(String currentName, int curseurY) {
    textFont(mixMonoXBold);
    textAlign(LEFT);
    text(currentName, messageStartX, curseurY); //text a la valeur "messages.get(i)" et donc s'adapte au niveau du message à afficher en x et en y
    
    return MAXFONT;
}

int displayMessage(ArrayList<String> splitMessage, int curseurY) {
  textAlign(LEFT);
  textSize(15);
  textFont(mixMonoReg);
    
  int curseurX = messageStartX;
  int originalCurseurY = curseurY;
  
  for (String line : splitMessage) {
    for (int i = 0; i < line.length(); i++) {
      setTextSizeFromCursor(i);
      text(line.charAt(i), curseurX, curseurY);
      curseurX += textWidth(line.charAt(i));
    }
    
    curseurX = messageStartX;
    curseurY += MAXFONT;
  }
  
  return curseurY - originalCurseurY;
}