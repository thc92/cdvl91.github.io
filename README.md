# Site du CDVL91

Ce site est construit grâce à [Jekyll](https://jekyllrb.com/), et peut être hébergé n'importe où, il ne dépend d'aucune
fonctionnalité côté serveur pour fonctionner (pas besoin de PHP ni d'une base de donnée).

Pour modifier ce site, éditez les fichiers ou ajoutez-en de nouveaux.  
Il est possible d'écrire directement en HTML ou en [Markdown](https://www.markdowntutorial.com/fr) (plus simple).  
Il est seulement nécessaire de choisir l'extension de fichier (_.html_ ou _.md_) pour choisir un format.

Il existe des éditeurs capables d'afficher le style de rendu instantanément, par exemple:
[Remarkable](https://remarkableapp.github.io/).

Il est préférable d'héberger les contenus lourds (image et vidéo) sur des plateformes tierces pérennes (eg: google drive).

## Écrire un article

Choisissez une catégorie (dossier *action_feminine*, *evenements*, *formations*, *jeunesse* ou *sorties*).
Dans le sous dossier `_posts` créez un fichier pour votre article, le nom du fichier doit obéir à un format spécifique :

`YYYY-MM-DD-nom-article.(md|html)`

* YYYY année en 4 chiffres, exemple: 2021
* MM mois en 2 chiffres, exemple: 05 pour mai
* DD jour en 2 chiffres, exemple: 02 pour le 2 du mois

La date est uniquement utilisée pour trier les articles.

exemple: *jeunesse/_posts/2021-10-17-stage-jeunes-clecy.md*

Au début du fichier, insérez le cartouche qui contient le titre, la date, l'auteur et la vignette à utiliser.

Pour la vignette n'importe quelle largeur peut être utilisée, mais une hauteur de 400px mini permet un meilleur rendu sur les écrans High DPI.

exemple:
```yaml
---
layout: post
title: Les jeunes à Clécy
date: '2021-10-17T12:30:00.000+02:00'
author: Les lycéens des lycées Rosa Parks de Montgeron et Robert Doisneau de Corbeil
thumbnail: jeunesse/clecy_2021_tn.jpg
---
```

## Écrire une nouvelle

Dans le dossier `_news` créez un fichier pour votre nouvelle, le nom de ce fichier doit obéir au même format que celui
des articles.

À noter que la date est utilisée pour trier les nouvelles, et les passer dans les anciennes nouvelles une fois cette
date passée.

exemple: *_news/2020-03-15-AG-CDVL91.html*

Au début du fichier, insérez le cartouche qui contient le titre.

exemple:
```yaml
---
title: Assemblée générale du CDVL91 2020
---
```

## Fichiers notables

* `_config.yml` configuration du site (titres, URL racine, ...)
* `_data/clubs.yml` annuaire des clubs
* `_data/ecoles.yml` annuaire des écoles
* `_data/comite.yml` membres du bureau

## Détails techniques

### Utilisation

Installez [Jekyll](https://jekyllrb.com/), plusieurs commandes sont possibles à la racine du projet :
* `jekyll build` pour construire le site en HTML dans le dossier *_site*
* `jekyll serve` pour servir le site en local à l'adresse http://127.0.0.1:4000

La commande `jekyll serve` maintient le site à jour des modifications sans avoir à relancer la commande, on peut voir ses
modifications en temps réel dès qu'on les sauvegarde sur disque.

### CDN

Pour l'hébergement des images/vidéos, il est possible d'utiliser un CDN, l'URL racine du service doit être renseignée
dans la variable `static:` dans le fichier de configuration `_config.yml`.

Ensuite les liens dans les posts doivent être préfixé avec `{{ site.static }}`, par exemple
`![]({{ site.static }}/jeunesse/clecy_2021_tn.jpeg)`

À noter que pour les vignettes, tous les liens ne commençant pas par `http` sont automatiquement préfixés avec l'URL
racine du CDN.

