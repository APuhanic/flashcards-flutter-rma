import 'package:flutter/material.dart';
import 'package:flashcards/firebase_api.dart';

class AddDeckPage extends StatefulWidget {
  const AddDeckPage({Key? key}) : super(key: key);

  @override
  State<AddDeckPage> createState() => _AddDeckPageState();
}

class _AddDeckPageState extends State<AddDeckPage> {
  final deckNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add a new deck:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
              controller: deckNameController,
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton.extended(
                    heroTag: "cancel",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: const Text('Cancel')),
                FloatingActionButton.extended(
                    heroTag: "addDeck",
                    onPressed: () async {
                      String deckName = deckNameController.text.toString();
                      await FirestoreFunctions().addDeck(deckName);
                      if (mounted) {
                        Navigator.pop(context, true);
                        Navigator.pushNamed(context, '/deck',
                            arguments: deckName);
                      }
                    },
                    label: const Text('Add Deck')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
