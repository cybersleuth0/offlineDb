import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offlinedb/db_helper.dart';

void main() {
  runApp(MaterialApp(
    home: BasicUI(),
    debugShowCheckedModeBanner: false,
  ));
}

class BasicUI extends StatefulWidget {
  @override
  State<BasicUI> createState() => _BasicUIState();
}

class _BasicUIState extends State<BasicUI> {
  ///create object of Db_helper class
  Db_helper? mdb;

  //create a list to store a notes
  List<Map<String, dynamic>> mNotes = [];

  @override
  void initState() {
    super.initState();
    mdb = Db_helper.getInstance();
    getNotes();
  }

  getNotes() async {
    mNotes = await mdb!.fetchAllNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: mNotes.isNotEmpty
            ? ListView.builder(
                itemCount: mNotes.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(mNotes[index][Db_helper.COLUMN_NOTE_TITLE]),
                    subtitle: Text(mNotes[index][Db_helper.COLUMN_NOTE_DESC]),
                  );
                })
            : Center(child: Text("No Notes Yet")),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showModalBottomSheet(
                context: context,
                builder: (_) {
                  return Container(
                    padding: EdgeInsets.all(25),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Add Notes",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          style: TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                              //enabledBorder Means when we don't click on the input field
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.pinkAccent),
                              ),
                              //focusedBorder Means when we click on the input field
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.lightGreen),
                              )),
                        )
                      ],
                    ),
                  );
                });
          },
          child: Icon(Icons.add),
        ));
  }
}
