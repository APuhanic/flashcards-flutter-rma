import "package:flashcards/firebase_api.dart";
import "package:flutter/material.dart";

class Deck extends StatelessWidget {
  final String deckName;
  final Function onDelete;
  const Deck({required this.deckName, required this.onDelete, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/deck', arguments: deckName);
      },
      onLongPress: () => showDialog(
          context: context,
          builder: (BuildContext context) {
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
          }),
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: SizedBox(
          height: 100,
          width: 150,
          child: Text(
            deckName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
