import 'package:flashcards/firebase_api.dart';
import 'package:flutter/material.dart';

class DeleteFlashcardAlertDialog extends StatelessWidget {
  const DeleteFlashcardAlertDialog({
    super.key,
    required this.deckName,
    required this.card,
    required this.onDelete,
  });

  final String deckName;
  final Map<String, dynamic> card;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Deck'),
      content: const Text('Are you sure you want to delete this flashcard?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            //delete deck
            Navigator.pop(context);
            await FirestoreFunctions().deleteCard(deckName, card['cardID']);
            onDelete();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
