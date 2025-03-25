// ignore_for_file: unused_field, prefer_final_fields

import 'dart:math';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:wordle/app/app_colors.dart';
import 'package:wordle/wordle/data/word_list.dart';
import 'package:wordle/wordle/models/letter_model.dart';
import 'package:wordle/wordle/models/word_model.dart';
import 'package:wordle/wordle/widgets/board.dart';
import 'package:wordle/wordle/widgets/keyboard.dart';

enum GameStatus { playing, won, lost, submitting }

class WordleScreen extends StatefulWidget {
  const WordleScreen({super.key});

  @override
  State<WordleScreen> createState() => _WordleScreenState();
}

class _WordleScreenState extends State<WordleScreen> {
  GameStatus _gameStatus = GameStatus.playing;
  final List<Word> _board = List.generate(
    6,
    (_) => Word(letters: List.generate(5, (_) => Letter.empty())),
  );
  int _currentWordIndex = 0;

  Word? get _currentWord =>
      _currentWordIndex < _board.length ? _board[_currentWordIndex] : null;

  Word _solution = Word.fromString(
    fiveLetterWords[Random().nextInt(fiveLetterWords.length)].toUpperCase(),
  );

  final Set<Letter> _keyboardLetters = {};
  final List<List<GlobalKey<FlipCardState>>> _flipCardKeys = List.generate(
    6,
    (_) => List.generate(5, (_) => GlobalKey<FlipCardState>()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Wordle',
          style: TextStyle(
            letterSpacing: 4,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Board(board: _board, flipCardState: _flipCardKeys),
          const SizedBox(height: 80),
          Keyboard(
            onKeyTapped: _onKeyTapped,
            onEnterTapped: _onEnterTapped,
            onDeleteTapped: _onDeleteTapped,
            letters: _keyboardLetters,
          ),
        ],
      ),
    );
  }

  void _onKeyTapped(String val) {
    if (_gameStatus == GameStatus.playing && _currentWord != null) {
      setState(() {
        _currentWord!.addLetter(val);
      });
    }
  }

  void _onDeleteTapped() {
    if (_gameStatus == GameStatus.playing && _currentWord != null) {
      setState(() {
        _currentWord!.removeLetter();
      });
    }
  }

  Future<void> _onEnterTapped() async {
    if (_gameStatus != GameStatus.playing || _currentWord == null) return;

    if (_currentWord!.letters.any((letter) => letter == Letter.empty())) return;

    setState(() {
      _gameStatus = GameStatus.submitting;
    });

    for (int i = 0; i < _currentWord!.letters.length; i++) {
      final currentWordLetter = _currentWord!.letters[i];
      final solutionLetter = _solution.letters[i];

      setState(() {
        if (currentWordLetter == solutionLetter) {
          _currentWord!.letters[i] = currentWordLetter.copyWith(
            status: LetterStatus.correct,
          );
        } else if (_solution.letters.contains(currentWordLetter)) {
          _currentWord!.letters[i] = currentWordLetter.copyWith(
            status: LetterStatus.inWord,
          );
        } else {
          _currentWord!.letters[i] = currentWordLetter.copyWith(
            status: LetterStatus.notInWord,
          );
        }
      });

      final letter = _keyboardLetters.firstWhere(
        (e) => e.val == currentWordLetter.val,
        orElse: () => Letter.empty(),
      );

      if (letter.status != LetterStatus.correct) {
        _keyboardLetters.removeWhere((e) => e.val == currentWordLetter.val);
        _keyboardLetters.add(_currentWord!.letters[i]);
      }

      await Future.delayed(
        const Duration(milliseconds: 200),
        () => _flipCardKeys[_currentWordIndex][i].currentState?.toggleCard(),
      );
    }

    _checkIfWinOrLoss();
  }

  void _checkIfWinOrLoss() {
    if (_currentWord == null) return;

    setState(() {
      if (_currentWord!.wordString == _solution.wordString) {
        _gameStatus = GameStatus.won;
        _showSnackBar('You won!', correctColor);
      } else if (_currentWordIndex >= _board.length - 1) {
        _gameStatus = GameStatus.lost;
        _showSnackBar(
          'You lost! Solution: ${_solution.wordString}',
          Colors.redAccent,
        );
      } else {
        _gameStatus = GameStatus.playing;
      }
      _currentWordIndex++;
    });
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.none,
        duration: const Duration(seconds: 2),
        backgroundColor: backgroundColor,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        action: SnackBarAction(
          label: 'New Game',
          onPressed: _restart,
          textColor: Colors.white,
        ),
      ),
    );
  }

  void _restart() {
    setState(() {
      _gameStatus = GameStatus.playing;
      _currentWordIndex = 0;
      _board.clear();
      _board.addAll(
        List.generate(
          6,
          (_) => Word(letters: List.generate(5, (_) => Letter.empty())),
        ),
      );
      _solution = Word.fromString(
        fiveLetterWords[Random().nextInt(fiveLetterWords.length)].toUpperCase(),
      );

      for (var row in _flipCardKeys) {
        for (var key in row) {
          key.currentState?.toggleCard(); // Replace with a valid method
        }
      }

      _keyboardLetters.clear();
    });
  }
}
