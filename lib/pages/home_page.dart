import 'package:flutter/material.dart';
import 'package:flashcards/firebase_api.dart' as api;
import 'package:flashcards/widgets/deck_list.dart';
import 'package:flashcards/pages/add_deck_page.dart' as add_deck;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Map<String, dynamic>>>? decks;
  var currentUser = api.auth!.email;

  @override
  void initState() {
    super.initState();
    fetchDecks();
  }

  Future<void> fetchDecks() async {
    List<Map<String, dynamic>> fetchedDecks =
        await api.FirestoreFunctions().getDeck();
    setState(() {
      decks = Future.value(fetchedDecks);
    });
  }

  void deleteDeck() async {
    fetchDecks();
  }

  void showAddDeckDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Dialog.fullscreen(
          child: add_deck.AddDeckPage(),
        );
      },
    ).then((value) {
      if (value == true) fetchDecks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    currentUser.toString(),
                  ),
                  const Text(
                    'Decks:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      showAddDeckDialog(context);
                    },
                    label: const Text('Add Deck'),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              DeckList(decks: decks, onDelete: deleteDeck),
            ],
          ),
        ),
      ),
    );
  }
}
