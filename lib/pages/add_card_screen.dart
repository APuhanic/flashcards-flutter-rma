import 'package:flutter/material.dart';
import 'package:flashcards/firebase_api.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key, required this.deckName}) : super(key: key);
  final String deckName;

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final answerController = TextEditingController();
  final questionController = TextEditingController();

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
              'Add a new card::',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
              controller: questionController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
              controller: answerController,
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
                    heroTag: "addCard",
                    onPressed: () async {
                      String question = questionController.text.toString();
                      String answer = answerController.text.toString();
                      await FirestoreFunctions()
                          .addCard(question, answer, widget.deckName);
                      if (mounted) {
                        Navigator.pop(context, true);
                      }
                    },
                    label: const Text('Add Card')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
