# Rapport de projet : Application Musicale

## Membres du groupe
- Paul Bourdet
- Alexandre Vachez
- Rayan Zelmat

## Description du projet
Nous avons développé une application mobile utilisant le framework Flutter qui permet d'explorer des informations musicales. L'application utilise l'API TheAudioDB pour récupérer des données sur les artistes, albums et titres.

## Fonctionnalités implémentées
- Page d'accueil avec trois onglets (Classements, Recherche, Favoris)
- Affichage des charts (classements iTunes US)
- Recherche d'artistes et d'albums
- Détails d'un artiste avec biographie et liste des albums
- Détails d'un album avec liste des titres
- Ajout/suppression de favoris (artistes et albums)
- Stockage persistant des favoris

## Technologies utilisées
- Flutter pour le développement cross-platform
- Pattern BLoC pour la gestion de l'état
- GoRouter (Navigator 2.0) pour la navigation
- Retrofit pour les requêtes API
- Hive pour le stockage local des favoris
- Dio pour les requêtes HTTP

## Structure du projet
Le projet a été structuré selon une architecture en couches pour faciliter la maintenance :
- api/ : Configuration des clients API
- bloc/ : Gestion de l'état avec BLoC
- data/ : Modèles de données
- repository/ : Couche d'accès aux données
- screens/ : Écrans principaux
- tabs/ : Onglets de la page d'accueil
- utils/ : Utilitaires divers
- widgets/ : Composants réutilisables

## Choix techniques
- BLoC a été choisi pour une gestion d'état efficace et testable
- GoRouter pour bénéficier des fonctionnalités de Navigator 2.0
- Hive pour sa simplicité et ses performances en stockage local
- L'application est orientée portrait uniquement pour les smartphones

## Défis rencontrés
- Gestion des erreurs de l'API TheAudioDB (certains endpoints ne sont plus maintenus)
- Adaptation des données pour respecter le design imposé
- Implémentation de la persistance des favoris
- Gestion des différentes langues pour les descriptions

## Conclusion
Ce projet nous a permis de mettre en pratique nos connaissances en développement mobile Flutter tout en découvrant de nouvelles librairies et patterns de conception. L'architecture mise en place permet une bonne séparation des responsabilités et facilite l'évolution future de l'application.