import 'dart:async';
import 'dart:convert';
// import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddStudent extends StatefulWidget {
  AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  TextEditingController idController = TextEditingController();
  TextEditingController fnController = TextEditingController();
  TextEditingController mnController = TextEditingController();
  TextEditingController snController = TextEditingController();
  TextEditingController cgController = TextEditingController();
  TextEditingController ctController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _timer;
    final id = field("ID", idController);
    final fatherName = field("Father's Name", fnController);
    final motherName = field("Mother's Name", mnController);
    final studentName = field("Student's Name", snController);
    final cgpa = field("CGPA", cgController);
    final city = field("City", ctController);
    const box = SizedBox(
      height: 50,
    );
    Future<String> addStudent() async {
      final jsonbody = jsonEncode(<String, dynamic>{
        "StudentId": int.parse(idController.text),
        "StudentName": snController.text,
        "FatherName": fnController.text,
        "MotherName": mnController.text,
        "Cgpa": double.parse(cgController.text),
        "City": ctController.text
      });
      print(jsonbody);
      // final responseofAPI = await http.post(
      //     Uri.parse('http://192.168.1.19:8081/everyStudent'),
      //     headers: {'Content-Type': 'application/json'},
      //     body: jsonbody);
      final responseofAPI = await http.post(
          Uri.parse('http://192.168.33.98:8081/everyStudent'),
          headers: {'Content-Type': 'application/json'},
          body: jsonbody);
      print("Code -----> ${responseofAPI.statusCode}");

      print(jsonDecode(responseofAPI.body));
      print(responseofAPI.body);
      return jsonDecode(responseofAPI.body);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 50, 50, 10),
          child: SingleChildScrollView(
            child: Column(children: [
              id,
              box,
              studentName,
              box,
              fatherName,
              box,
              motherName,
              box,
              cgpa,
              box,
              city,
              box,
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ))),
                child: const Text(
                  "Add Student",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
                onPressed: () async {
                  String response = await addStudent();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        _timer = Timer(const Duration(seconds: 3), () {
                          Navigator.of(context).pop();
                        });
                        return AlertDialog(
                          content: Text(response),
                        );
                      }).then((value) {
                    if (_timer.isActive) {
                      _timer.cancel();
                    }
                    setState(() {
                      idController.clear();
                      fnController.clear();
                      mnController.clear();
                      snController.clear();
                      cgController.clear();
                      ctController.clear();
                    });
                  });
                },
              )
            ]),
          ),
        ),
      ),
    );
  }

  TextFormField field(String hintText, TextEditingController name) {
    return TextFormField(
      autofocus: false,
      cursorColor: Colors.grey,
      controller: name,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
