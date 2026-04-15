import 'package:flutter/material.dart';
import '../firestore.dart';
import '../model/note.dart';

class NoteFormScreen extends StatefulWidget {
  final Note? note;
  const NoteFormScreen({super.key, this.note});

  @override
  State<NoteFormScreen> createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends State<NoteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _labelController;

  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController =
        TextEditingController(text: widget.note?.content ?? '');
    _labelController = TextEditingController(text: widget.note?.label ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  void _saveNote() async {
    if (_formKey.currentState!.validate()) {
      if (widget.note == null) {
        // Create
        await _firestoreService.addNote(
          _titleController.text,
          _contentController.text,
          _labelController.text,
        );
      } else {
        // Update
        await _firestoreService.updateNote(
          widget.note!.id!,
          _titleController.text,
          _contentController.text,
          _labelController.text,
        );
      }
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add New Note' : 'Edit Note'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.blue.shade50],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter note title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a title' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _labelController,
                  decoration: InputDecoration(
                    labelText: 'Label',
                    hintText: 'Enter label (e.g. Work, Personal)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a label' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _contentController,
                  maxLines: 8,
                  decoration: InputDecoration(
                    labelText: 'Content',
                    hintText: 'Write your note here...',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter content' : null,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _saveNote,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    widget.note == null ? 'CREATE NOTE' : 'UPDATE NOTE',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}