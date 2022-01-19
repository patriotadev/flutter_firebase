import 'package:flutter/material.dart';
import 'package:flutter_firebase/notes/controller.dart';
import 'package:flutter_firebase/notes/screen/note_main.dart';
import 'package:flutter_firebase/vendor/slide_animation.dart';

class NoteAdd extends StatefulWidget {
  @override
  _NoteAddState createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final NoteController note = new NoteController();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Note')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.indigo))),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        maxLines: 8,
                        controller: descriptionController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            // labelText: 'Description',
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.indigo))),
                      )),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        note.addNote(titleController, descriptionController);
                        Navigator.pushAndRemoveUntil(
                            context,
                            SlideRightRoute(
                                page: NoteMain(
                              title: 'FlutterFire',
                            )),
                            (Route<dynamic> route) => false);
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.indigo),
                      child: Text('Submit'),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
