import "package:flutter/material.dart";
import "package:flashcards/widgets/delete_deck_alert_dialog.dart";

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
            return DeleteDeckAlertDialog(
                deckName: deckName, onDelete: onDelete);
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
