import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/widgets/flashcard.dart';
import 'package:flutter/material.dart';

class FlashcardList extends StatelessWidget {
  const FlashcardList(
      {Key? key,
      required this.cards,
      required this.onChange,
      required this.deckName})
      : super(key: key);
  final Function onChange;
  final Future<QuerySnapshot<Map<String, dynamic>>>? cards;
  final String deckName;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: cards,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final cardDocs = snapshot.data;
          final cardsData = cardDocs!.docs
              .map((card) => {
                    'answer': card['answer'],
                    'question': card['question'],
                    'cardID': card.id,
                  })
              .toList();
          if (cardsData.isEmpty) {
            return const Center(
                heightFactor: 20,
                child: Text('No cards yet!', style: TextStyle(fontSize: 20)));
          }
          return Column(
            children: cardsData
                .map((card) => Flashcard(
                      card: card,
                      onChange: onChange,
                      deckName: deckName,
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
