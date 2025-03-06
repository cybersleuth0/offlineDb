import 'package:flutter/cupertino.dart';
import 'package:offlinedb/NoteModel.dart';
import 'package:offlinedb/db_helper.dart';

class DataFeederProvider extends ChangeNotifier {
  Db_helper databaseProvider;

  DataFeederProvider({required this.databaseProvider});

//get all notes from db
  List<NoteModel> _allnotes = [];

  List<NoteModel> getAllNotes() => _allnotes;

//addnotes
  void addNote({required NoteModel notemodel}) async {
    bool check = await databaseProvider.addnote(addnotemodel: notemodel);
    if (check) {
      _allnotes = await databaseProvider.fetchallnotes();
      notifyListeners();
    }
  }

  //get all inital notes
  void getInitialNotes() async {
    _allnotes = await databaseProvider.fetchallnotes();
    notifyListeners();
  }

  //Remove Note
  void removeNote(int id) async {
    bool check = await databaseProvider.deletenote(id);
    if (check) {
      _allnotes = await databaseProvider.fetchallnotes();
    }
    notifyListeners();
  }

  //delete
  void updateNote(NoteModel updatenote) async {
    bool check = await databaseProvider.updatenote(updatenote);
    if (check) {
      _allnotes = await databaseProvider.fetchallnotes();
    }
    notifyListeners();
  }
}
