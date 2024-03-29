import 'package:flutter/material.dart';
import 'package:flutter_noted_app/data/datasources/local_datasource.dart';
import 'package:flutter_noted_app/data/models/note.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  final _formkey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Note',
        style:TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Form(key: _formkey, child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'title',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Title Wajib Diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: contentController,
            decoration: const InputDecoration(
              labelText: 'Content',
              border: OutlineInputBorder(),
            ),
            maxLines: 8,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Content Wajib Diisi';
              }
              return null;
            },            
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: (){
            if (_formkey.currentState!.validate()){
              Note note = Note(
                title: titleController.text,
                content: contentController.text,
                createdAt: DateTime.now(),
                );
              LocalDatasource().insertNote(note);
              titleController.clear();
              contentController.clear();              
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar (
                  content: const Text(
                    'Note Berhasil Ditambahkan',
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
              ));
                    Navigator.pop(context);
            }
          }, 
          child: const Text('Simpan'),
          ),
        ],
      ),
     ),
    );
  }
}