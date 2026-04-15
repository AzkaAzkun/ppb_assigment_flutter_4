import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'model/note.dart';

class FirestoreService {
  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('notes');
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  // READ: Ambil stream data khusus milik user yang login
  Stream<List<Note>> get notes {
    return notesCollection
        .where('userId', isEqualTo: uid)
        .orderBy('tgl', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList());
  }

  // CREATE
  Future addNote(String title, String content, String label) async {
    return await notesCollection.add({
      'title': title,
      'content': content,
      'label': label,
      'tgl': Timestamp.now(),
      'userId': uid,
    });
  }

  // UPDATE
  Future updateNote(
      String id, String title, String content, String label) async {
    return await notesCollection.doc(id).update({
      'title': title,
      'content': content,
      'label': label,
      'tgl': Timestamp.now(), // Update the date as well
    });
  }

  // DELETE
  Future deleteNote(String id) async {
    return await notesCollection.doc(id).delete();
  }
}