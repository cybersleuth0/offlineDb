import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:offlinedb/NoteModel.dart';
import 'package:offlinedb/db_helper.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Map<String, dynamic>> _colorsAndbordercolor = [
    {
      //"backcolor": Color(0xfff8a44c),
      "backcolor": Color(0xffffab91),
    },
    {
      "backcolor": Color(0xffffcc80),
    },
    {
      "backcolor": Color(0xffe7ed9b),
    },
    {
      "backcolor": Color(0xffcf94da),
    },
    {
      "backcolor": Color(0xff81deea),
    },
    {
      "backcolor": Color(0xfff48fb1),
    },
  ];

  Db_helper myDB = Db_helper.getInstance();

  //we have to create an object of Db_helper class
  List<NoteModel> allnotes = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchnotesFromDb();
  }

  //this function will fetch all the notes from the database
  void fetchnotesFromDb() async {
    allnotes = await myDB.fetchallnotes();
    setState(() {});
  }

  DateFormat df = DateFormat.yMMMEd();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff252525),
        appBar: AppBar(
          backgroundColor: Color(0xff252525),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Notes",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.search,
                size: 48,
                color: Colors.white,
              )
            ],
          ),
        ),
        body: allnotes.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 15),
                  itemCount: allnotes.length,
                  itemBuilder: (contex, index) {
                    var eachdate = DateTime.fromMillisecondsSinceEpoch(
                        int.parse(allnotes[index].nCreatedat));
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/detailspage",
                            arguments: {
                              "title": allnotes[index].nTitle,
                              "desc": allnotes[index].nDesc,
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 5, left: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _colorsAndbordercolor[Random()
                                  .nextInt(_colorsAndbordercolor.length - 1)]
                              ["backcolor"],
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                allnotes[index].nTitle,
                                maxLines: 2,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2,
                                    wordSpacing: 2),
                              ),
                              SizedBox(height: 10),
                              Text(
                                allnotes[index].nDesc,
                                maxLines: 5,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 2,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(df.format(eachdate),
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black45)),
                            ]),
                      ),
                    );
                  },
                ),
              )
            : Center(
                child: Text(
                "No Notes.........",
                style: TextStyle(color: Colors.white, fontSize: 32),
              )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffe7ed9b),
          onPressed: () async {
            showModalBottomSheet(
                backgroundColor: Color(0xff252525),
                context: context,
                builder: (_) {
                  return Container(
                    height: 9500,
                    margin: EdgeInsets.only(left: 5, right: 5),
                    padding: EdgeInsets.all(25),
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
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: titleController,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "Notes Title",
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              //enabledBorder Means when we don't click on the input field
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              //focusedBorder Means when we click on the input field
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.lightGreen),
                              )),
                        ),
                        SizedBox(height: 30),
                        TextField(
                          controller: descController,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "Notes Description",
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              //enabledBorder Means when we don't click on the input field
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              //focusedBorder Means when we click on the input field
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.lightGreen),
                              )),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white30,
                                ),
                                onPressed: () async {
                                  //since addNote is a boolen function if the any rows are effected then it will return truemdb
                                  bool inserted = await myDB.addnote(
                                      addnotemodel: NoteModel(
                                          nTitle: titleController.text,
                                          nDesc: descController.text,
                                          nCreatedat: DateTime.now()
                                              .microsecondsSinceEpoch
                                              .toString()));
                                  if (inserted) {
                                    fetchnotesFromDb();
                                    titleController.clear();
                                    descController.clear();
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  "Add Notes",
                                  style: TextStyle(color: Colors.white),
                                )),
                            SizedBox(width: 20),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white30,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancle",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Icon(Icons.add),
        ));
  }
}
