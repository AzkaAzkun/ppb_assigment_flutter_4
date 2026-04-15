import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String? id;
  String title;
  String content;
  DateTime tgl;
  String label;
  String userId;

  Note({this.id, required this.title, required this.content, required this.tgl, required this.label, required this.userId});


  factory Note.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Note(
      id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      tgl: (data['tgl'] as Timestamp).toDate(),
      label: data['label'] ?? '',
      userId: data['userId'] ?? '',
    );
  }

  // Konversi dari Object ke Map untuk simpan ke Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'tgl': tgl,
      'label': label,
      'userId': userId,
    };
  }
}