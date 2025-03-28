import 'package:equatable/equatable.dart';
import 'package:wordle/wordle/models/letter_model.dart';

class Word extends Equatable {
  const Word({required this.letters});

  factory Word.fromString(String word) {
    final letters = word.split('').map((e) => Letter(val: e)).toList();
    return Word(letters: letters);
  }

  final List<Letter> letters;

  String get wordString => letters.map((e) => e.val).join();

  void addLetter(String val) {
    final currentindex = letters.indexWhere((e) => e.val.isEmpty);
    if (currentindex != -1) {
      letters[currentindex] = Letter(val: val);
    }
  }

  void removeLetter() {
    final recentLetterIndex = letters.indexWhere((e) => e.val.isNotEmpty);
    if (recentLetterIndex != -1) {
      letters[recentLetterIndex] = Letter.empty();
    }
  }

  @override
  List<Object?> get props => [letters];
}
