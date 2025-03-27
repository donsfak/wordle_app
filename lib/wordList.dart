const List<String> WordList = [
  'abord',
  'accès',
  'actif',
  'adieu',
  'admis',
  'agent',
  'aider', 'aimer', 'ainsi', 'album',
  'aller', 'alors',
  'amour',
  'appel',
  'après',
  'arbre',
  'assez',
  'avion',
  'avril',
  'banco',
  'bande',
  'barbe',
  'barre',
  'belle',
  'blanc',
  'bleue',
  'boire',
  'boîte',
  'bruit',
  'bureau',
  'cadre',
  'calme',
  'campa', // verbe camper au passé simple
  'carte',
  'cause',
  'celui',
  'cents',
  'chaud',
  'chefs',
  'chien',
  'chose',
  'ciel', // 4 lettres, à remplacer
  'cinéma', // 6 lettres, à remplacer
  'cinq', // 4 lettres, à remplacer
  'clair',
  'classe',
  'coeur',
  'comme',
  'corps',
  'coups',
  'cours',
  'court',
  'coûte',
  'créer',
  'dame', // 4 lettres, à remplacer
  'danse',
  'dates',
  'début',
  'degré',
  'demie',
  'depuis',
  'dents',
  'désir',
  'digne',
  'dire', // 4 lettres, à remplacer
  'dixit',
  'doigt',
  'donc', // 4 lettres, à remplacer
  'donné',
  'dormi',
  'douce',
  'doute',
  'droit',
  'durée',
  'école',
  'écrit',
  'effet',
  'égal', // 4 lettres, à remplacer
  'égard',
  'elles',
  'enfin',
  'entre',
  'envoi',
  'envie',
  'erreur', // 6 lettres, à remplacer
  'était',
  'étage',
  'étude',
  'êtres',
  'exact',
  'extra',
  'faire',
  'faute',
  'femme',
  'ferme',
  'fête', // 4 lettres, à remplacer
  'fille',
  'final',
  'finir',
  'fixer',
  'force',
  'forme',
  'forte',
  'frais',
  'franc',
  'fruit',
  'futur',
  'gagna', // verbe gagner au passé simple
  'garde',
  'génie',
  'genre',
  'geste',
  'glace',
  'grand',
  'grave',
  'grève',
  'grise',
  'groue', // (rare, grue femelle)
  'guerre',
  'guide',
  'habet', // (verbe avoir en latin) -> à remplacer
  'haute',
  'heure',
  'hôtel',
  'huile',
  'humus',
  'idée', // 4 lettres, à remplacer
  'image',
  'index',
  'jeudi',
  'jeune',
  'joie', // 4 lettres, à remplacer
  'jouer',
  'jour', // 4 lettres, à remplacer
  'juge', // 4 lettres, à remplacer
  'juger',
  'juillet', // 7 lettres, à remplacer
  'jusqu', // 5 lettres ('jusqu'à')
  'juste',
  'kayak',
  'kilos',
  'label',
  'lacet',
  'large',
  'larme',
  'latin',
  'léger',
  'lente',
  'lettre', // 6 lettres, à remplacer
  'levée',
  'lèvre',
  'libre',
  'ligne',
  'limon',
  'liste',
  'livre',
  'local',
  'loger',
  'longs', // Pluriel, peut être ok
  'louer',
  'lourd',
  'lundi',
  'lutte',
  'madame', // 6 lettres, à remplacer
  'magie',
  'maire',
  'maison', // 6 lettres, à remplacer
  'maître',
  'major',
  'malgré', // 6 lettres, à remplacer
  'maman',
  'mardi',
  'marié',
  'match',
  'matin',
  'média',
  'mêlée',
  'même', // 4 lettres, à remplacer
  'mener',
  'merci',
  'mes', // 3 lettres, à remplacer
  'mesure', // 6 lettres, à remplacer
  'métal',
  'métro',
  'meurt', // verbe mourir
  'micro',
  'mieux',
  'milou', // Nom propre, ok?
  'mince',
  'mitra', // Nom propre, ok?
  'mode', // 4 lettres, à remplacer
  'moins',
  'mois', // 4 lettres, à remplacer
  'monde',
  'monta', // verbe monter
  'moral',
  'morte',
  'moyen',
  'muets', // Pluriel, ok?
  'musée',
  'naître', // 6 lettres, à remplacer
  'neige',
  'neuf', // 4 lettres, à remplacer
  'neuve',
  'niveau', // 6 lettres, à remplacer
  'noire',
  'nolis', // (rare, fret maritime)
  'notes',
  'notre', // 5 lettres ('nôtre')
  'nuage',
  'objet',
  'océan',
  'odeur',
  'offre',
  'ombre',
  'oncle',
  'ordre',
  'orgue',
  'oscar', // Nom propre
  'oubli',
  'ouest',
  'outil',
  'ouïr', // 4 lettres
  'ouvre', // verbe ouvrir
  'paire',
  'palet',
  'panne',
  'parc', // 4 lettres
  'parer',
  'parle', // verbe parler
  'parmi',
  'parti', // nom ou participe
  'passé',
  'patte',
  'payer',
  'pays', // 4 lettres
  'peine',
  'pente',
  'perdu',
  'peste',
  'petit',
  'peur', // 4 lettres
  'phase',
  'photo',
  'pièce',
  'pied', // 4 lettres
  'place',
  'plage',
  'plais', // verbe plaire
  'plan', // 4 lettres
  'plein',
  'pleut', // verbe pleuvoir
  'poids',
  'point',
  'pomme',
  'porte',
  'poser',
  'poste',
  'poule',
  'pourt', // (ancien?)
  'pouvoir', // 7 lettres
  'prend', // verbe prendre
  'près', // 4 lettres
  'prêt', // 4 lettres
  'prête',
  'prime',
  'prise',
  'privé',
  'prix', // 4 lettres
  'proie',
  'promu',
  'propre',
  'puis', // 4 lettres
  'quand',
  'quant',
  'quasi',
  'quels', // Pluriel
  'queue',
  'quota',
  'radio',
  'radis',
  'ramer',
  'rampe',
  'rance',
  'rangs', // Pluriel
  'râper',
  'rater',
  'rayer',
  'rayon',
  'récit',
  'reçu', // 4 lettres
  'reçue',
  'refus',
  'règle',
  'reine',
  'relax',
  'rende', // verbe rendre
  'rendu',
  'reste',
  'rêver',
  'riche',
  'rimer',
  'rires', // Pluriel
  'robot',
  'roche',
  'roman',
  'ronde',
  'rose', // 4 lettres
  'rouge',
  'roule', // verbe rouler
  'route',
  'rugby',
  'rural',
  'russe',
  'rythme', // 6 lettres
  'sable',
  'saint',
  'salle',
  'salut',
  'samedi', // 6 lettres
  'sang', // 4 lettres
  'santé',
  'sauce',
  'sauf', // 4 lettres
  'sauter', // 6 lettres
  'savoir', // 6 lettres
  'scène',
  'scier',
  'seize',
  'selle',
  'selon',
  'semer',
  'sens', // 4 lettres
  'seuil',
  'seule',
  'siège',
  'signe',
  'singe',
  'situé',
  'skier',
  'sobre',
  'social', // 6 lettres
  'soeur',
  'soins', // Pluriel
  'soldat', // 6 lettres
  'solde',
  'somme',
  'songe',
  'sorte',
  'sorti',
  'souci',
  'sourd',
  'sous', // 4 lettres
  'sport',
  'stop', // 4 lettres
  'style',
  'sucre',
  'suède', // Nom propre
  'sujet',
  'suite',
  'suivi',
  'super',
  'sûres', // Pluriel
  'table',
  'tache',
  'tâche',
  'taille',
  'taire',
  'talon',
  'tapis',
  'tard', // 4 lettres
  'tarte',
  'taupe',
  'taux', // 4 lettres
  'temps',
  'tenir',
  'terme',
  'terre',
  'texte',
  'tiens', // verbe tenir
  'tiers',
  'tigre',
  'timbr', // (racine)
  'tirer',
  'titre',
  'toile',
  'tombe',
  'total',
  'touch', // verbe toucher
  'tour', // 4 lettres
  'trace',
  'train',
  'trais', // verbe traire
  'trait',
  'très', // 4 lettres
  'trône',
  'trop', // 4 lettres
  'trou', // 4 lettres
  'tuer', // 4 lettres
  'tuile',
  'type', // 4 lettres
  'union',
  'unique', // 6 lettres
  'usage',
  'usine',
  'utile',
  'valet',
  'valse',
  'vaste',
  'vécu', // 4 lettres
  'vendu',
  'venir',
  'vente',
  'venue',
  'verbe',
  'verre',
  'verse', // verbe verser
  'verte',
  'veste',
  'veuf', // 4 lettres
  'veuve',
  'viande', // 6 lettres
  'vider',
  'vieil', // (forme masc avant voyelle)
  'vieux',
  'ville',
  'vingt',
  'virer',
  'viser',
  'visite', // 6 lettres
  'vista', // (italien)
  'vite', // 4 lettres
  'vitre',
  'vivant', // 6 lettres
  'vivre',
  'voeux', // 5 lettres ('vœux')
  'voici',
  'voilà',
  'voile',
  'voire',
  'voix', // 4 lettres
  'voler',
  'vôtre',
  'voulu',
  'voyez', // verbe voir
  'zèbre',
  'zeste',
  'zones',
];
