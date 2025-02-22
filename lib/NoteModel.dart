import 'db_helper.dart';

class NoteModel {
  int? nId;
  String nTitle;
  String nDesc;
  String nCreatedat;

  NoteModel(
      {this.nId,
      required this.nTitle,
      required this.nDesc,
      required this.nCreatedat});

/*
NoteModel Object Representation
When you create a note like this:


NoteModel note = NoteModel(
  nId: 1,
  nTitle: "Flutter Notes",
  nDesc: "Learn how to use SQLite in Flutter.",
  nCreatedat: "2025-02-22 10:00:00",
);

It is stored in Dart as an object with properties:

nId: 1
nTitle: "Flutter Notes"
nDesc: "Learn how to use SQLite in Flutter."
nCreatedat: "2025-02-22 10:00:00"

2️⃣ tomap() Converts it into a Map
When inserting into the database, we call:

note.tomap();
It converts the object into a Map:

{
  "title": "Flutter Notes",
  "description": "Learn how to use SQLite in Flutter.",
  "created_at": "2025-02-22 10:00:00"
}

*/

//toMap
  Map<String, dynamic> tomap() {
    return {
      Db_helper.COLUMN_TITLE: nTitle,
      Db_helper.COLUMN_DESC: nDesc,
      Db_helper.COLUMN_CREATED_AT: nCreatedat,
      //Db_helper.COLUMN_ID: nId,
    };
  }

//fromMap
  factory NoteModel.frommap(Map<String, dynamic> map) {
    return NoteModel(
      nId: map[Db_helper.COLUMN_ID],
      nTitle: map[Db_helper.COLUMN_TITLE],
      nDesc: map[Db_helper.COLUMN_DESC],
      nCreatedat: map[Db_helper.COLUMN_CREATED_AT],
    );
  }
}
