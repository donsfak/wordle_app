// ignore_for_file: use_super_parameters

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:wordle/wordle/models/letter_model.dart';
import 'package:wordle/wordle/models/word_model.dart';
import 'package:wordle/wordle/widgets/board_tile.dart';

class Board extends StatelessWidget {
  const Board(
      {super.key,
      required this.board,
      required this.flipCardState,
      required List<List<GlobalKey<FlipCardState>>> flipCardKeys});

  final List<Word> board;
  final List<List<GlobalKey<FlipCardState>>> flipCardState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: board.asMap().entries.map((entry) {
        int i = entry.key;
        Word word = entry.value;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: word.letters.asMap().entries.map((letterEntry) {
            int j = letterEntry.key;
            Letter letter = letterEntry.value;

            return FlipCard(
              key: flipCardState[i][j], // Correction ici
              flipOnTouch: false,
              direction: FlipDirection.VERTICAL,
              front: BoardTile(
                letter: letter,
              ), // Utilisation directe de letter
              back: BoardTile(letter: letter),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
