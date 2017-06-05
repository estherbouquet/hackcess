import java.util.*;

List<String> Subjects = new ArrayList(Arrays.asList(new String[]{
  "Marie", "Lou", "Nina", "Marion", "Lisa", 
  "Anna", "Flo", "Alice", "Emma", "Louise", 
  "Lola", "Lucie", "Eva", "Rose", "Elsa", 
  "Sarah", "Alicia", "Lily", "Luna", "Alix", 
  "Lucas", "Hugo", "Tom", "Sacha", "Eliot", 
  "Jules", "Paul", "Alex", "Axel", "Ezra", 
  "Dorian", "Diego", "Charles", "Max", "Marc", 
  "Will", "Isaac", "Victor", "Sam", "Mathis"
})); // on crée un tableau de String qui regroupe tous les prénoms

String[] Salutations={
  "Hello world", "Hello", "Coucou", "Salut", "Hi", 
  "Salut, ça va ?", "Bonjour", "Eh oh, je suis ici !", "Bon matin :)", "Houston, me recevez vous ?"
}; //on crée un tableau de String qui regroupe toutes les phrases pour la 1re connexion


String[] Deconnexion={
  "Bon, bah, salut.", "Bon vent !", "See you !", "Au revoir.", "Bye bye", 
  "Au plaisir !", "A+", "Tchao !", "Tchouss !"
};

String[] Twitter={
  "#BackOnTwitter", "Bonjour, je voudrais joindre Twitter s'il vous plait !", "Je demande la connexion vers @Twitter", 
  "#HelloTwitter", "Est-ce que je pourrais avoir Twitter ?", "Quels sont les derniers tweets ?", "Salut, je veux Twitter !", 
  "Mon avis tiendra en 140 signes.", "Quoi de neuf dans ma #TL ?", "Going on @Twitter via @hackcess", 
  "Est-ce que j'ai des nouveaux #DM ?", "De nouveaux #RT ?", "#FollowFriday @project_hackcess", "Je souhaiterais actualiser ma #TL !"
}; //on crée un tableau de String qui regroupe toutes les phrases pour connexion à Twitter

String[] Facebook={
  "Je demande la connexion vers www.facebook.com", "Je souhaiterais actualiser ma TimeLine", "Je voudrais charger les notifications s'il vous plait !", 
  "Je voudrais joindre l'URL de Facebook !", "Une nouvelle identification ?", "De nouvelles publications !", "Je peux aller sur Facebook ?",
  "Quoi de neuf sur l'application Facebook ?", "Ok, je lance l'application Facebook", "Est-ce que j'ai de nouveaux amis ?", "Permission requise pour aller sur Facebook",
  "Connexion permise", "Autentification requise !", "Je voudrais charger les derniers posts !"
};

String[] Instagram={
  "Je demande une connexion vers Instagram via l'application !", "Je peux me connecter sur Instagram ?", "Je souhaite me connecter via le port #265", 
  "Je lance l'app Instagram", "Je peux charger les nouvelles storys ?", "#Connexion #Instagram #Soutenance #Smile", "Je souhaite naviguer vers mon compte Instagram", 
  "", "", "", "",
  "", "", "", ""
}; //on crée un tableau de String qui regroupe toutes les phrases pour connexion à Twitter


String[] Meteo={
  "Bon, alors, il fait quel temps ?", "Tu crois vraiment qu'il fait beau ici ?", "Perso, je pense qu'il pleut", 
  "Pas trop chaud ?", "Le temps est au beau fixe ?", "Il fera beau donc ?", "Inutile de checker, il pleut toujours dans la ville d'Inverness..."
};

String[] Information={
  "Quoi de neuf dans le monde ?", "Quelles sont les news du moment ?", "Quelles sont les nouvelles ?", "Quelles sont les informations en ce moment ?", "Connexion aux informations",
  "Quoi de neuf en France ?", "Quelles sont les informations aujourd'hui ?", "Quels sont les derniers articles parus ?", "L'info en direct !", "What's up ?"
};

String[] Google={
  "Lancement d'une nouvelle recherche !", "ras 2", "ras 3", "ras 4", "ras 5", "ras 6",
  "ras 7", "ras 8", "ras 9", "ras 10", "ras 11", "ras 12",
   "ras 13", "ras 14", "ras 15", "ras 16", "ras 17", "ras 18",
};

String[] Mails={
  "Connexion aux serveurs", "Synchronisation avec le serveur en cours", "Est-ce que j'ai de nouveaux mails ?", 
  "Chargement des emails !", "Je voudrais actualiser mes mails maintenant", "Loading data from #2010065", "Une nouvelle notification push ?",
  "De nouveaux emails ?"
};

HashMap<String, String[]> hostnameToSentences = new HashMap<String, String[]>(); // on crée un nouvel objet HashMap<String, String[]>() que l'on va stocker dans hostnameToSentences
HashMap<String, String> ipToSubject = new HashMap<String, String>(); // on crée un nouvel objet HashMap<String, String[]>() que l'on va stocker dans hostnameToSentences