import 'dart:core';

import 'package:flutter/material.dart';
import 'package:todos/constants/colors.dart';
import 'package:todos/db.dart';
import 'package:todos/searchbar.dart';
import 'package:todos/todo_list.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController dateinput = TextEditingController();
  final todolist = Database.displayDatabases();
  List<Database> _foundDb = [];

  late String _title = "";
  late String _date = "";

  @override
  void initState() {
    _foundDb = todolist;
    super.initState();
  }

  void createDatabase(String title, String date) {
    setState(() {
      todolist.add(Database(
          title: title,
          date: date,
          isComplete: false,
          id: DateTime.now().millisecondsSinceEpoch.toString()));
      _foundDb = todolist;
    });
  }

  void _deletedb(String id) {
    setState(() {
      Database.deleteDataBase(id);
      _foundDb = todolist;
    });
  }

  void _updatedb(Database db) {
    db.updateDatabase(db);
    setState(() {
      _foundDb = todolist;
    });
  }

  void _search(String keys) {
    List<Database> results = [];
    if (keys.isEmpty) {
      results = todolist;
    } else {
      results = todolist
          .where(
              (item) => item.title!.toLowerCase().contains(keys.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundDb = results;
    });
  }

  show_Menu(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create a Todo"),
            children: [
              SimpleDialogOption(
                child: TextField(
                  controller: textController1,
                  decoration: const InputDecoration(
                    hintText: "Title goes here",
                  ),
                ),
              ),
              SimpleDialogOption(
                child: TextField(
                  controller: dateinput,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Enter Date"),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('MM/dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16

                      setState(() {
                        dateinput.text = formattedDate;

                        _date = formattedDate;
                        _title = textController1.text
                            .toString(); //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
              SimpleDialogOption(child: const SizedBox(), onPressed: () {}),
              SimpleDialogOption(
                  child: const Text(
                    " Ok ",
                  ),
                  onPressed: () {
                    createDatabase(_title, _date);
                    textController1.clear();
                    dateinput.clear();

                    Navigator.of(context).pop();
                  }),
              SimpleDialogOption(
                  child: const Text(
                    " Cancel ",
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
        centerTitle: true,
        backgroundColor: screenColor,
        leading: IconButton(
          icon: const Icon(Icons.menu_outlined),
          onPressed: () => {},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_3_outlined,
            ),
            onPressed: () => {},
          ),
          const Divider(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            searchbar(
              filter: _search,
            ),

            const SizedBox(
              height: 20,
            ),

            //container for list for todo
            // ignore: prefer_const_constructors
            Expanded(
              child: ListView(children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  child: const Text(
                    'ToDos',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                for (Database dbbs in _foundDb)
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    child: todoList(
                      dbb: dbbs,
                      deltedb: _deletedb,
                      updatedb: _updatedb,
                    ),
                  ),
              ]),
            ),

            //container end
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => show_Menu(context),
        child: const Icon(Icons.add),
      ), //
    );
  }
}
