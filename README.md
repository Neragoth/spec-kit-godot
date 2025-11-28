<div align="center">
    <img src="./media/logo_small.webp" alt="Spec Kit Logo"/>
    <h1>🌱 Spec Kit</h1>
    <h3><em>Construisez des logiciels de haute qualité plus rapidement.</em></h3>
</div>

<p align="center">
    <strong>Une boîte à outils open source qui vous permet de vous concentrer sur les scénarios produits et des résultats prévisibles au lieu de coder chaque pièce à partir de zéro au feeling.</strong>
</p>

<p align="center">
    <a href="https://github.com/github/spec-kit/actions/workflows/release.yml"><img src="https://github.com/github/spec-kit/actions/workflows/release.yml/badge.svg" alt="Release"/></a>
    <a href="https://github.com/github/spec-kit/stargazers"><img src="https://img.shields.io/github/stars/github/spec-kit?style=social" alt="GitHub stars"/></a>
    <a href="https://github.com/github/spec-kit/blob/main/LICENSE"><img src="https://img.shields.io/github/license/github/spec-kit" alt="License"/></a>
    <a href="https://github.github.io/spec-kit/"><img src="https://img.shields.io/badge/docs-GitHub_Pages-blue" alt="Documentation"/></a>
</p>

---

## Table des Matières

- [🤔 Qu'est-ce que le Développement Piloté par les Spécifications ?](#-quest-ce-que-le-développement-piloté-par-les-spécifications-)
- [⚡ Commencer](#-commencer)
- [🎮 Support Godot](#-support-godot)
- [📽️ Aperçu Vidéo](#️-aperçu-vidéo)
- [🤖 Agents IA Supportés](#-agents-ia-supportés)
- [🔧 Référence Specify CLI](#-référence-specify-cli)
- [📚 Philosophie Centrale](#-philosophie-centrale)
- [🌟 Phases de Développement](#-phases-de-développement)
- [🎯 Objectifs Expérimentaux](#-objectifs-expérimentaux)
- [🔧 Prérequis](#-prérequis)
- [📖 En Savoir Plus](#-en-savoir-plus)
- [📋 Processus Détaillé](#-processus-détaillé)
- [🔍 Dépannage](#-dépannage)
- [👥 Mainteneurs](#-mainteneurs)
- [💬 Support](#-support)
- [🙏 Remerciements](#-remerciements)
- [📄 Licence](#-licence)

## 🤔 Qu'est-ce que le Développement Piloté par les Spécifications ?

Le Développement Piloté par les Spécifications (Spec-Driven Development) **renverse le scénario** du développement logiciel traditionnel. Pendant des décennies, le code a été roi — les spécifications n'étaient que des échafaudages que nous construisions et jetions une fois le "vrai travail" de codage commencé. Le Développement Piloté par les Spécifications change cela : **les spécifications deviennent exécutables**, générant directement des implémentations fonctionnelles plutôt que de simplement les guider.

## ⚡ Commencer

### 1. Installer Specify CLI

Choisissez votre méthode d'installation préférée :

#### Option 1 : Installation Persistante (Recommandée)

Installez une fois et utilisez partout :

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

**Depuis un dépôt local (pour le développement) :**

Si vous avez cloné le dépôt, vous pouvez installer l'outil directement depuis le dossier racine :

```bash
uv tool install .
```

Puis utilisez l'outil directement :

```bash
specify init <NOM_DU_PROJET>
specify check
```

Pour mettre à jour Specify, voir le [Guide de Mise à Jour](./docs/upgrade.md) pour des instructions détaillées. Mise à jour rapide :

```bash
uv tool install specify-cli --force --from git+https://github.com/github/spec-kit.git
# Ou depuis le local :
uv tool install . --force
```

#### Option 2 : Utilisation Unique

Exécutez directement sans installer :

```bash
uvx --from git+https://github.com/github/spec-kit.git specify init <NOM_DU_PROJET>
```

**Avantages de l'installation persistante :**

- L'outil reste installé et disponible dans le PATH
- Pas besoin de créer des alias shell
- Meilleure gestion de l'outil avec `uv tool list`, `uv tool upgrade`, `uv tool uninstall`
- Configuration shell plus propre

### 2. Établir les principes du projet

Lancez votre assistant IA dans le répertoire du projet. Les commandes `/speckit.*` sont disponibles dans l'assistant.

Utilisez la commande **`/speckit.constitution`** pour créer les principes directeurs et les directives de développement de votre projet qui guideront tout le développement ultérieur.

```bash
/speckit.constitution Créer des principes axés sur la qualité du code, les normes de test, la cohérence de l'expérience utilisateur et les exigences de performance
```

### 3. Créer la spécification

Utilisez la commande **`/speckit.specify`** pour décrire ce que vous voulez construire. Concentrez-vous sur le **quoi** et le **pourquoi**, pas sur la pile technologique.

```bash
/speckit.specify Construire une application qui peut m'aider à organiser mes photos dans des albums séparés. Les albums sont regroupés par date et peuvent être réorganisés par glisser-déposer sur la page principale. Les albums ne sont jamais dans d'autres albums imbriqués. Dans chaque album, les photos sont prévisualisées dans une interface type tuiles.
```

### 4. Créer un plan d'implémentation technique

Utilisez la commande **`/speckit.plan`** pour fournir votre pile technologique et vos choix d'architecture.

```bash
/speckit.plan L'application utilise Vite avec un nombre minimal de bibliothèques. Utiliser HTML, CSS et JavaScript vanilla autant que possible. Les images ne sont téléchargées nulle part et les métadonnées sont stockées dans une base de données SQLite locale.
```

### 5. Décomposer en tâches

Utilisez **`/speckit.tasks`** pour créer une liste de tâches actionnables à partir de votre plan d'implémentation.

```bash
/speckit.tasks
```

### 6. Exécuter l'implémentation

Utilisez **`/speckit.implement`** pour exécuter toutes les tâches et construire votre fonctionnalité selon le plan.

```bash
/speckit.implement
```

Pour des instructions détaillées étape par étape, voir notre [guide complet](./spec-driven.md).

## 🎮 Support Godot

Spec Kit supporte désormais le développement de jeux avec **Godot 4.5.1** avec une architecture professionnelle de niveau AAA!

Pour initialiser un projet Godot avec une architecture data-driven stricte :

```bash
specify init mon-jeu-godot --godot
```

Cette commande configure automatiquement votre projet avec des templates avancés spécialisés pour le développement de jeux :

### 📋 Templates de Spécification

*   **Spécifications de Jeu (GDD)** : Scénarios de gameplay testables, mécaniques data-driven, métriques de performance
*   **Plans d'Implémentation Godot** : Architecture complète avec classes abstraites, Resources, Components, State Machines, Services
*   **Workflow de Tâches** : 7 phases détaillées (Core → Data → Visuals → Components → States → Logic → Tests → Polish)

### 💻 Templates de Code GDScript

*   **Classes Abstraites** : Utilise `@abstract` (Godot 4.5.1) pour contrats stricts
*   **Resources** : Template data-driven avec validation `_validate_property()`
*   **Components** : Pattern composition avec responsabilité unique
*   **States** : Pour State Machines (enter/exit/update/physics_update)
*   **Services** : Singletons/Service Locator pour systèmes globaux

Tous les templates incluent :
*   Organisation avec `#region` (Godot 4.5.1)
*   Commentaires et DocStrings en **français**
*   Standards de code stricts (nommage, anti-patterns)
*   Checklist de conformité qualité

### 🏗️ Architecture Professionnelle

L'architecture promue suit les standards de l'industrie du jeu vidéo :

*   **100% Data-Driven** : Toutes les données configurables dans des Resources (.tres), zéro hard-coding
*   **Composition Over Inheritance** : Components réutilisables, hiérarchies plates
*   **Design Patterns** : Component, State Machine, Observer (EventBus), Service Locator, Object Pooling
*   **Découplage Fort** : Communication via Signaux et Services
*   **Testabilité** : Tests GUT, injection de dépendances

### 📚 Documentation Incluse

*   **Coding Standards** : Conventions strictes (nommage, `#region`, commentaires français)
*   **Architecture Guide** : Structure projet, patterns, flux de données, optimisations

Consultez les guides dans `templates/godot/` pour des exemples complets et les meilleures pratiques.

## 📽️ Aperçu Vidéo

Voulez-vous voir Spec Kit en action ? Regardez notre [aperçu vidéo](https://www.youtube.com/watch?v=a9eR1xsfvHg&pp=0gcJCckJAYcqIYzv) !

[![En-tête vidéo Spec Kit](/media/spec-kit-video-header.jpg)](https://www.youtube.com/watch?v=a9eR1xsfvHg&pp=0gcJCckJAYcqIYzv)

## 🤖 Agents IA Supportés

| Agent                                                     | Support | Notes                                             |
|-----------------------------------------------------------|---------|---------------------------------------------------|
| [Amazon Q Developer CLI](https://aws.amazon.com/developer/learning/q-developer-cli/) | ⚠️ | Amazon Q Developer CLI [ne supporte pas](https://github.com/aws/amazon-q-developer-cli/issues/3064) les arguments personnalisés pour les commandes slash. |
| [Amp](https://ampcode.com/)                               | ✅ | |
| [Auggie CLI](https://docs.augmentcode.com/cli/overview)   | ✅ |                                                   |
| [Claude Code](https://www.anthropic.com/claude-code)      | ✅ |                                                   |
| [CodeBuddy CLI](https://www.codebuddy.ai/cli)             | ✅ |                                                   |
| [Codex CLI](https://github.com/openai/codex)              | ✅ |                                                   |
| [Cursor](https://cursor.sh/)                              | ✅ |                                                   |
| [Gemini CLI](https://github.com/google-gemini/gemini-cli) | ✅ |                                                   |
| [GitHub Copilot](https://code.visualstudio.com/)          | ✅ |                                                   |
| [IBM Bob](https://www.ibm.com/products/bob)               | ✅ | Agent basé sur IDE avec support des commandes slash |
| [Jules](https://jules.google.com/)                        | ✅ | |
| [Kilo Code](https://github.com/Kilo-Org/kilocode)         | ✅ |                                                   |
| [opencode](https://opencode.ai/)                          | ✅ |                                                   |
| [Qwen Code](https://github.com/QwenLM/qwen-code)          | ✅ |                                                   |
| [Roo Code](https://roocode.com/)                          | ✅ |                                                   |
| [SHAI (OVHcloud)](https://github.com/ovh/shai)            | ✅ | |
| [Windsurf](https://windsurf.com/)                         | ✅ |                                                   |

## 🔧 Référence Specify CLI

La commande `specify` supporte les options suivantes :

### Commandes

| Commande    | Description                                                    |
|-------------|----------------------------------------------------------------|
| `init`      | Initialiser un nouveau projet Specify à partir du dernier modèle |
| `check`     | Vérifier les outils installés (`git`, `claude`, `gemini`, `code`/`code-insiders`, `cursor-agent`, `windsurf`, `qwen`, `opencode`, `codex`, `shai`) |

### Arguments & Options `specify init`

| Argument/Option        | Type     | Description                                                                  |
|------------------------|----------|------------------------------------------------------------------------------|
| `<nom-du-projet>`      | Argument | Nom pour votre nouveau répertoire de projet (optionnel si utilisation de `--here`, ou utilisez `.` pour le répertoire courant) |
| `--ai`                 | Option   | Assistant IA à utiliser : `claude`, `gemini`, `copilot`, `cursor-agent`, `qwen`, `opencode`, `codex`, `windsurf`, `kilocode`, `auggie`, `roo`, `codebuddy`, `amp`, `shai`, `q`, ou `bob` |
| `--script`             | Option   | Variante de script à utiliser : `sh` (bash/zsh) ou `ps` (PowerShell)                 |
| `--godot`              | Option   | Initialiser avec les modèles de développement de jeu Godot (Nouveau !) |
| `--ignore-agent-tools` | Flag     | Ignorer les vérifications des outils d'agent IA comme Claude Code                             |
| `--no-git`             | Flag     | Ignorer l'initialisation du dépôt git                                          |
| `--here`               | Flag     | Initialiser le projet dans le répertoire courant au lieu d'en créer un nouveau   |
| `--force`              | Flag     | Forcer la fusion/l'écrasement lors de l'initialisation dans le répertoire courant (ignorer la confirmation) |
| `--skip-tls`           | Flag     | Ignorer la vérification SSL/TLS (non recommandé)                                 |
| `--debug`              | Flag     | Activer la sortie de débogage détaillée pour le dépannage                            |
| `--github-token`       | Option   | Jeton GitHub pour les requêtes API (ou définir la variable d'env GH_TOKEN/GITHUB_TOKEN)  |

### Exemples

```bash
# Initialisation de projet basique
specify init mon-projet

# Initialisation de projet Godot
specify init mon-jeu --godot

# Initialiser avec un assistant IA spécifique
specify init mon-projet --ai claude

# Initialiser avec le support Cursor
specify init mon-projet --ai cursor-agent
```

### Commandes Slash Disponibles

Après avoir exécuté `specify init`, votre agent de codage IA aura accès à ces commandes slash pour le développement structuré :

#### Commandes Principales

Commandes essentielles pour le workflow de Développement Piloté par les Spécifications :

| Commande                 | Description                                                           |
|--------------------------|-----------------------------------------------------------------------|
| `/speckit.constitution`  | Créer ou mettre à jour les principes directeurs et directives de développement du projet |
| `/speckit.specify`       | Définir ce que vous voulez construire (exigences et user stories)        |
| `/speckit.plan`          | Créer des plans d'implémentation technique avec votre pile technologique choisie     |
| `/speckit.tasks`         | Générer des listes de tâches actionnables pour l'implémentation                     |
| `/speckit.implement`     | Exécuter toutes les tâches pour construire la fonctionnalité selon le plan         |

#### Commandes Optionnelles

Commandes supplémentaires pour une qualité et une validation améliorées :

| Commande             | Description                                                           |
|----------------------|-----------------------------------------------------------------------|
| `/speckit.clarify`   | Clarifier les zones sous-spécifiées (recommandé avant `/speckit.plan` ; anciennement `/quizme`) |
| `/speckit.analyze`   | Analyse de cohérence et de couverture inter-artefacts (exécuter après `/speckit.tasks`, avant `/speckit.implement`) |
| `/speckit.checklist` | Générer des checklists de qualité personnalisées qui valident l'exhaustivité, la clarté et la cohérence des exigences |

### Variables d'Environnement

| Variable         | Description                                                                                    |
|------------------|------------------------------------------------------------------------------------------------|
| `SPECIFY_FEATURE` | Remplacer la détection de fonctionnalité pour les dépôts non-Git. Définir sur le nom du répertoire de la fonctionnalité (par ex., `001-albums-photos`) pour travailler sur une fonctionnalité spécifique sans utiliser les branches Git.<br/>**Doit être défini dans le contexte de l'agent avec lequel vous travaillez avant d'utiliser `/speckit.plan` ou les commandes suivantes. |

## 📚 Philosophie Centrale

Le Développement Piloté par les Spécifications est un processus structuré qui met l'accent sur :

- **Le développement piloté par l'intention** où les spécifications définissent le "*quoi*" avant le "*comment*"
- **La création de spécifications riches** utilisant des garde-fous et des principes organisationnels
- **Le raffinement en plusieurs étapes** plutôt que la génération de code en une seule fois à partir de prompts
- **Une forte dépendance** aux capacités avancées des modèles IA pour l'interprétation des spécifications

## 🌟 Phases de Développement

| Phase | Focus | Activités Clés |
|-------|-------|----------------|
| **Développement 0-à-1** ("Greenfield") | Générer à partir de zéro | <ul><li>Commencer par des exigences de haut niveau</li><li>Générer des spécifications</li><li>Planifier les étapes d'implémentation</li><li>Construire des applications prêtes pour la production</li></ul> |
| **Exploration Créative** | Implémentations parallèles | <ul><li>Explorer diverses solutions</li><li>Supporter plusieurs piles technologiques & architectures</li><li>Expérimenter avec des modèles UX</li></ul> |
| **Amélioration Itérative** ("Brownfield") | Modernisation Brownfield | <ul><li>Ajouter des fonctionnalités de manière itérative</li><li>Moderniser les systèmes hérités</li><li>Adapter les processus</li></ul> |

## 🎯 Objectifs Expérimentaux

Notre recherche et expérimentation se concentrent sur :

### Indépendance technologique

- Créer des applications utilisant diverses piles technologiques
- Valider l'hypothèse que le Développement Piloté par les Spécifications est un processus non lié à des technologies, langages de programmation ou frameworks spécifiques

### Contraintes d'entreprise

- Démontrer le développement d'applications critiques
- Intégrer les contraintes organisationnelles (fournisseurs cloud, piles techniques, pratiques d'ingénierie)
- Supporter les systèmes de conception d'entreprise et les exigences de conformité

### Développement centré utilisateur

- Construire des applications pour différentes cohortes d'utilisateurs et préférences
- Supporter diverses approches de développement (du vibe-coding au développement natif IA)

### Processus créatifs & itératifs

- Valider le concept d'exploration d'implémentation parallèle
- Fournir des workflows robustes de développement de fonctionnalités itératif
- Étendre les processus pour gérer les mises à niveau et les tâches de modernisation

## 🔧 Prérequis

- **Linux/macOS/Windows**
- [Supporté](#-agents-ia-supportés) Agent de codage IA.
- [uv](https://docs.astral.sh/uv/) pour la gestion de paquets
- [Python 3.11+](https://www.python.org/downloads/)
- [Git](https://git-scm.com/downloads)

Si vous rencontrez des problèmes avec un agent, veuillez ouvrir une issue afin que nous puissions affiner l'intégration.

## 📖 En Savoir Plus

- **[Méthodologie Complète de Développement Piloté par les Spécifications](./spec-driven.md)** - Plongée profonde dans le processus complet
- **[Aperçu Détaillé](#-processus-détaillé)** - Guide d'implémentation étape par étape

---

## 📋 Processus Détaillé

<details>
<summary>Cliquez pour développer l'aperçu détaillé étape par étape</summary>

Vous pouvez utiliser Specify CLI pour amorcer votre projet, ce qui apportera les artefacts requis dans votre environnement. Exécutez :

```bash
specify init <nom_du_projet>
```

Ou initialisez dans le répertoire courant :

```bash
specify init .
# ou utilisez le flag --here
specify init --here
# Ignorer la confirmation quand le répertoire a déjà des fichiers
specify init . --force
# ou
specify init --here --force
```

![Specify CLI amorçant un nouveau projet dans le terminal](./media/specify_cli.gif)

Vous serez invité à sélectionner l'assistant IA que vous utilisez. Vous pouvez également le spécifier proactivement directement dans le terminal :

```bash
specify init <nom_du_projet> --ai claude
specify init <nom_du_projet> --ai gemini
specify init <nom_du_projet> --ai copilot

# Ou dans le répertoire courant :
specify init . --ai claude
specify init . --ai codex

# ou utilisez le flag --here
specify init --here --ai claude
specify init --here --ai codex

# Forcer la fusion dans un répertoire courant non vide
specify init . --force --ai claude

# ou
specify init --here --force --ai claude
```

La CLI vérifiera si vous avez Claude Code, Gemini CLI, Cursor CLI, Qwen CLI, opencode, Codex CLI, ou Amazon Q Developer CLI installé. Si vous ne l'avez pas, ou si vous préférez obtenir les modèles sans vérifier les bons outils, utilisez `--ignore-agent-tools` avec votre commande :

```bash
specify init <nom_du_projet> --ai claude --ignore-agent-tools
```

### **ÉTAPE 1 :** Établir les principes du projet

Allez dans le dossier du projet et exécutez votre agent IA. Dans notre exemple, nous utilisons `claude`.

![Amorçage de l'environnement Claude Code](./media/bootstrap-claude-code.gif)

Vous saurez que les choses sont configurées correctement si vous voyez les commandes `/speckit.constitution`, `/speckit.specify`, `/speckit.plan`, `/speckit.tasks`, et `/speckit.implement` disponibles.

La première étape devrait être d'établir les principes directeurs de votre projet en utilisant la commande `/speckit.constitution`. Cela aide à assurer une prise de décision cohérente tout au long des phases de développement ultérieures :

```text
/speckit.constitution Créer des principes axés sur la qualité du code, les normes de test, la cohérence de l'expérience utilisateur et les exigences de performance. Inclure une gouvernance pour la manière dont ces principes doivent guider les décisions techniques et les choix d'implémentation.
```

Cette étape crée ou met à jour le fichier `.specify/memory/constitution.md` avec les directives fondamentales de votre projet que l'agent IA référencera pendant les phases de spécification, de planification et d'implémentation.

### **ÉTAPE 2 :** Créer les spécifications du projet

Avec vos principes de projet établis, vous pouvez maintenant créer les spécifications fonctionnelles. Utilisez la commande `/speckit.specify` et fournissez ensuite les exigences concrètes pour le projet que vous voulez développer.

>[!IMPORTANT]
>Soyez aussi explicite que possible sur *ce que* vous essayez de construire et *pourquoi*. **Ne vous concentrez pas sur la pile technologique à ce stade**.

Un exemple de prompt :

```text
Développer Taskify, une plateforme de productivité d'équipe. Elle devrait permettre aux utilisateurs de créer des projets, ajouter des membres d'équipe,
assigner des tâches, commenter et déplacer des tâches entre des tableaux de style Kanban. Dans cette phase initiale pour cette fonctionnalité,
appelons-la "Créer Taskify", ayons plusieurs utilisateurs mais les utilisateurs seront déclarés à l'avance, prédéfinis.
Je veux cinq utilisateurs dans deux catégories différentes, un chef de produit et quatre ingénieurs. Créons trois
projets exemples différents. Ayons les colonnes Kanban standard pour le statut de chaque tâche, telles que "À Faire",
"En Cours", "En Revue", et "Fait". Il n'y aura pas de connexion pour cette application car c'est juste le tout
premier test pour s'assurer que nos fonctionnalités de base sont en place. Pour chaque tâche dans l'interface utilisateur pour une carte de tâche,
vous devriez pouvoir changer le statut actuel de la tâche entre les différentes colonnes du tableau de travail Kanban.
Vous devriez pouvoir laisser un nombre illimité de commentaires pour une carte particulière. Vous devriez pouvoir, à partir de cette carte de tâche,
assigner l'un des utilisateurs valides. Lorsque vous lancez Taskify pour la première fois, il va vous donner une liste des cinq utilisateurs à choisir.
Il n'y aura pas de mot de passe requis. Lorsque vous cliquez sur un utilisateur, vous allez dans la vue principale, qui affiche la liste des
projets. Lorsque vous cliquez sur un projet, vous ouvrez le tableau Kanban pour ce projet. Vous allez voir les colonnes.
Vous pourrez glisser-déposer des cartes d'avant en arrière entre différentes colonnes. Vous verrez toutes les cartes qui vous sont
assignées, l'utilisateur actuellement connecté, dans une couleur différente de toutes les autres, afin que vous puissiez rapidement
voir les vôtres. Vous pouvez modifier tous les commentaires que vous faites, mais vous ne pouvez pas modifier les commentaires que d'autres personnes ont faits. Vous pouvez
supprimer tous les commentaires que vous avez faits, mais vous ne pouvez pas supprimer les commentaires que quelqu'un d'autre a faits.
```

Après avoir entré ce prompt, vous devriez voir Claude Code lancer le processus de planification et de rédaction des spécifications. Claude Code déclenchera également certains des scripts intégrés pour configurer le dépôt.

Une fois cette étape terminée, vous devriez avoir une nouvelle branche créée (par ex., `001-create-taskify`), ainsi qu'une nouvelle spécification dans le répertoire `specs/001-create-taskify`.

La spécification produite devrait contenir un ensemble de user stories et d'exigences fonctionnelles, telles que définies dans le modèle.

À ce stade, le contenu de votre dossier de projet devrait ressembler à ceci :

```text
└── .specify
    ├── memory
    │  └── constitution.md
    ├── scripts
    │  ├── check-prerequisites.sh
    │  ├── common.sh
    │  ├── create-new-feature.sh
    │  ├── setup-plan.sh
    │  └── update-claude-md.sh
    ├── specs
    │  └── 001-create-taskify
    │      └── spec.md
    └── templates
        ├── plan-template.md
        ├── spec-template.md
        └── tasks-template.md
```

### **ÉTAPE 3 :** Clarification des spécifications fonctionnelles (requis avant la planification)

Avec la spécification de base créée, vous pouvez aller de l'avant et clarifier toutes les exigences qui n'ont pas été capturées correctement lors de la première tentative.

Vous devriez exécuter le workflow de clarification structuré **avant** de créer un plan technique pour réduire le remaniement en aval.

Ordre préféré :

1. Utilisez `/speckit.clarify` (structuré) – questionnement séquentiel basé sur la couverture qui enregistre les réponses dans une section Clarifications.
2. Suivez éventuellement avec un raffinement libre ad-hoc si quelque chose semble encore vague.

Si vous voulez intentionnellement sauter la clarification (par ex., spike ou prototype exploratoire), indiquez-le explicitement pour que l'agent ne bloque pas sur les clarifications manquantes.

Exemple de prompt de raffinement libre (après `/speckit.clarify` si encore nécessaire) :

```text
Pour chaque projet exemple ou projet que vous créez, il devrait y avoir un nombre variable de tâches entre 5 et 15
tâches pour chacun distribuées aléatoirement dans différents états d'achèvement. Assurez-vous qu'il y a au moins
une tâche à chaque étape d'achèvement.
```

Vous devriez également demander à Claude Code de valider la **Checklist de Revue & Acceptation**, en cochant les choses qui sont validées/passent les exigences, et laisser celles qui ne le sont pas décochées. Le prompt suivant peut être utilisé :

```text
Lisez la checklist de revue et d'acceptation, et cochez chaque élément de la checklist si la spécification de la fonctionnalité répond aux critères. Laissez vide si ce n'est pas le cas.
```

Il est important d'utiliser l'interaction avec Claude Code comme une opportunité de clarifier et de poser des questions autour de la spécification - **ne traitez pas sa première tentative comme finale**.

### **ÉTAPE 4 :** Générer un plan

Vous pouvez maintenant être spécifique sur la pile technologique et d'autres exigences techniques. Vous pouvez utiliser la commande `/speckit.plan` qui est intégrée dans le modèle de projet avec un prompt comme celui-ci :

```text
Nous allons générer cela en utilisant .NET Aspire, en utilisant Postgres comme base de données. Le frontend devrait utiliser
Blazor server avec des tableaux de tâches glisser-déposer, des mises à jour en temps réel. Il devrait y avoir une API REST créée avec une API projets,
une API tâches, et une API notifications.
```

La sortie de cette étape inclura un certain nombre de documents de détails d'implémentation, avec votre arborescence de répertoires ressemblant à ceci :

```text
.
├── CLAUDE.md
├── memory
│  └── constitution.md
├── scripts
│  ├── check-prerequisites.sh
│  ├── common.sh
│  ├── create-new-feature.sh
│  ├── setup-plan.sh
│  └── update-claude-md.sh
├── specs
│  └── 001-create-taskify
│      ├── contracts
│      │  ├── api-spec.json
│      │  └── signalr-spec.md
│      ├── data-model.md
│      ├── plan.md
│      ├── quickstart.md
│      ├── research.md
│      └── spec.md
└── templates
    ├── CLAUDE-template.md
    ├── plan-template.md
    ├── spec-template.md
    └── tasks-template.md
```

Vérifiez le document `research.md` pour vous assurer que la bonne pile technologique est utilisée, en fonction de vos instructions. Vous pouvez demander à Claude Code de le affiner si l'un des composants ressort, ou même lui faire vérifier la version installée localement de la plateforme/framework que vous voulez utiliser (par ex., .NET).

De plus, vous voudrez peut-être demander à Claude Code de rechercher des détails sur la pile technologique choisie si c'est quelque chose qui change rapidement (par ex., .NET Aspire, frameworks JS), avec un prompt comme celui-ci :

```text
Je veux que vous parcouriez le plan d'implémentation et les détails d'implémentation, en cherchant des domaines qui pourraient
bénéficier de recherches supplémentaires car .NET Aspire est une bibliothèque qui change rapidement. Pour les domaines que vous identifiez qui
nécessitent des recherches plus approfondies, je veux que vous mettiez à jour le document de recherche avec des détails supplémentaires sur les versions
spécifiques que nous allons utiliser dans cette application Taskify et lancer des tâches de recherche parallèles pour clarifier
tous les détails en utilisant la recherche sur le web.
```

Pendant ce processus, vous pourriez trouver que Claude Code reste bloqué à rechercher la mauvaise chose - vous pouvez l'aider à aller dans la bonne direction avec un prompt comme celui-ci :

```text
Je pense que nous devons décomposer cela en une série d'étapes. D'abord, identifiez une liste de tâches
que vous auriez besoin de faire pendant l'implémentation dont vous n'êtes pas sûr ou qui bénéficieraient
de recherches supplémentaires. Écrivez une liste de ces tâches. Et ensuite pour chacune de ces tâches,
je veux que vous lanciez une tâche de recherche séparée pour que le résultat net soit que nous recherchons
toutes ces tâches très spécifiques en parallèle. Ce que je vous ai vu faire, c'est qu'il semble que vous étiez
en train de rechercher .NET Aspire en général et je ne pense pas que cela va faire grand-chose pour nous dans ce cas.
C'est une recherche bien trop non ciblée. La recherche doit vous aider à résoudre une question ciblée spécifique.
```

>[!NOTE]
>Claude Code pourrait être trop enthousiaste et ajouter des composants que vous n'avez pas demandés. Demandez-lui de clarifier la raison et la source du changement.

### **ÉTAPE 5 :** Faire valider le plan par Claude Code

Avec le plan en place, vous devriez faire parcourir Claude Code à travers celui-ci pour vous assurer qu'il n'y a pas de pièces manquantes. Vous pouvez utiliser un prompt comme celui-ci :

```text
Maintenant je veux que vous alliez auditer le plan d'implémentation et les fichiers de détails d'implémentation.
Lisez-le avec un œil pour déterminer s'il y a ou non une séquence de tâches que vous devez
faire qui sont évidentes à la lecture de ceci. Parce que je ne sais pas s'il y en a assez ici. Par exemple,
quand je regarde l'implémentation de base, il serait utile de référencer les endroits appropriés dans les détails
d'implémentation où il peut trouver l'information alors qu'il parcourt chaque étape dans l'implémentation de base ou dans le raffinement.
```

Cela aide à affiner le plan d'implémentation et vous aide à éviter les angles morts potentiels que Claude Code a manqués dans son cycle de planification. Une fois la passe de raffinement initiale terminée, demandez à Claude Code de parcourir la checklist une fois de plus avant de pouvoir passer à l'implémentation.

Vous pouvez également demander à Claude Code (si vous avez la [GitHub CLI](https://docs.github.com/en/github-cli/github-cli) installée) d'aller de l'avant et de créer une pull request à partir de votre branche actuelle vers `main` avec une description détaillée, pour vous assurer que l'effort est correctement suivi.

>[!NOTE]
>Avant de faire implémenter l'agent, il vaut également la peine de demander à Claude Code de vérifier les détails pour voir s'il y a des pièces sur-ingénierées (rappelez-vous - il peut être trop enthousiaste). Si des composants ou des décisions sur-ingénierés existent, vous pouvez demander à Claude Code de les résoudre. Assurez-vous que Claude Code suit la [constitution](base/memory/constitution.md) comme la pièce fondamentale à laquelle il doit adhérer lors de l'établissement du plan.

### **ÉTAPE 6 :** Générer la décomposition des tâches avec /speckit.tasks

Avec le plan d'implémentation validé, vous pouvez maintenant décomposer le plan en tâches spécifiques et actionnables qui peuvent être exécutées dans le bon ordre. Utilisez la commande `/speckit.tasks` pour générer automatiquement une décomposition détaillée des tâches à partir de votre plan d'implémentation :

```text
/speckit.tasks
```

Cette étape crée un fichier `tasks.md` dans votre répertoire de spécification de fonctionnalité qui contient :

- **Décomposition des tâches organisée par user story** - Chaque user story devient une phase d'implémentation séparée avec son propre ensemble de tâches
- **Gestion des dépendances** - Les tâches sont ordonnées pour respecter les dépendances entre les composants (par ex., modèles avant services, services avant endpoints)
- **Marqueurs d'exécution parallèle** - Les tâches qui peuvent s'exécuter en parallèle sont marquées avec `[P]` pour optimiser le workflow de développement
- **Spécifications de chemin de fichier** - Chaque tâche inclut les chemins de fichiers exacts où l'implémentation doit avoir lieu
- **Structure de développement piloté par les tests** - Si des tests sont demandés, les tâches de test sont incluses et ordonnées pour être écrites avant l'implémentation
- **Validation par point de contrôle** - Chaque phase de user story inclut des points de contrôle pour valider la fonctionnalité indépendante

Le tasks.md généré fournit une feuille de route claire pour la commande `/speckit.implement`, assurant une implémentation systématique qui maintient la qualité du code et permet une livraison incrémentielle des user stories.

### **ÉTAPE 7 :** Implémentation

Une fois prêt, utilisez la commande `/speckit.implement` pour exécuter votre plan d'implémentation :

```text
/speckit.implement
```

La commande `/speckit.implement` va :

- Valider que tous les prérequis sont en place (constitution, spec, plan, et tâches)
- Analyser la décomposition des tâches de `tasks.md`
- Exécuter les tâches dans le bon ordre, en respectant les dépendances et les marqueurs d'exécution parallèle
- Suivre l'approche TDD définie dans votre plan de tâches
- Fournir des mises à jour de progression et gérer les erreurs de manière appropriée

>[!IMPORTANT]
>L'agent IA exécutera des commandes CLI locales (telles que `dotnet`, `npm`, etc.) - assurez-vous d'avoir les outils requis installés sur votre machine.

Une fois l'implémentation terminée, testez l'application et résolvez toutes les erreurs d'exécution qui pourraient ne pas être visibles dans les journaux CLI (par ex., erreurs de console de navigateur). Vous pouvez copier et coller ces erreurs à votre agent IA pour résolution.

</details>

---

## 🔍 Dépannage

### Git Credential Manager sur Linux

Si vous rencontrez des problèmes avec l'authentification Git sur Linux, vous pouvez installer Git Credential Manager :

```bash
#!/usr/bin/env bash
set -e
echo "Téléchargement de Git Credential Manager v2.6.1..."
wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.6.1/gcm-linux_amd64.2.6.1.deb
echo "Installation de Git Credential Manager..."
sudo dpkg -i gcm-linux_amd64.2.6.1.deb
echo "Configuration de Git pour utiliser GCM..."
git config --global credential.helper manager
echo "Nettoyage..."
rm gcm-linux_amd64.2.6.1.deb
```

## 👥 Mainteneurs

- Den Delimarsky ([@localden](https://github.com/localden))
- John Lam ([@jflam](https://github.com/jflam))

## 💬 Support

Pour le support, veuillez ouvrir une [issue GitHub](https://github.com/github/spec-kit/issues/new). Nous accueillons les rapports de bugs, les demandes de fonctionnalités et les questions sur l'utilisation du Développement Piloté par les Spécifications.

## 🙏 Remerciements

Ce projet est fortement influencé par et basé sur le travail et la recherche de [John Lam](https://github.com/jflam).

## 📄 Licence

Ce projet est sous licence selon les termes de la licence open source MIT. Veuillez vous référer au fichier [LICENSE](./LICENSE) pour les termes complets.
