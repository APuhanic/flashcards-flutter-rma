import "package:flashcards/firebase_api.dart";
import "package:flashcards/pages/edit_card_screen.dart";
import "package:flutter/material.dart";
import "package:flashcards/widgets/delete_flashcard_alert_dialog.dart";

class Flashcard extends StatelessWidget {
  final Map<String, dynamic> card;
  final Function onChange;
  final String deckName;
  const Flashcard(
      {required this.card,
      required this.onChange,
      required this.deckName,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return DeleteFlashcardAlertDialog(
                deckName: deckName, card: card, onDelete: onChange);
          }),
      child: SizedBox(
        width: 600,
        child: Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            side: BorderSide(),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(card['question'],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    PopupMenuButton(
                        itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit'),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              )
                            ],
                        onSelected: (value) async {
                          if (value == 'edit') {
                            debugPrint('Edit card');
                            showEditCardDialog(context);
                          } else if (value == 'delete') {
                            await FirestoreFunctions()
                                .deleteCard(deckName, card['cardID']);
                            onChange();
                          }
                        }),
                  ],
                ),
                const SizedBox(height: 10),
                Text(card['answer'], style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showEditCardDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog.fullscreen(
            child: EditCardScreen(
                deckName: deckName, card: card, onChange: onChange),
          );
        }).then((value) {
      if (value == true) onChange();
    });
  }
}
