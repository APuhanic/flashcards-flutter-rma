import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/widgets/flashcard_list.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/firebase_api.dart';
import 'package:flashcards/pages/add_card_screen.dart';

class DeckPage extends StatefulWidget {
  const DeckPage({Key? key, required this.deckName}) : super(key: key);

  final String deckName;
  @override
  State<DeckPage> createState() => _DeckPageState();
}

class _DeckPageState extends State<DeckPage> {
  Future<QuerySnapshot<Map<String, dynamic>>>? cards;

  @override
  void initState() {
    super.initState();
    fetchCards();
  }

  Future<void> fetchCards() async {
    setState(() {
      cards = Future.value(FirestoreFunctions().getCards(widget.deckName));
    });
  }

  void deleteCard() async {
    fetchCards();
  }

  void showAddCardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          child: AddCardScreen(deckName: widget.deckName),
        );
      },
    ).then((value) {
      if (value == true) fetchCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.deckName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () async => await Navigator.pushNamed(
                      context, '/study',
                      arguments: widget.deckName),
                  child: const Text('Study',
                      style: TextStyle(fontSize: 30, color: Colors.blue)),
                ),
                TextButton(
                  onPressed: () => showAddCardDialog(context),
                  child: const Text('Add Card',
                      style: TextStyle(fontSize: 18, color: Colors.blue)),
                ),
              ],
            ),
            FlashcardList(
                cards: cards, onDelete: deleteCard, deckName: widget.deckName),
          ],
        ),
      ),
    );
  }
}
