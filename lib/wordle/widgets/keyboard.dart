// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:wordle/wordle/models/letter_model.dart';

const _qwerty = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['ENTER', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'DEL'],
];

class Keyboard extends StatelessWidget {
  const Keyboard({
    super.key,
    required this.onKeyTapped,
    required this.onDeleteTapped,
    required this.onEnterTapped,
    required this.letters,
  });

  final void Function(String) onKeyTapped;
  final VoidCallback onDeleteTapped;
  final VoidCallback onEnterTapped;
  final Set<Letter> letters;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          _qwerty
              .map(
                (keyrow) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      keyrow.map((letter) {
                        if (letter == 'DEL') {
                          return Expanded(
                            child: _KeyboardButton.delete(
                              onTap: onDeleteTapped,
                            ),
                          );
                        } else if (letter == 'ENTER') {
                          return Expanded(
                            child: _KeyboardButton.enter(onTap: onEnterTapped),
                          );
                        }

                        final letterKey = letters.firstWhere(
                          (e) => e.val == letter,
                          orElse: () => Letter.empty(),
                        );

                        return Expanded(
                          child: _KeyboardButton(
                            letter: letter,
                            onTap: () => onKeyTapped(letter),
                            backgroundColor:
                                letterKey.status == LetterStatus.correct
                                    ? Colors.green
                                    : letterKey.status == LetterStatus.inWord
                                    ? Colors.orange
                                    : letterKey.status == LetterStatus.notInWord
                                    ? Colors.grey.shade800
                                    : Colors.grey,
                          ),
                        );
                      }).toList(),
                ),
              )
              .toList(),
    );
  }
}

class _KeyboardButton extends StatelessWidget {
  const _KeyboardButton({
    super.key,
    this.height = 45,
    this.width = 38,
    required this.letter,
    required this.onTap,
    required this.backgroundColor,
  });

  factory _KeyboardButton.delete({required VoidCallback onTap}) =>
      _KeyboardButton(
        width: 56,
        letter: 'DEL',
        onTap: onTap,
        backgroundColor: Colors.grey,
      );

  factory _KeyboardButton.enter({required VoidCallback onTap}) =>
      _KeyboardButton(
        width: 56,
        letter: 'ENTER',
        onTap: onTap,
        backgroundColor: Colors.grey,
      );

  final double height;
  final double width;
  final String letter;
  final VoidCallback onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: Text(
              letter,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
