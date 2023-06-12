import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/widgets/study_card.dart';
import '../firebase_api.dart';

class StudyPage extends StatefulWidget {
  final String deckName;
  const StudyPage({Key? key, required this.deckName}) : super(key: key);

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  int currentCard = 0, cardsLength = 0;
  late String deckID;
  Future<QuerySnapshot<Map<String, dynamic>>>? cards;
  Future<void> fetchCards() async {
    setState(() {
      cards = Future.value(FirestoreFunctions().getCards(widget.deckName));
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            SizedBox(
              width: 600,
              height: 500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                    future: cards,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final cards = snapshot.data;
                        cardsLength = snapshot.data?.size as int;
                        deckID = cards!.docs[currentCard].id;
                        return StudyCard(
                          cards: cards,
                          currentCard: currentCard,
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumberButton(1),
                _buildNumberButton(2),
                _buildNumberButton(3),
                _buildNumberButton(4),
                _buildNumberButton(5),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(int grade) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _getNumberButtonColor(grade),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
        onPressed: () {
          setState(() {
            cards =
                Future.value(FirestoreFunctions().getCards(widget.deckName));

            final firestoreFunctions = FirestoreFunctions();
            firestoreFunctions.changeGrade(widget.deckName, deckID, grade);
            currentCard++;
            if (currentCard >= cardsLength) currentCard = 0;
          });
        },
        child: Text(
          grade.toString(),
          style: const TextStyle(fontSize: 26),
        ),
      ),
    );
  }

  Color _getNumberButtonColor(int number) {
    switch (number) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.green;
      case 5:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
