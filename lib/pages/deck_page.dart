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

  void getCards() async {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddCardDialog(context),
        child: const Icon(Icons.library_add_outlined),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.deckName,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  FilledButton(
                    onPressed: () async => {
                      await Navigator.pushNamed(context, '/study',
                          arguments: widget.deckName)
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text('Study', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
            FlashcardList(
                cards: cards, onChange: getCards, deckName: widget.deckName),
          ],
        ),
      ),
    );
  }
}
