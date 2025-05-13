# THE_BIG_PROJECT_SINATRA

## Description
Ce projet est une application web construite avec le framework Sinatra. Elle permet de gérer des "gossips" (potins) et leurs commentaires associés. Les données sont stockées dans des fichiers CSV.

## Structure du projet

### Fichiers principaux
- **`config.ru`** : Fichier de configuration pour démarrer l'application avec Rack. Il charge les dépendances et démarre le contrôleur principal.
- **`Gemfile`** : Liste des dépendances Ruby nécessaires pour le projet, telles que Sinatra, Puma, et Shotgun.
- **`db/`** : Contient les fichiers CSV utilisés pour stocker les données des gossips et des commentaires.
  - `gossip.csv` : Stocke les informations sur les gossips (auteur, contenu, date de dernière mise à jour).
  - `comments.csv` : Stocke les commentaires associés aux gossips (contenu, ID du gossip, date de création).
- **`lib/`** : Contient les classes Ruby et les vues utilisées dans l'application.
  - `gossip.rb` : Classe pour gérer les gossips (création, sauvegarde, récupération).
  - `comment.rb` : Classe pour gérer les commentaires (création, sauvegarde, récupération).
  - `controller.rb` : Contrôleur principal de l'application, gère les routes et la logique métier.
  - `views/` : Contient les fichiers ERB pour les vues HTML.
    - `index.erb` : Page d'accueil affichant tous les gossips.
    - `new_gossip.erb` : Formulaire pour créer un nouveau gossip.
    - `show.erb` : Page pour afficher un gossip spécifique et ses commentaires.
    - `edit.erb` : Formulaire pour modifier un gossip existant.

## Fonctionnalités
- **Afficher tous les gossips** : La page d'accueil liste tous les gossips enregistrés.
- **Créer un gossip** : Un formulaire permet d'ajouter un nouveau gossip.
- **Afficher un gossip spécifique** : Chaque gossip peut être consulté individuellement avec ses commentaires.
- **Ajouter des commentaires** : Les utilisateurs peuvent commenter les gossips.
- **Modifier un gossip** : Les gossips existants peuvent être mis à jour.

## Dépendances
Les dépendances sont gérées via Bundler. Voici les principales :
- `sinatra` : Framework web minimaliste.
- `puma` : Serveur web performant.
- `shotgun` : Rechargement automatique pour le développement.
- `csv` : Manipulation des fichiers CSV.

## Installation
1. Clonez le dépôt.
2. Installez les dépendances avec Bundler :
   ```bash
   bundle install
   ```
3. Lancez l'application avec rackup au port 4567:
    ```bash
    rackup -p 4567
    ```

## Auteurs
- [THIAM](https://github.com/thaliou)
- [ASSY](https://github.com/AssyaJalo)
- [SOUARE](https://github.com/bbkouty)
- [FANAR](https://github.com/fanarbandia)
- [MAIGA](https://github.com/Fadelion)

## Licence
Ce projet est sous licence MIT. Consultez le fichier [LICENSE](./LICENSE) pour plus d'informations.

---
Ce projet a été réalisé dans le cadre de l'apprentissage de `Sinatra`.