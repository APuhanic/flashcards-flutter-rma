import "package:flutter/material.dart";
import "package:flashcards/widgets/delete_flashcard_alert_dialog.dart";

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
            return DeleteFlashcardAlertDialog(
                deckName: deckName, card: card, onDelete: onDelete);
          }),
      child: SizedBox(
        width: 600,
        child: Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            side: BorderSide(),
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
                    )),
                const SizedBox(height: 10),
                Text(card['answer'], style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
