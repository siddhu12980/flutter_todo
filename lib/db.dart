import 'dart:io';

class Database {
  String? title;
  String? date;
  String? id;
  bool isComplete;

  Database({
    required this.title,
    required this.date,
    required this.id,
    this.isComplete = false,
  });

  static List<Database> datab = [];

  void addDatabase(String title, String date, String id) {
    if (title.isNotEmpty) {
      datab.add(Database(title: title, date: date, isComplete: false, id: id));
      print('Database added successfully!');
    } else {
      print('Invalid database title. Database not added.');
    }
  }

  static List<Database> displayDatabases() {
    return datab;
  }

  static void deleteDataBase(String id) {
    datab.removeWhere((item) => item.id == id);
  }

  void updateDatabase(Database db) {
    db.isComplete = !isComplete;
  }
  // CRUD methods can be added here
}

void main() {
  // DateTime now = DateTime.now();
  // DateTime date = DateTime(now.year, now.month, now.day);
  // int month = date.month;
  // int day = date.day;
}
