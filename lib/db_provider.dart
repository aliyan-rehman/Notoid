import 'package:flutter/cupertino.dart';
import 'package:notes_app/data/local/db_helper.dart';

class DBProvider extends ChangeNotifier {
  DBHelper dbhelper;

  DBProvider({required this.dbhelper});

  List<Map<String, dynamic>> _mData = [];
  bool _isLoading = true;

  ///events
  void addNote(String title, String desc) async {
    bool check = await dbhelper.addNote(mTitle: title, mDesc: desc);
    if (check) {
      _mData = await dbhelper.getAllNotes();
      notifyListeners();
    }
  }

  void updateNote(String title, String desc, int sno) async {
    bool check = await dbhelper.updateNote(mTitle: title, mDesc: desc,sno: sno,);
    if (check) {
      _mData = await dbhelper.getAllNotes();
      notifyListeners();
    }
  }

  void deleteNote(int sno) async{
    bool check = await dbhelper.deleteNote(sno: sno);
    if (check) {
      _mData = await dbhelper.getAllNotes();
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> getNotes() => _mData;
  bool  get isLoading => _isLoading;

  void getInitialNotes() async {

    _isLoading = true;
    notifyListeners();

    _mData = await dbhelper.getAllNotes();
    _isLoading = false;
    notifyListeners();
  }
}
