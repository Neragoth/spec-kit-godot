# Spécification de Fonctionnalité : [FEATURE NAME]

**Branche de Fonctionnalité** : `[###-feature-name]`
**Créé le** : [DATE]
**Statut** : Brouillon
**Entrée** : Description utilisateur : "$ARGUMENTS"

## Scénarios Utilisateur & Tests *(obligatoire)*

<!--
  IMPORTANT : Les user stories doivent être PRIORISÉES comme des parcours utilisateurs ordonnés par importance.
  Chaque user story/parcours doit être TESTABLE INDÉPENDAMMENT - ce qui signifie que si vous en implémentez juste UNE,
  vous devriez toujours avoir un MVP (Produit Minimum Viable) viable qui apporte de la valeur.
  
  Attribuez des priorités (P1, P2, P3, etc.) à chaque story, où P1 est la plus critique.
  Pensez à chaque story comme une tranche autonome de fonctionnalité qui peut être :
  - Développée indépendamment
  - Testée indépendamment
  - Déployée indépendamment
  - Démontrée aux utilisateurs indépendamment
-->

### User Story 1 - [Titre Bref] (Priorité : P1)

[Décrivez ce parcours utilisateur en langage clair]

**Pourquoi cette priorité** : [Expliquez la valeur et pourquoi elle a ce niveau de priorité]

**Test Indépendant** : [Décrivez comment cela peut être testé indépendamment - ex: "Peut être entièrement testé par [action spécifique] et délivre [valeur spécifique]"]

**Scénarios d'Acceptation** :

1. **Étant donné** [état initial], **Quand** [action], **Alors** [résultat attendu]
2. **Étant donné** [état initial], **Quand** [action], **Alors** [résultat attendu]

---

### User Story 2 - [Titre Bref] (Priorité : P2)

[Décrivez ce parcours utilisateur en langage clair]

**Pourquoi cette priorité** : [Expliquez la valeur et pourquoi elle a ce niveau de priorité]

**Test Indépendant** : [Décrivez comment cela peut être testé indépendamment]

**Scénarios d'Acceptation** :

1. **Étant donné** [état initial], **Quand** [action], **Alors** [résultat attendu]

---

### User Story 3 - [Titre Bref] (Priorité : P3)

[Décrivez ce parcours utilisateur en langage clair]

**Pourquoi cette priorité** : [Expliquez la valeur et pourquoi elle a ce niveau de priorité]

**Test Indépendant** : [Décrivez comment cela peut être testé indépendamment]

**Scénarios d'Acceptation** :

1. **Étant donné** [état initial], **Quand** [action], **Alors** [résultat attendu]

---

[Ajoutez plus de user stories si nécessaire, chacune avec une priorité assignée]

### Cas Limites

<!--
  ACTION REQUISE : Le contenu de cette section représente des placeholders.
  Remplissez-les avec les bons cas limites.
-->

- Que se passe-t-il quand [condition limite] ?
- Comment le système gère-t-il [scénario d'erreur] ?

## Exigences *(obligatoire)*

<!--
  ACTION REQUISE : Le contenu de cette section représente des placeholders.
  Remplissez-les avec les bonnes exigences fonctionnelles.
-->

### Exigences Fonctionnelles

- **FR-001** : Le système DOIT [capacité spécifique, ex: "permettre aux utilisateurs de créer des comptes"]
- **FR-002** : Le système DOIT [capacité spécifique, ex: "valider les adresses email"]
- **FR-003** : Les utilisateurs DOIVENT pouvoir [interaction clé, ex: "réinitialiser leur mot de passe"]
- **FR-004** : Le système DOIT [exigence de données, ex: "persister les préférences utilisateur"]
- **FR-005** : Le système DOIT [comportement, ex: "journaliser tous les événements de sécurité"]

*Exemple de marquage d'exigences peu claires :*

- **FR-006** : Le système DOIT authentifier les utilisateurs via [BESOIN DE CLARIFICATION : méthode d'auth non spécifiée - email/mot de passe, SSO, OAuth ?]
- **FR-007** : Le système DOIT conserver les données utilisateur pendant [BESOIN DE CLARIFICATION : période de rétention non spécifiée]

### Entités Clés *(inclure si la fonctionnalité implique des données)*

- **[Entité 1]** : [Ce qu'elle représente, attributs clés sans implémentation]
- **[Entité 2]** : [Ce qu'elle représente, relations avec d'autres entités]

## Critères de Succès *(obligatoire)*

<!--
  ACTION REQUISE : Définissez des critères de succès mesurables.
  Ceux-ci doivent être agnostiques de la technologie et mesurables.
-->

### Résultats Mesurables

- **SC-001** : [Métrique mesurable, ex: "Les utilisateurs peuvent compléter la création de compte en moins de 2 minutes"]
- **SC-002** : [Métrique mesurable, ex: "Le système gère 1000 utilisateurs simultanés sans dégradation"]
- **SC-003** : [Métrique de satisfaction utilisateur, ex: "90% des utilisateurs complètent avec succès la tâche principale à la première tentative"]
- **SC-004** : [Métrique commerciale, ex: "Réduire les tickets de support liés à [X] de 50%"]
