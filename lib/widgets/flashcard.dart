import "package:flashcards/firebase_api.dart";
import "package:flutter/material.dart";

class Flashcard extends StatelessWidget {
  final Map<String, dynamic> card;
  final Function onDelete;
  final String deckName;
  const Flashcard(
      {required this.card,
      required this.onDelete,
      required this.deckName,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Deck'),
              content:
                  const Text('Are you sure you want to delete this flashcard?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    //delete deck
                    Navigator.pop(context);
                    await FirestoreFunctions()
                        .deleteCard(deckName, card['cardID']);
                    onDelete();
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          }),
      child: SizedBox(
        width: 600,
        child: Card(
          elevation: 0,
          color: Colors.blue,
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(card['question'],
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 10),
                Text(card['answer'],
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
