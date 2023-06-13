import "package:flashcards/firebase_api.dart";
import "package:flutter/material.dart";

class DeleteDeckAlertDialog extends StatelessWidget {
  const DeleteDeckAlertDialog({
    super.key,
    required this.deckName,
    required this.onDelete,
  });

  final String deckName;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Deck'),
      content: Text('Are you sure you want to delete $deckName?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            await FirestoreFunctions().deleteDeck(deckName);
            onDelete();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
