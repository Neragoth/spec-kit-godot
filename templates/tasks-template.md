---
description: "Modèle de liste de tâches pour l'implémentation de fonctionnalité"
---

# Tâches : [FEATURE NAME]

**Entrée** : Documents de conception depuis `/specs/[###-feature-name]/`
**Prérequis** : plan.md (requis), spec.md (requis pour les user stories), research.md, data-model.md, contracts/

**Tests** : Les exemples ci-dessous incluent des tâches de test. Les tests sont OPTIONNELS - ne les incluez que s'ils sont explicitement demandés dans la spécification de la fonctionnalité.

**Organisation** : Les tâches sont regroupées par user story pour permettre l'implémentation et le test indépendants de chaque story.

## Format : `[ID] [P?] [Story] Description`

- **[P]** : Peut s'exécuter en parallèle (fichiers différents, pas de dépendances)
- **[Story]** : À quelle user story cette tâche appartient (ex: US1, US2, US3)
- Inclure les chemins de fichiers exacts dans les descriptions

## Conventions de Chemin

- **Projet unique** : `src/`, `tests/` à la racine du dépôt
- **Application Web** : `backend/src/`, `frontend/src/`
- **Mobile** : `api/src/`, `ios/src/` ou `android/src/`
- Les chemins indiqués ci-dessous supposent un projet unique - ajustez selon la structure de plan.md

<!-- 
  ============================================================================
  IMPORTANT : Les tâches ci-dessous sont des TÂCHES EXEMPLES à titre d'illustration uniquement.
  
  La commande /speckit.tasks DOIT remplacer ces tâches par des tâches réelles basées sur :
  - Les user stories de spec.md (avec leurs priorités P1, P2, P3...)
  - Les exigences de la fonctionnalité de plan.md
  - Les entités de data-model.md
  - Les endpoints de contracts/
  
  Les tâches DOIVENT être organisées par user story afin que chaque story puisse être :
  - Implémentée indépendamment
  - Testée indépendamment
  - Livrée comme un incrément MVP
  
  NE PAS conserver ces tâches exemples dans le fichier tasks.md généré.
  ============================================================================
-->

## Phase 1 : Configuration (Infrastructure Partagée)

**Objectif** : Initialisation du projet et structure de base

- [ ] T001 Créer la structure du projet selon le plan d'implémentation
- [ ] T002 Initialiser le projet [langage] avec les dépendances [framework]
- [ ] T003 [P] Configurer les outils de linting et de formatage

---

## Phase 2 : Fondations (Prérequis Bloquants)

**Objectif** : Infrastructure de base qui DOIT être complète avant que TOUTE user story puisse être implémentée

**⚠️ CRITIQUE** : Aucun travail sur les user stories ne peut commencer tant que cette phase n'est pas terminée

Exemples de tâches fondatrices (ajustez selon votre projet) :

- [ ] T004 Configurer le schéma de base de données et le framework de migrations
- [ ] T005 [P] Implémenter le framework d'authentification/autorisation
- [ ] T006 [P] Configurer le routage API et la structure middleware
- [ ] T007 Créer les modèles/entités de base dont dépendent toutes les stories
- [ ] T008 Configurer l'infrastructure de gestion d'erreurs et de journalisation
- [ ] T009 Configurer la gestion de la configuration d'environnement

**Point de contrôle** : Fondations prêtes - l'implémentation des user stories peut maintenant commencer en parallèle

---

## Phase 3 : User Story 1 - [Titre] (Priorité : P1) 🎯 MVP

**But** : [Brève description de ce que cette story délivre]

**Test Indépendant** : [Comment vérifier que cette story fonctionne seule]

### Tests pour User Story 1 (OPTIONNEL - seulement si tests demandés) ⚠️

> **NOTE : Écrivez ces tests EN PREMIER, assurez-vous qu'ils ÉCHOUENT avant l'implémentation**

- [ ] T010 [P] [US1] Test de contrat pour [endpoint] dans tests/contract/test_[name].py
- [ ] T011 [P] [US1] Test d'intégration pour [parcours utilisateur] dans tests/integration/test_[name].py

### Implémentation pour User Story 1

- [ ] T012 [P] [US1] Créer le modèle [Entity1] dans src/models/[entity1].py
- [ ] T013 [P] [US1] Créer le modèle [Entity2] dans src/models/[entity2].py
- [ ] T014 [US1] Implémenter [Service] dans src/services/[service].py (dépend de T012, T013)
- [ ] T015 [US1] Implémenter [endpoint/feature] dans src/[location]/[file].py
- [ ] T016 [US1] Ajouter la validation et la gestion d'erreurs
- [ ] T017 [US1] Ajouter la journalisation pour les opérations de la user story 1

**Point de contrôle** : À ce stade, la User Story 1 devrait être entièrement fonctionnelle et testable indépendamment

---

## Phase 4 : User Story 2 - [Titre] (Priorité : P2)

**But** : [Brève description de ce que cette story délivre]

**Test Indépendant** : [Comment vérifier que cette story fonctionne seule]

### Tests pour User Story 2 (OPTIONNEL - seulement si tests demandés) ⚠️

- [ ] T018 [P] [US2] Test de contrat pour [endpoint] dans tests/contract/test_[name].py
- [ ] T019 [P] [US2] Test d'intégration pour [parcours utilisateur] dans tests/integration/test_[name].py

### Implémentation pour User Story 2

- [ ] T020 [P] [US2] Créer le modèle [Entity] dans src/models/[entity].py
- [ ] T021 [US2] Implémenter [Service] dans src/services/[service].py
- [ ] T022 [US2] Implémenter [endpoint/feature] dans src/[location]/[file].py
- [ ] T023 [US2] Intégrer avec les composants de la User Story 1 (si nécessaire)

**Point de contrôle** : À ce stade, les User Stories 1 ET 2 devraient toutes deux fonctionner indépendamment

---

## Phase 5 : User Story 3 - [Titre] (Priorité : P3)

**But** : [Brève description de ce que cette story délivre]

**Test Indépendant** : [Comment vérifier que cette story fonctionne seule]

### Tests pour User Story 3 (OPTIONNEL - seulement si tests demandés) ⚠️

- [ ] T024 [P] [US3] Test de contrat pour [endpoint] dans tests/contract/test_[name].py
- [ ] T025 [P] [US3] Test d'intégration pour [parcours utilisateur] dans tests/integration/test_[name].py

### Implémentation pour User Story 3

- [ ] T026 [P] [US3] Créer le modèle [Entity] dans src/models/[entity].py
- [ ] T027 [US3] Implémenter [Service] dans src/services/[service].py
- [ ] T028 [US3] Implémenter [endpoint/feature] dans src/[location]/[file].py

**Point de contrôle** : Toutes les user stories devraient maintenant être fonctionnelles indépendamment

---

[Ajoutez plus de phases de user story si nécessaire, en suivant le même modèle]

---

## Phase N : Polissage & Préoccupations Transverses

**Objectif** : Améliorations qui affectent plusieurs user stories

- [ ] TXXX [P] Mises à jour de la documentation dans docs/
- [ ] TXXX Nettoyage et refactoring du code
- [ ] TXXX Optimisation des performances à travers toutes les stories
- [ ] TXXX [P] Tests unitaires supplémentaires (si demandés) dans tests/unit/
- [ ] TXXX Renforcement de la sécurité
- [ ] TXXX Exécuter la validation quickstart.md

---

## Dépendances & Ordre d'Exécution

### Dépendances de Phase

- **Configuration (Phase 1)** : Pas de dépendances - peut commencer immédiatement
- **Fondations (Phase 2)** : Dépend de la fin de la Configuration - BLOQUE toutes les user stories
- **User Stories (Phase 3+)** : Toutes dépendent de la fin de la phase Fondations
  - Les user stories peuvent ensuite procéder en parallèle (si personnel disponible)
  - Ou séquentiellement par ordre de priorité (P1 → P2 → P3)
- **Polissage (Phase Finale)** : Dépend de la fin de toutes les user stories souhaitées

### Dépendances de User Story

- **User Story 1 (P1)** : Peut commencer après Fondations (Phase 2) - Pas de dépendances sur d'autres stories
- **User Story 2 (P2)** : Peut commencer après Fondations (Phase 2) - Peut s'intégrer avec US1 mais devrait être testable indépendamment
- **User Story 3 (P3)** : Peut commencer après Fondations (Phase 2) - Peut s'intégrer avec US1/US2 mais devrait être testable indépendamment

### Au sein de chaque User Story

- Les tests (si inclus) DOIVENT être écrits et ÉCHOUER avant l'implémentation
- Modèles avant services
- Services avant endpoints
- Implémentation de base avant intégration
- Story terminée avant de passer à la priorité suivante

### Opportunités Parallèles

- Toutes les tâches de Configuration marquées [P] peuvent s'exécuter en parallèle
- Toutes les tâches Fondations marquées [P] peuvent s'exécuter en parallèle (au sein de la Phase 2)
- Une fois la phase Fondations terminée, toutes les user stories peuvent commencer en parallèle (si la capacité de l'équipe le permet)
- Tous les tests pour une user story marqués [P] peuvent s'exécuter en parallèle
- Les modèles au sein d'une story marqués [P] peuvent s'exécuter en parallèle
- Différentes user stories peuvent être travaillées en parallèle par différents membres de l'équipe

---

## Exemple Parallèle : User Story 1

```bash
# Lancer tous les tests pour User Story 1 ensemble (si tests demandés) :
Tâche : "Test de contrat pour [endpoint] dans tests/contract/test_[name].py"
Tâche : "Test d'intégration pour [parcours utilisateur] dans tests/integration/test_[name].py"

# Lancer tous les modèles pour User Story 1 ensemble :
Tâche : "Créer le modèle [Entity1] dans src/models/[entity1].py"
Tâche : "Créer le modèle [Entity2] dans src/models/[entity2].py"
```

---

## Stratégie d'Implémentation

### MVP D'abord (User Story 1 Seulement)

1. Compléter Phase 1 : Configuration
2. Compléter Phase 2 : Fondations (CRITIQUE - bloque toutes les stories)
3. Compléter Phase 3 : User Story 1
4. **ARRÊTER et VALIDER** : Tester User Story 1 indépendamment
5. Déployer/démontrer si prêt

### Livraison Incrémentale

1. Compléter Configuration + Fondations → Fondations prêtes
2. Ajouter User Story 1 → Tester indépendamment → Déployer/Démontrer (MVP !)
3. Ajouter User Story 2 → Tester indépendamment → Déployer/Démontrer
4. Ajouter User Story 3 → Tester indépendamment → Déployer/Démontrer
5. Chaque story ajoute de la valeur sans casser les stories précédentes

### Stratégie d'Équipe Parallèle

Avec plusieurs développeurs :

1. L'équipe complète Configuration + Fondations ensemble
2. Une fois Fondations terminé :
   - Développeur A : User Story 1
   - Développeur B : User Story 2
   - Développeur C : User Story 3
3. Les stories se terminent et s'intègrent indépendamment

---

## Notes

- Tâches [P] = fichiers différents, pas de dépendances
- Étiquette [Story] mappe la tâche à une user story spécifique pour la traçabilité
- Chaque user story devrait être complétable et testable indépendamment
- Vérifier que les tests échouent avant d'implémenter
- Commiter après chaque tâche ou groupe logique
- S'arrêter à chaque point de contrôle pour valider la story indépendamment
- Éviter : tâches vagues, conflits de même fichier, dépendances inter-stories qui brisent l'indépendance
