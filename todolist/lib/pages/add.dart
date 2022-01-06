import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  //ตำแหน่งสำหรับเก็บข้อมูลที่ User กรอกเข้ามา
  TextEditingController todoTitle =
      TextEditingController(); //ช่องสำหรับเก็บข้อมูลที่ User กรอกเข้ามา
  TextEditingController todoDetail =
      TextEditingController(); //ช่องสำหรับเก็บข้อมูลที่ User กรอกเข้ามา
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "เพิ่มรายการใหม่",
          style: TextStyle(
              fontFamily: 'Korbau',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black),
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
                        "เพิ่มรายการ",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        print('--------------');
                        print('Detail : ${todoTitle.text}');
                        print('Detail : ${todoDetail.text}');
                        postTodo();
                        setState(() {
                          todoTitle.clear();
                          todoDetail.clear();
                        });
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
                            fontWeight: FontWeight.bold,
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

  Future postTodo() async {
    // var url = Uri.https('913a-2405-9800-b600-9e17-81c-1173-eac-3826.ngrok.io',
    //     '/api/create-todolist');
    var url = Uri.http('192.168.1.105:8000', '/api/create-todolist');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"title":"${todoTitle.text}", "detail" : "${todoDetail.text}"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('-----result-----');
    print(response.body);
  }
}
