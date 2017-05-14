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
}; //on crée un tableau de String qui regroupe toutes les phrases pour connexion à Twitter

String[] Facebook={
  "#BackOnFacebook", "Bien le bonjour chers fb", "Facebook, c'est mieux qu'avant", 
  "#TeamFacebook", "#Nouvel ami", "Quels sont mes dernières notificaions ?", "Salut Fb !", 
}; //on crée un tableau de String qui regroupe toutes les phrases pour connexion à Twitter

HashMap<String, String[]> hostnameToSentences = new HashMap<String, String[]>(); // on crée un nouvel objet HashMap<String, String[]>() que l'on va stocker dans hostnameToSentences