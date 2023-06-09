import "package:flutter/material.dart";
import 'package:flashcards/widgets/deck.dart';

class DeckList extends StatelessWidget {
  const DeckList({
    super.key,
    required this.decks,
    required this.onChange,
  });

  final Function onChange;
  final Future<List<Map<String, dynamic>>>? decks;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: decks,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final decks = snapshot.data as List<Map<String, dynamic>>;
          debugPrint(decks.toString());

          return Column(
            children: decks
                .map((deck) => Deck(
                      deckName: deck['deckName'],
                      onDelete: onChange,
                    ))
                .toList(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
