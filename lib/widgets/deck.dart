import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flashcards/widgets/delete_deck_alert_dialog.dart";
import 'package:flashcards/firebase_api.dart';

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
            deckName: deckName,
            onDelete: onDelete,
          );
        },
      ),
      child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirestoreFunctions().getCards(deckName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final numberOfCards = snapshot.data!.docs.length;
            return Card(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                side: BorderSide(),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: SizedBox(
                height: 150,
                width: 400,
                child: Column(
                  // Take up minimum vertical space
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            deckName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "$numberOfCards cards",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          onPressed: () async => {
                            await Navigator.pushNamed(context, '/deck',
                                arguments: deckName),
                          },
                          child: const Text("Review"),
                        ),
                        OutlinedButton(
                          onPressed: () async => await Navigator.pushNamed(
                              context, '/study',
                              arguments: deckName),
                          child: const Text("Study"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8)
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
