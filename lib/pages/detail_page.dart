import 'package:flutter/material.dart';
import 'package:flutter_noted_app/data/datasources/local_datasource.dart';
import 'package:flutter_noted_app/data/models/note.dart';
import 'package:flutter_noted_app/pages/edit_page.dart';
import 'package:flutter_noted_app/pages/home_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.note,
}) :super(key: key);
  final Note note;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Deatil Note',
        style: TextStyle(
          color: Colors.white,
          ),
        ),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: (){
              showDialog(context: context,
              builder: (context){
                return AlertDialog(
                  title: const Text('Delete Note'),
                  content: const Text('Are You Sure'),
                  actions: [
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text('Cancle'),
                    ),
                    TextButton(onPressed: () async {
                      await LocalDatasource()
                      .deleteNoteById(widget.note.id!);
                     Navigator.pushReplacement(context,
                     MaterialPageRoute(builder: (context) {
                      return HomePage();
                     }));
                    },
                    child: const Text(
                      'Delete',
                    )),
                  ],
                );
              });
            },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          )),
          const SizedBox(width: 16),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            widget.note.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            widget.note.content,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return EditPage(note: widget.note,);
          }));
        },
        child: const Icon(Icons.edit),
        ),
    );
  }
}