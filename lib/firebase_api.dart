import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final db = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance.currentUser;

final deckReference = db.collection('users').doc(auth!.uid).collection('decks');

class FirestoreFunctions {
  // ...

  Future<List<Map<String, dynamic>>> getDeck() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final deckReference =
        db.collection('users').doc(currentUser!.uid).collection('decks');
    final querySnapshot = await deckReference.get();
    final decks = querySnapshot.docs.map((doc) => doc.data()).toList();
    return decks;
  }

  Future<void> addDeck(String deckName) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final newDeckReference = db
        .collection('users')
        .doc(currentUser!.uid)
        .collection('decks')
        .doc(deckName);
    await newDeckReference.set({'deckName': deckName});
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCards(deckName) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final cardsReference = db
        .collection('users')
        .doc(currentUser!.uid)
        .collection('decks')
        .doc(deckName)
        .collection("cards");

    final querySnapshot = await cardsReference.get();
    return querySnapshot;
  }

  Future<void> addCard(String answer, String question, String deckName) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final newCardReference = db
        .collection('users')
        .doc(currentUser!.uid)
        .collection('decks')
        .doc(deckName)
        .collection("cards");
    await newCardReference.add({'answer': answer, 'question': question});
  }

  Future<void> deleteDeck(String deckName) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final deckReference = db
        .collection('users')
        .doc(currentUser!.uid)
        .collection('decks')
        .doc(deckName);
    await deckReference.delete();
  }

  Future<void> deleteCard(String deckName, cardID) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final cardReference = db
        .collection('users')
        .doc(currentUser!.uid)
        .collection('decks')
        .doc(deckName)
        .collection("cards")
        .doc(cardID);
    debugPrint(cardID);
    await cardReference.delete();
  }

  Future<void> changeGrade(deckName, cardID, grade) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final cardReference = db
        .collection('users')
        .doc(currentUser!.uid)
        .collection('decks')
        .doc(deckName)
        .collection("cards")
        .doc(cardID);
    await cardReference.update({'grade': grade});
  }

  Future<void> editCard(card, deckName, question, answer) async {
    debugPrint(card['question']);
    debugPrint(card['answer']);
    debugPrint(deckName);
    final currentUser = FirebaseAuth.instance.currentUser;
    final cardReference = db
        .collection('users')
        .doc(currentUser!.uid)
        .collection('decks')
        .doc(deckName)
        .collection("cards")
        .doc(card['cardID']);
    await cardReference.update({
      'answer': answer,
      'question': question,
    });
  }
}
