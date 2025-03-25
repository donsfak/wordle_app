// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:wordle/wordle/models/letter_model.dart';

class BoardTitle extends StatelessWidget {
  const BoardTitle({Key? key, required this.letter}) : super(key: key);
  final Letter letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: letter.backgroundColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: letter.backgroundColor,
          //width: 2,
        ),
      ),

      child: Text(
        letter.val,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
