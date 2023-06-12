import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class StudyCard extends StatelessWidget {
  const StudyCard({
    super.key,
    required this.cards,
    required this.currentCard,
  });

  final QuerySnapshot<Map<String, dynamic>>? cards;
  final int currentCard;

  @override
  Widget build(BuildContext context) {
    final card = cards?.docs[currentCard];
    Color cardColor = Colors.grey;

    final cardData = card?.data();
    cardColor = getCardGradeColor(cardData, cardColor);
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: cardColor,
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
                indent: 20,
              ),
              Text(
                cardData?['answer'],
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
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
      cardColor = Colors.yellow;
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
