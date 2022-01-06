import 'package:flutter/material.dart';
import 'package:todolist/pages/add.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:todolist/pages/update_todolist.dart';

class Todolist extends StatefulWidget {
  // const Todolist({Key? key}) : super(key: key);

  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  List todolistItems = [];

  @override
  void initState() {
    super.initState();
    getTodolist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AddPage()))
                .then((value) {
              // .then คือ เมื่อไปแล้วย้อนกลับมาหน้าเดิมให้ ทำการ set state หรือ เปลื่ยนค่าใหม่
              setState(() {
                getTodolist();
              });
            });
          },
          label: const Text(
            'เพิ่มรายการ',
            style: TextStyle(
                fontFamily: 'Korbau',
                fontSize: 25,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
          backgroundColor: Colors.amber,
          icon: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    getTodolist();
                  });
                },
                icon: Icon(Icons.refresh, color: Colors.white, size: 30))
          ],
          title: Text(
            "รายการทั้งหมด",
            style: TextStyle(
                fontFamily: 'Korbau',
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
        ),
        body: todolistCreate());
  }

  Widget todolistCreate() {
    return ListView.builder(
        itemCount: todolistItems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text("${todolistItems[index]['title']}"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateTodolist(
                              todolistItems[index]['id'],
                              todolistItems[index]['title'],
                              todolistItems[index]['detail'],
                            ))).then((value) {
                  // .then คือ เมื่อไปแล้วย้อนกลับมาหน้าเดิมให้ ทำการ set state หรือ เปลื่ยนค่าใหม่
                  setState(() {
                    print(value);
                    if (value == 'delete') {
                      final snackBar = SnackBar(
                        content: const Text(
                          'ลบรายการเรียบร้อยแล้ว',
                          style: TextStyle(fontSize: 25),
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    getTodolist();
                  });
                });
              },
            ),
          );
        });
  }

  Future<void> getTodolist() async {
    List alltodo = [];
    var url = Uri.http('192.168.1.105:8000', '/api/getall-todolist');
    var response = await http.get(url);
    // var result = json.decode(response.body);
    var result = utf8.decode(response.bodyBytes);
    print(result);
    setState(() {
      todolistItems = jsonDecode(result);
    });
  }
}
