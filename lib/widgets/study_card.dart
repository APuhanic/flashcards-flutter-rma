import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class StudyCard extends StatefulWidget {
  const StudyCard({
    Key? key,
    required this.cards,
    required this.currentCard,
  }) : super(key: key);

  final QuerySnapshot<Map<String, dynamic>>? cards;
  final int currentCard;

  @override
  State<StudyCard> createState() => _StudyCardState();
}

class _StudyCardState extends State<StudyCard> {
  bool showAnswer = false;

  @override
  void didUpdateWidget(covariant StudyCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    showAnswer = false;
  }

  @override
  Widget build(BuildContext context) {
    final card = widget.cards?.docs[widget.currentCard];
    Color cardColor = Colors.grey;

    final cardData = card?.data();
    cardColor = getCardGradeColor(cardData, cardColor);

    return GestureDetector(
      onTap: () {
        setState(() {
          showAnswer = !showAnswer;
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: cardColor,
            width: 3,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  cardData?['question'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                ),
                showAnswer
                    ? Text(
                        cardData?['answer'],
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      )
                    : const Text(
                        'Reveal answer',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getCardGradeColor(Map<String, dynamic>? cardData, Color cardColor) {
    if (cardData?['grade'] == 1) {
      cardColor = Colors.red;
    } else if (cardData?['grade'] == 2) {
      cardColor = Colors.orange;
    } else if (cardData?['grade'] == 3) {
      cardColor = const Color.fromARGB(255, 255, 193, 59);
    } else if (cardData?['grade'] == 4) {
      cardColor = Colors.green;
    } else if (cardData?['grade'] == 5) {
      cardColor = Colors.blue;
    } else {
      cardColor = Colors.grey;
    }
    return cardColor;
  }
}
