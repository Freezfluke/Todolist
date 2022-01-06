import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateTodolist extends StatefulWidget {
  final v1, v2, v3;
  const UpdateTodolist(this.v1, this.v2, this.v3);

  @override
  _UpdateTodolistState createState() => _UpdateTodolistState();
}

class _UpdateTodolistState extends State<UpdateTodolist> {
  var _v1, _v2, _v3;
  //ตำแหน่งสำหรับเก็บข้อมูลที่ User กรอกเข้ามา
  TextEditingController todoTitle =
      TextEditingController(); //ช่องสำหรับเก็บข้อมูลที่ User กรอกเข้ามา
  TextEditingController todoDetail =
      TextEditingController(); //ช่องสำหรับเก็บข้อมูลที่ User กรอกเข้ามา

  @override
  void initState() {
    super.initState();
    _v1 = widget.v1; //id
    _v2 = widget.v2; //tile
    _v3 = widget.v3; //detail

    todoTitle.text = _v2;
    todoDetail.text = _v3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Delete ID: $_v1');
          deleteTodo();
          Navigator.pop(context, 'delete');
        },
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.delete,
          size: 40,
        ),
      ),
      appBar: AppBar(
        title: Text(
          "แก้ไข",
          style: TextStyle(
              fontFamily: 'Korbau',
              fontSize: 30,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
            child: Center(
              child: Column(
                children: [
                  TextField(
                    controller: todoTitle,
                    decoration: InputDecoration(
                        labelText: 'รายการที่ต้องทำ',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    minLines: 5,
                    maxLines: 10,
                    controller: todoDetail,
                    decoration: InputDecoration(
                        labelText: 'รายละเอียด', border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      child: Text(
                        "บันทึก",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        print('--------------');
                        print('Detail : ${todoTitle.text}');
                        print('Detail : ${todoDetail.text}');
                        updateTodo();
                        final snackBar = SnackBar(
                          content: const Text(
                            'อัพเดตรายการเรียบร้อยแล้ว',
                            style: TextStyle(fontSize: 20),
                          ),
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.yellowAccent),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.fromLTRB(100, 20, 100, 20)),
                        textStyle: MaterialStateProperty.all(TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'korbau')),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future updateTodo() async {
    // var url = Uri.https('913a-2405-9800-b600-9e17-81c-1173-eac-3826.ngrok.io',
    //     '/api/create-todolist');
    var url = Uri.http('192.168.1.105:8000', '/api/edit-todolist/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"title":"${todoTitle.text}", "detail" : "${todoDetail.text}"}';
    var response = await http.put(url, headers: header, body: jsondata);
    print('-----result-----');
    print(response.body);
  }

  Future deleteTodo() async {
    var url = Uri.http('192.168.1.105:8000', '/api/delete-todolist/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.delete(
      url,
      headers: header,
    );
    print('-----result-----');
    print(response.body);
  }
}
