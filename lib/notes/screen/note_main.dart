import 'package:flutter/material.dart';
import 'package:flutter_firebase/notes/controller.dart';
import 'package:flutter_firebase/notes/screen/note_add.dart';
import 'package:flutter_firebase/notes/screen/note_detail.dart';
import 'package:flutter_firebase/vendor/slide_animation.dart';

class NoteMain extends StatefulWidget {
  NoteMain({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NoteMainState createState() => _NoteMainState();
}

class _NoteMainState extends State<NoteMain> {
  final NoteController note = new NoteController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              child: Image.asset('images/firebase.png', width: 18),
            ),
            Text(widget.title)
          ],
        ),
      ),
      body: FutureBuilder(
        future: note.getAll(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return Center(child: Text('Empty.'));
            }
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error loading data."));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.indigo)));
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return Card(
                      margin: EdgeInsets.all(5),
                      child: Dismissible(
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          child: Center(child: Text('Removed!')),
                        ),
                        key: UniqueKey(),
                        onDismissed: (direction) => setState(() {
                          note.deleteNote(snapshot.data[index].id);
                        }),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                title:
                                    Text(snapshot.data[index].data()['title']),
                                subtitle: Text(
                                    '${snapshot.data[index].data()['description']}'
                                                .length >
                                            30
                                        ? '${snapshot.data[index].data()['description'].substring(0, 30)}...'
                                        : '${snapshot.data[index].data()['description']}'),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      FadeRoute(
                                          page: NoteDetail(
                                        title: snapshot.data[index]
                                            .data()['title'],
                                        data: snapshot.data[index],
                                      )));
                                },
                              ),
                            )
                          ],
                        ),
                      ));
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, FadeRoute(page: NoteAdd()));
        },
        backgroundColor: Colors.indigo,
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
      ),
    );
  }
}
