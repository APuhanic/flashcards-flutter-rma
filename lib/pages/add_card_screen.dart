import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flashcards/firebase_api.dart';
import 'package:image_picker/image_picker.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key, required this.deckName}) : super(key: key);
  final String deckName;

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final answerController = TextEditingController();
  final questionController = TextEditingController();
  File? selectedImage; // Added variable

  @override
  void dispose() {
    answerController.dispose();
    questionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
              'New card',
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
