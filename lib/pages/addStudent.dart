import 'dart:async';
import 'dart:convert';
import 'package:api_test_app/pages/allStudents.dart';
import 'package:api_test_app/utils/apis.dart';
import 'package:api_test_app/utils/customWidgets.dart';
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
    const box = SizedBox(
      height: 50,
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Add Student"),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 50, 50, 10),
          child: SingleChildScrollView(
            child: Column(children: [
              CustomField(hintText: "ID", controller: idController),
              box,
              CustomField(hintText: "Student's Name", controller: snController),
              box,
              CustomField(hintText: "Father's Name", controller: fnController),
              box,
              CustomField(hintText: "Mother's Name", controller: mnController),
              box,
              CustomField(hintText: "CGPA", controller: cgController),
              box,
              CustomField(hintText: "City", controller: ctController),
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
                  String response = await APIs().addStudent(
                      int.parse(idController.text),
                      snController.text,
                      fnController.text,
                      mnController.text,
                      double.parse(cgController.text),
                      ctController.text);
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
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  });
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
}
