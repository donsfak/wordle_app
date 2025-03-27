// ignore_for_file: avoid_print

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:wordle/wordList.dart';
import 'package:wordle/wordle/wordle.dart';

const List<String> wordList = WordList;

// Énumérons le statut du jeu
enum GameStatus { playing, submitting, lost, won }

class WordleScreen extends StatefulWidget {
  const WordleScreen({super.key});

  @override
  State<WordleScreen> createState() => _WordleScreenState();
}

// Ajout de 'SingleTickerProviderStateMixin' pour l'AnimationController
class _WordleScreenState extends State<WordleScreen>
    with SingleTickerProviderStateMixin {
  GameStatus _gameStatus = GameStatus.playing;
  // Initialisation du tableau 6x5 avec des lettres vides
  final List<Word> _board = List.generate(
    6,
    (_) => Word(letters: List.generate(5, (_) => Letter.empty())),
  );

  // Clés pour contrôler l'animation de flip de chaque tuile
  final List<List<GlobalKey<FlipCardState>>> _flipCardKeys = List.generate(
    6,
    (_) => List.generate(5, (_) => GlobalKey<FlipCardState>()),
  );

  // Index de la ligne (mot) actuelle
  int _currentWordIndex = 0;

  // Le mot solution (normalement chargé depuis la liste)
  Word _solution = Word.fromString('DEBUG'); // Mot par défaut, sera écrasé

  // État des lettres sur le clavier
  final Set<Letter> _keyboardLetters = {};

  // Contrôleur pour l'animation de secousse (shake)
  late AnimationController _shakeController;
  // (L'animation elle-même serait définie et utilisée plus tard)

  @override
  void initState() {
    super.initState();
    // Initialisation du contrôleur d'animation
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    // Choix d'un mot solution aléatoire au démarrage
    _initializeGame();
  }

  @override
  void dispose() {
    // Libération des ressources du contrôleur d'animation
    _shakeController.dispose();
    super.dispose();
  }

  void _initializeGame() {
    // Vérifier si wordList n'est pas vide pour éviter une erreur
    if (wordList.isEmpty) {
      print('Erreur: wordList est vide!');
      // Mettre un mot par défaut ou gérer l'erreur autrement
      _solution = Word.fromString('ERROR');
      return;
    }
    // Sélectionne un mot aléatoire depuis la liste
    final random = Random();
    final randomIndex = random.nextInt(wordList.length);
    _solution = Word.fromString(wordList[randomIndex].toUpperCase());
    // Assurez-vous que le mot solution a 5 lettres (important si wordList est modifiée par erreur)
    if (_solution.letters.length != 5) {
      print(
          'Erreur: Le mot sélectionné "${_solution.wordString}" n\'a pas 5 lettres!');
      // Relancer l'initialisation ou gérer l'erreur
      _initializeGame();
      return;
    }
    print('Solution: ${_solution.wordString}'); // Pour le debug
  }

  @override
  Widget build(BuildContext context) {
    // Utiliser la couleur de fond du thème actuel
    final theme = Theme.of(context);
    final scaffoldColor = theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: scaffoldColor, // Appliquer la couleur de fond du thème
      // Ajout d'une AppBar
      appBar: AppBar(
        title: const Text('WORDLE'),
        centerTitle: true,
        // Vous pouvez ajouter des actions ici plus tard (Aide, Stats, Thème)
        // actions: [ ... ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // La grille de jeu
          // CORRIGÉ : Appel du widget Board sans le paramètre flipCardState
          Board(
            board: _board,
            flipCardState:
                _flipCardKeys, // Passe _flipCardKeys au paramètre flipCardState
            flipCardKeys:
                _flipCardKeys, // Passe aussi _flipCardKeys au paramètre flipCardKeys
          ), // Passage des clés
          const SizedBox(height: 40), // Espace entre grille et clavier
          // Le clavier
          Keyboard(
            onKeyTapped: _onKeyTapped,
            onDeleteTapped: _onDeleteTapped,
            onEnterTapped: _onEnterTapped,
            letters: _keyboardLetters,
          ),
          const SizedBox(height: 20), // Espace en bas
        ],
      ),
    );
  }

  // Logique pour taper une lettre
  void _onKeyTapped(String val) {
    if (_gameStatus == GameStatus.playing) {
      setState(() {
        // Assurez-vous que addLetter gère la limite de 5 lettres
        _board[_currentWordIndex].addLetter(val);
      });
    }
  }

  // Logique pour supprimer une lettre
  void _onDeleteTapped() {
    if (_gameStatus == GameStatus.playing) {
      setState(() {
        _board[_currentWordIndex].removeLetter();
      });
    }
  }

  // Logique pour soumettre un mot
  Future<void> _onEnterTapped() async {
    // Ne rien faire si le jeu n'est pas en cours ou si le mot n'est pas complet (5 lettres)
    if (_gameStatus != GameStatus.playing ||
            _board[_currentWordIndex].letters.length !=
                5 // Vérifie explicitement 5 lettres
        ) {
      return;
    }

    // CORRIGÉ : Mis en commentaire la vérification incorrecte de la liste de mots
    // // Vérifier si le mot est dans la liste (simplifié ici, devrait vérifier une liste plus large)
    if (!wordList
        .contains(_board[_currentWordIndex].wordString.toLowerCase())) {
      _showSnackBar('Mot non présent dans la liste !');
      //   // Déclencher l'animation Shake ici !
      _shakeController.forward(from: 0.0);
      return;
    }

    setState(() {
      _gameStatus = GameStatus
          .submitting; // Bloque les saisies pendant la soumission/animation
    });

    final Word currentWord = _board[_currentWordIndex];
    final Word solution = _solution;
    final List<Letter> updatedLetters =
        List.from(currentWord.letters); // Copie modifiable

    // Comparaison lettre par lettre (boucle sur 5 lettres)
    for (int i = 0; i < 5; i++) {
      // Assurez-vous que currentWord et solution ont 5 lettres
      final Letter currentLetter = currentWord.letters[i];
      final String solutionLetter = solution.letters[i].val;

      if (currentLetter.val == solutionLetter) {
        updatedLetters[i] =
            currentLetter.copyWith(status: LetterStatus.correct);
      } else if (solution.letters.any((l) => l.val == currentLetter.val)) {
        updatedLetters[i] = currentLetter.copyWith(status: LetterStatus.inWord);
      } else {
        updatedLetters[i] =
            currentLetter.copyWith(status: LetterStatus.notInWord);
      }

      // Mettre à jour l'état du clavier
      final keyboardLetter = _keyboardLetters.firstWhere(
        (e) => e.val == currentLetter.val,
        orElse: () =>
            Letter(val: currentLetter.val, status: LetterStatus.initial),
      );

      // Logique de priorité pour la couleur du clavier
      if (updatedLetters[i].status == LetterStatus.correct) {
        _keyboardLetters.remove(keyboardLetter); // Enlève l'ancienne version
        _keyboardLetters.add(updatedLetters[i]); // Ajoute la version 'correct'
      } else if (keyboardLetter.status != LetterStatus.correct &&
          updatedLetters[i].status == LetterStatus.inWord) {
        _keyboardLetters.remove(keyboardLetter);
        _keyboardLetters.add(updatedLetters[i]);
      } else if (keyboardLetter.status == LetterStatus.initial) {
        _keyboardLetters.remove(keyboardLetter);
        _keyboardLetters.add(updatedLetters[i]); // status = notInWord
      }
    }

    // Mettre à jour le board avec les statuts corrigés AVANT l'animation
    setState(() {
      _board[_currentWordIndex] = Word(letters: updatedLetters);
    });

    // Animation de Flip : retourner les cartes une par une avec un délai (boucle sur 5 lettres)
    for (int i = 0; i < 5; i++) {
      await Future.delayed(
          const Duration(milliseconds: 250)); // Délai entre chaque flip
      // Vérifier si la clé existe et si la carte n'est pas déjà retournée (frontside)
      if (_flipCardKeys[_currentWordIndex][i].currentState != null &&
          !_flipCardKeys[_currentWordIndex][i].currentState!.isFront) {
        _flipCardKeys[_currentWordIndex][i].currentState?.toggleCard();
      }
    }

    // Attendre la fin des animations de flip avant de vérifier la victoire/défaite
    await Future.delayed(const Duration(milliseconds: 250));

    _checkIfWinOrLoss();
  }

  // Vérification de victoire ou défaite
  void _checkIfWinOrLoss() {
    final Word currentWord = _board[_currentWordIndex];
    final bool didWin =
        currentWord.letters.every((l) => l.status == LetterStatus.correct);

    if (didWin) {
      setState(() {
        _gameStatus = GameStatus.won;
      });
      _showEndGameDialog(won: true); // Utiliser un dialogue
    } else if (_currentWordIndex == _board.length - 1) {
      // Dernière tentative
      setState(() {
        _gameStatus = GameStatus.lost;
      });
      _showEndGameDialog(won: false); // Utiliser un dialogue
    } else {
      // Passer à la ligne suivante
      setState(() {
        _gameStatus = GameStatus.playing;
        _currentWordIndex++;
      });
    }
  }

  // Afficher un dialogue de fin de partie
  void _showEndGameDialog({required bool won}) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      barrierDismissible: false, // Empêche de fermer en cliquant à côté
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(won ? 'Félicitations !' : 'Dommage !'),
          content: Column(
            mainAxisSize:
                MainAxisSize.min, // Prend la taille minimum nécessaire
            children: [
              Text(won ? 'Vous avez trouvé le mot !' : 'Le mot était :'),
              if (!won)
                Text(
                  _solution
                      .wordString, // Affiche le mot solution en cas de défaite
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              // Ajoutez des statistiques ici si implémenté
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('NOUVELLE PARTIE'),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue
                _restart();
              },
            ),
          ],
          backgroundColor: theme
              .colorScheme.surface, // Utilise la couleur de surface du thème
          titleTextStyle: theme.textTheme.headlineSmall,
          contentTextStyle: theme.textTheme.bodyLarge,
        );
      },
    );
  }

  // Redémarrer le jeu
  void _restart() {
    setState(() {
      _gameStatus = GameStatus.playing;
      _currentWordIndex = 0;
      // Réinitialiser le board
      _board.setAll(
          0,
          List.generate(6,
              (_) => Word(letters: List.generate(5, (_) => Letter.empty()))));
      // Réinitialiser l'état du clavier
      _keyboardLetters.clear();
      // Réinitialiser les cartes flip (important si elles ont été retournées)
      for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 5; j++) {
          // Vérifier si la carte est retournée (backside visible) et la remettre à l'endroit
          if (_flipCardKeys[i][j].currentState != null &&
              _flipCardKeys[i][j].currentState!.isFront) {
            _flipCardKeys[i][j].currentState?.toggleCard();
          }
        }
      }
      // Sélectionner un nouveau mot solution
      _initializeGame();
    });
  }

  // Ancienne méthode SnackBar (peut être supprimée si non utilisée pour le debug)
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        // ... (action si besoin)
      ),
    );
  }
}
