import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart'; // Plus nécessaire ici
// import 'package:wordle/app/app_colors.dart'; // Plus nécessaire ici

enum LetterStatus { initial, notInWord, inWord, correct }

class Letter extends Equatable {
  const Letter({required this.val, this.status = LetterStatus.initial});

  factory Letter.empty() => const Letter(val: '');

  final String val;
  final LetterStatus status;

  // --- GETTERS backgroundColor ET borderColor SUPPRIMÉS ---
  // La logique de couleur est maintenant gérée dans le widget BoardTile
  // en fonction du thème (clair/sombre) et du LetterStatus.

  Letter copyWith({String? val, LetterStatus? status}) {
    return Letter(val: val ?? this.val, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [val, status];
}
