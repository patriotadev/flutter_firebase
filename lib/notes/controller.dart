import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/notes/model.dart';

class NoteController {
  addNote(title, description) {
    var createdAt = DateTime.now();
    notes.add({
      'title': title.text,
      'description': description.text,
      'created_at': createdAt
    });
  }

  Future<void> getAll() async {
    QuerySnapshot qs = await firestore
        .collection('notes')
        .orderBy('created_at', descending: true)
        .get();
    return qs.docs;
  }

  updateNote(id, title, description) {
    notes
        .doc(id)
        .update({'title': title.text, 'description': description.text});
  }

  deleteNote(id) {
    notes.doc(id).delete();
  }
}
