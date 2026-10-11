# Audit de conformité — Brandbook Mboa v2

> Les deux apps (`mboa_user`, `mboa_pro`) relues écran par écran et jeton par
> jeton contre le Brandbook v2 (49 planches).
> **Fait le 11 octobre 2026.** Commits `c5eb4b9` → `5c0d29d`.

---

## Verdict

**Les fondations sont justes ; les écarts étaient tous à un jeton près.**

La palette, l'échelle typographique et les polices correspondent au brandbook
au pixel et à l'hexadécimal près — ce n'est pas un hasard, elles ont été
posées à partir de la charte. Ce qui avait dérivé, ce sont les endroits où une
valeur a été choisie à l'œil plutôt que lue dans le document : un rayon de
bouton, une seconde teinte de vert pâle, un prix qui porte une couleur
différente sur chaque écran.

Rien de tout cela ne se voit en regardant une capture. C'est exactement
pourquoi ça avait tenu si longtemps.

Un seul point reste ouvert et **demande votre décision** : la couleur des
boutons d'action (§ *La décision qui reste*).

---

## 1. Ce qui était déjà conforme

| Planche | Point | Constat |
|---|---|---|
| §21 | Palette | Les 14 couleurs de marque et neutres, exactes à l'hexadécimal près. |
| §22 | Couleurs système | Les 4 (succès, erreur, alerte, info), exactes. |
| §25 | Échelle typographique | Les **9 niveaux**, exacts : tailles, interlignes, graisses et approches (Display et H1 à −0,5 px, Micro à +0,2 px). |
| §24 | Polices | Plus Jakarta Sans (600/700/800) et Inter (400/500/600), embarquées dans l'app, pas chargées du réseau. |
| §25 | Casse | Aucun titre, bouton ou label en capitales. Les seuls `toUpperCase()` du code sont des initiales d'avatar et des valeurs de protocole. |
| §25 | Alignement | Le centrage est réservé à l'onboarding et aux écrans vides, comme demandé — vérifié sur les 69 occurrences. |
| §27 | Iconographie | Lucide, contour, coins arrondis. |
| §28 | Badges | Pilule, Inter Medium 12 px. |
| §6.2 | Ombre de carte | `0 2px 12px rgba(0,0,0,.08)`, exacte. |
| §39 | Nom de l'app | « Mboa », sans sous-titre. |
| §48 | Orthographe | « Mboa » correctement écrit partout. |

---

## 2. Ce qui a été corrigé

### Mesures

| Planche | Dit | Était | Portée |
|---|---|---|---|
| §28 | Boutons **rayon 12 px** | **28 px** — le rayon des bottom sheets | **Les 60 boutons des deux apps.** Le thème Material avait 12 depuis toujours ; le widget `Button` l'écrasait. |
| §28 | Hauteurs **52 / 44 / 36** | 52 et 44 | La troisième n'avait pas de jeton. |
| §29 | Cartes **rayon 16 px** | 5 cartes à 24 px | Deux cartes utilisaient déjà 16 : la même carte changeait de rayon selon l'écran. |

### Couleurs

**§21 — deux couleurs hors palette.** La palette du brandbook est donnée
intégralement, donc close. Deux valeurs n'en faisaient pas partie :

- `#D8F3DC`, un vert pâle juste à côté du `#E8F4F0` officiel, sur 8 surfaces ;
- `#FBFBFB` comme fond de page, relevé sur une maquette.

Le second avait une intention écrite dans le code — « un cheveu plus sombre
que le blanc pour que les cartes blanches ressortent ». **1,5 % d'écart ne
produit pas ce relief.** Résultat concret : la carte d'annonce Pro, blanche,
sans bordure ni ombre, sur un fond à 1,5 % du blanc — aucun bord visible. Le
fond est passé au Blanc Chaud `#F9F7F4` officiel, et la carte a reçu l'ombre
§6.2 qui, elle, fait le travail.

**§20 — le corail est la couleur des prix.** La carte de recherche le faisait
déjà. Les cinq autres écrans avaient chacun choisi un vert différent :
`primary`, `primaryDark`, `primary`, `primaryDark`, `primary`. **Un même prix
s'affichait en quatre couleurs selon l'écran.** Tous passés au corail, sauf le
héros vert de la fiche Pro, qui garde le blanc : §22 interdit le corail sur
vert sans exception.

### Copie

| Planche | Dit | Était |
|---|---|---|
| §29 / §39 | « 75 000 **FCFA** / mois » | « 110 000 **XAF** / **M**ois » — le code ISO, et une majuscule en milieu de phrase |
| §48 | « Français d'abord » | La salutation d'accueil : « Hello !! », identique en français et en anglais |
| §48 | idem | Une ligne de certification : « ID Document », en français |

Les noms de période gardent leur majuscule dans les sélecteurs, où ils ouvrent
un libellé ; les prix utilisent désormais des formes en ligne distinctes.

### Illustration

**§27 — illustration sur onboarding, écrans vides et erreurs, nulle part
ailleurs.** Les cartes d'accueil Pro peignaient trois disques translucides —
le même ornement retiré de l'`ActionCard` au commit précédent. Leur bouton
était par ailleurs un `OutlinedButton` brut en forme de stade : la pilule est
la forme que §28 réserve aux badges.

### Et un défaut qui n'est pas cosmétique

**`Button.isLoading` ne faisait rien.** Le champ était déclaré, les cinq
fabriques le transmettaient, et `build()` ne le lisait jamais. **42 points
d'appel** demandaient un état occupé et obtenaient un bouton d'apparence
inchangée, resté cliquable : enregistrer un contrat, confirmer une visite ou
envoyer une pièce de certification pouvaient partir deux fois.

C'est aussi l'explication du doublon `PrimaryButton` trouvé à côté : quelqu'un
a eu besoin d'un bouton occupé, et en a écrit un second plutôt que de chercher
pourquoi le premier ne marchait pas. Le doublon est supprimé ; ses deux tests
pointent maintenant le vrai widget — où ils échouaient avant le correctif,
ce qui est précisément leur intérêt.

---

## 3. La décision qui reste

**Les boutons d'action principaux sont verts. Le brandbook les veut corail.**

§20 est explicite :

> **Vert Forêt** — Logo, icône, **boutons secondaires**, badge « Vérifié
> Mboa », navigation active.
> **Corail Chaud** — **Boutons d'action principaux**, prix, notes, urgence.
> Toujours interactif.

Et §28 donne « Réserver » comme exemple de bouton *Primary*, ce qui est une
action principale au sens de §20.

Dans l'état :

| | Occurrences |
|---|---|
| `Button.primary` — rendu en **vert forêt** | **41** |
| Toutes utilisations du corail dans les deux apps | **11** (dont 5 sont les prix corrigés ci-dessus) |

Autrement dit, **la couleur d'action de la marque est presque absente des deux
applications**.

**Je ne l'ai pas changé seul, pour deux raisons.**

1. Les 41 appels ne sont pas tous des actions principales. Certains ouvrent
   un écran (« Voir détails »), ce que §20 classe en secondaire. Un
   basculement global rendrait corail des boutons que le brandbook veut verts.
2. §22 interdit le corail sur vert, **sans exception**. Plusieurs de ces
   boutons se trouvent sur un en-tête ou une carte verte. Un basculement
   global créerait des infractions là où il n'y en avait pas.

C'est donc un arbitrage écran par écran, pas une substitution.

**Ce que je recommande**, si vous le validez : passer en corail les actions
qui engagent — Contacter, Planifier une visite, Réserver, Payer, Publier,
Signer — et laisser en vert la navigation et les actions secondaires. Environ
une douzaine d'écrans. Dites-moi et je le fais ; la liste des 41 appels est
déjà établie.

---

## 4. Écarts assumés, à conserver tels quels

Ce ne sont pas des défauts : ce sont des décisions prises, consignées ici pour
qu'on ne les « corrige » pas par erreur plus tard.

- **§27 — « personnages africains ».** Vous avez choisi *« du géométrique sans
  personnages »*. Les illustrations sont donc des formes : une trame de petits
  M et une ligne de pignons. Le brandbook demande des personnages ; c'est un
  écart volontaire.
- **Le motif de marque n'est pas une illustration.** Le dégradé de petits M
  apparaît sur le splash, le héros d'authentification et l'en-tête de profil.
  La ligne tenue : une **surface de marque** pleine peut porter la texture ;
  un **composant de contenu** (une carte) ne le peut pas. C'est pourquoi le
  filigrane de l'`ActionCard` et les disques des cartes Pro ont été retirés,
  alors que le splash garde le sien.
- **§27 — épaisseur de trait 1,5 px / 2 px.** Lucide est embarqué en police
  d'icônes ; une police n'expose pas son épaisseur de trait. Il faudrait
  passer aux SVG pour l'obtenir. Non fait.
- **Mode sombre.** Le brandbook ne spécifie que le clair. Le schéma sombre est
  une adaptation maison, signalée comme telle dans le code.

---

## 5. Ce que cet audit ne peut pas encore vérifier

- **§30 — Photographie** (« réalistes, sans filtre »). L'environnement de dev
  n'a presque pas de photos réelles : les fiches affichent des emplacements.
  À reprendre quand le bucket sera garni.
- **Les notifications push.** Leur texte vient du serveur, pas de l'app, et
  vouvoie encore. Déposé en §23 de `docs/backend-requests.md`.
- **Marges d'écran (§29 : 20 px).** Le jeton existe et vaut 20, mais il n'est
  employé que 6 fois ; les pages sont rembourrées à 16 ou 24. C'est une
  cohérence à reprendre écran par écran, pas un remplacement mécanique — je
  ne l'ai pas touché.

---

## 6. Comment la conformité tient maintenant

Une relecture ne tient pas. Deux fichiers de test transforment en assertions
ce que le brandbook formule en règles vérifiables :

- **`packages/mboa_l10n/test/voice_test.dart`** — §07 : tutoiement (pronoms et
  terminaisons verbales), mots proscrits dans les deux langues, et la copie
  que §35 donne mot pour mot.
- **`packages/mboa_ui/test/theme/palette_test.dart`** — §21/§22 : la palette
  close ; §28/§29 : rayons, hauteurs, ombre de carte, grille et système 8 px.

Les deux ont été vérifiés en échec avant d'être adoptés : un test de
conformité qui n'a jamais rougi ne prouve rien.

**750 tests verts, `make analyze` propre.**
