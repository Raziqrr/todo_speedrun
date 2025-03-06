import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_speedrun/add.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_speedrun/detail.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> todoList = [];

  void loadData() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final data = await _prefs.getString("todo");
    if (data != null) {
      final converted =
          (json.decode(data) as List<dynamic>).cast<Map<String, dynamic>>();
      setState(() {
        todoList = converted;
      });
    }
  }

  void saveData() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final converted = jsonEncode(todoList);
    _prefs.setString("todo", converted);
  }

  void deleteData(int index) {
    setState(() {
      todoList.removeAt(index);
    });
    saveData();
  }

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.lightGreenAccent[200],
        child: Icon(
          Icons.add,
          color: CupertinoColors.white,
          size: 40,
        ),
        onPressed: () async {
          final result = await Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return AddPage();
          }));
          if (result != null) {
            setState(() {
              todoList.add(result);
            });
            saveData();
            print(todoList);
          }
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: Text(
          "To Do App",
          style: GoogleFonts.lobster(color: Colors.lightGreenAccent),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: todoList[index]["completed"] == false
                  ? CupertinoColors.white
                  : CupertinoColors.systemGreen,
              child: ListTile(
                trailing: Text("${todoList[index]["category"]}"),
                leading: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[900], shape: BoxShape.circle),
                  child: Text(
                    "${index + 1}",
                    style: GoogleFonts.lobster(
                        color: CupertinoColors.white, fontSize: 20),
                  ),
                ),
                onTap: () async {
                  final result = await Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return DetailPage(
                      task: todoList[index],
                      index: index,
                    );
                  }));
                  if (result != null) {
                    if (result == true) {
                      print(result);
                      setState(() {
                        todoList[index]["completed"] = true;
                      });
                    } else if (result == false) {
                      print(result);
                      setState(() {
                        todoList[index]["completed"] = false;
                      });
                    } else {
                      setState(() {
                        deleteData(index);
                      });
                    }
                  }
                },
                title: Text("${todoList[index]["name"]}"),
              ),
            );
          },
        ),
      ),
    );
  }
}
