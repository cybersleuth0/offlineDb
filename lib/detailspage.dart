import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offlinedb/NoteModel.dart';
import 'package:offlinedb/db_helper.dart';

class Detailspage extends StatefulWidget {
  @override
  State<Detailspage> createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  //call the dbhelper
  Db_helper mdb = Db_helper.getInstance();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var oldtitle = titleController.text = args["title"];
    var olddesc = descController.text = args["desc"];
    titleController.text = args["title"];
    descController.text = args["desc"];

    return Scaffold(
      backgroundColor: Color(0xff252525),
      appBar: AppBar(
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //backbutton
            InkWell(
              onTap: () {
                if (titleController.text != oldtitle ||
                    descController.text != olddesc) {
                  mdb.updatenote(NoteModel(
                      nId: args["id"],
                      nTitle: titleController.text,
                      nDesc: descController.text,
                      nCreatedat:
                          DateTime.now().millisecondsSinceEpoch.toString()));
                }
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xff3b3b3b),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            //delete button
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Color(0xff252525),
                    context: context,
                    builder: (_) {
                      return Container(
                        height: 200,
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
                              "Are You Sure!",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 28),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                    child: TextButton(
                                        onPressed: () {
                                          mdb.deletenote(args["id"]);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        style: TextButton.styleFrom(
                                            side: BorderSide(
                                                color: Colors.lightBlueAccent,
                                                width: 2),
                                            elevation: 2),
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ))),
                                SizedBox(width: 10),
                                Expanded(
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: TextButton.styleFrom(
                                            side: BorderSide(
                                                color: Colors.lightBlueAccent,
                                                width: 2),
                                            elevation: 2),
                                        child: Text("Cancle",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18))))
                              ],
                            )
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                margin: EdgeInsets.only(left: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xff3b3b3b),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.restore_from_trash_sharp,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        backgroundColor: Color(0xff252525),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            TextField(
              cursorColor: Colors.white,
              controller: titleController,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                  hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.w700)),
            ),
            SizedBox(height: 20),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            TextField(
              controller: descController,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Desc",
                  hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }
}
