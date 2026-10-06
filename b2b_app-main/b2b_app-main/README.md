# 📱 B2B App

![Flutter](https://img.shields.io/badge/Flutter-3.32.4-blue?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.8.1-blue?logo=dart&logoColor=white)

Une application mobile Flutter conçue pour faciliter les commandes entre professionnels (Business-to-Business). Elle permet aux utilisateurs de naviguer dans un catalogue de produits, d'ajouter des articles à un panier, de suivre leurs commandes, et bien plus encore.

## 🚀 Fonctionnalités

- 🔐 Authentification des utilisateurs
- 🛒 Gestion du panier
- 📦 Suivi des commandes (PENDING, CONFIRMED…)
- 🗂 Affichage dynamique des produits
- 🧾 Historique des commandes
- 🎨 Interface responsive et personnalisée

## 🛠️ Technologies utilisées

- `Flutter` – **v3.32.4**
- `Dart`    – **v3.8.1**
- `GetX`    – Gestion d’état, navigation et injection de dépendances
- `flutter_screenutil` – Adaptation responsive à tous les écrans
- `flutter_svg` – Affichage des icônes SVG
- `http` ou `dio` – Pour les appels API

## 📁 Structure du projet

```plaintext
lib/
├── controller/          # Logique métier et GetX Controllers
├── models/              # Modèles de données
├── utils/               # Constantes, couleurs, helpers...
├── view/                # Interface utilisateur
   ├── pages/           # Pages principales (accueil, panier, profil...)
   └── widgets/         # Composants UI réutilisables propres à chaque vue
```

##  Installation

git clone https://github.com/votre-utilisateur/b2b_app.git
cd b2b_app
flutter pub get
flutter run
