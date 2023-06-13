import 'package:flutter/material.dart';
import 'package:flashcards/firebase_api.dart';

class EditCardScreen extends StatefulWidget {
  const EditCardScreen(
      {Key? key,
      required this.deckName,
      required this.card,
      required this.onChange})
      : super(key: key);
  final String deckName;
  final Function onChange;
  final Map<String, dynamic> card;

  @override
  State<EditCardScreen> createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  final answerController = TextEditingController();
  final questionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    questionController.text = widget.card["question"];
    answerController.text = widget.card["answer"];
  }

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
              'Edit card',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Question:"),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
              controller: questionController,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Answer:"),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
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
                    heroTag: "edit",
                    onPressed: () async {
                      String question = answerController.text.toString();
                      String answer = questionController.text.toString();
                      await FirestoreFunctions().editCard(
                          widget.card, widget.deckName, question, answer);
                      if (mounted) {
                        Navigator.pop(context, true);
                      }
                    },
                    label: const Text('Edit Card')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
