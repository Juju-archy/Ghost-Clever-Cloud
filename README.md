# Template de Blog Ghost sur Clever Cloud

Ce projet est un template de blog Ghost fonctionnant sous Node.js 20 et déployé sur Clever Cloud.

## Prérequis

- **Node.js 20**
- **Ghost-CLI**
- **Clever Tools CLI** ([documentation](https://www.clever-cloud.com/developers/doc/cli/))
- **Git**

## Installation et Configuration

### 1. Initialisation du projet

Créez le dossier du projet et installez Ghost en mode local :
```sh
mkdir myblog && cd myblog
ghost install local
```

Supprimez le thème par défaut et ajoutez les sous-modules pour d'autres thèmes :
```sh
rm -r content/themes/casper
cp -r current/content/themes/casper/ content/themes/
git init
cd content/themes/
git submodule add https://github.com/curiositry/mnml-ghost-theme
git submodule add https://github.com/zutrinken/attila/
```

### 2. Création et configuration sur Clever Cloud

Créez l'application Node.js sur Clever Cloud :
```sh
clever create --type node myblog
```

Créez une base de données MySQL et liez-la à l'application :
```sh
clever addon create mysql-addon --plan s_sml myblogsql
clever service link-addon myblogsql
```

Configurez les variables d'environnement :
```sh
clever env set NODE_ENV production
clever env set CC_PRE_RUN_HOOK ./clevercloud.sh
clever domain add mysuperblog.cleverapps.io
```

### 3. Configuration du script de pré-déploiement

À la racine du projet, créez un fichier `.clevercloud.sh` et ajoutez le code suivant :
```sh
#!/bin/sh
npm install -g ghost-cli # Installe Ghost-CLI sur Clever Cloud
mkdir ghost # Crée un dossier pour l'instance Ghost
cd ghost
ghost install local
ghost stop
cp ../config.production.json . # Copie la configuration de production
```

### 4. Configuration de Ghost

Créez un fichier `config.production.json` à la racine :
```json
{
  "url": "https://<your_app_url>",
  "server": {
    "port": 8080,
    "host": "0.0.0.0"
  },
  "database": {
    "client": "mysql"
  },
  "mail": {
    "transport": "Direct"
  },
  "process": "local",
  "logging": {
    "level": "debug",
    "transports": ["stdout"]
  },
  "paths": {
    "contentPath": "../../../content/"
  }
}
```

Ajoutez les variables d'environnement pour la connexion à la base de données :
```sh
clever env set database__connection__host <ADDON_HOST>
clever env set database__connection__user <ADDON_USER>
clever env set database__connection__password <ADDON_PASSWORD>
clever env set database__connection__database <ADDON_DATABASE>
clever env set database__connection__port <ADDON_PORT>
clever env set url https://<domain_URL_blog>
```

### 5. Création des fichiers nécessaires

Créez un `package.json` minimal :
```json
{
    "name": "ghost",
    "version": "0.1.0",
    "description": "",
    "scripts": {
        "start": "ghost run --dir ghost"
    },
    "devDependencies": {},
    "dependencies": {}
}
```

Ajoutez un fichier `.gitignore` :
```
.ghost-cli
config.development.json
current
versions
```

### 6. Déploiement sur Clever Cloud

Initialisez Git, ajoutez les fichiers et déployez l'application :
```sh
git add clevercloud.sh package.json config.production.json content
git commit -m "Initial commit"
git remote add clever <CLEVER_GIT_URL>
clever deploy
```

## Remarque

Pour un petit blog, les plans XS ou S sont largement suffisants pour l'application Node.js.


