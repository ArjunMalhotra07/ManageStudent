import 'dart:async';
import 'dart:convert';

import 'package:api_test_app/models/studentModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllStudents extends StatefulWidget {
  const AllStudents({super.key});

  @override
  State<AllStudents> createState() => _AllStudentsState();
}

class _AllStudentsState extends State<AllStudents> {
  var _timer;
  TextEditingController idController = TextEditingController();
  TextEditingController fnController = TextEditingController();
  TextEditingController mnController = TextEditingController();
  TextEditingController snController = TextEditingController();
  TextEditingController cgController = TextEditingController();
  TextEditingController ctController = TextEditingController();
  Future<List<StudentDetails>?> getStudentDetails() async {
    // var uri = Uri.parse(
    //     'http://192.168.33.98:8082/Desktop/arjun_malhotra/go_Projects/studentData/testData.json'); //Phone Hotspot
    // var uri = Uri.parse(
    // 'http://192.168.1.19:80/Desktop/arjun/go_projects/01StudentData/testData.json'); // Wifi

    var uri = Uri.parse('http://192.168.1.19:8081/everyStudent');

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      return data.map((e) => StudentDetails.fromJson(e)).toList();
    }
    return null;
  }

  Future<String> updateStudentAPI(
      int id, String sn, fn, mn, var cg, String ct) async {
    final jsonbody = jsonEncode({
      "StudentId": id,
      "StudentName": sn,
      "FatherName": fn,
      "MotherName": mn,
      "Cgpa": cg,
      "City": ct,
      "StudentIdUpdated":
          idController.text.isEmpty ? id : int.parse(idController.text),
      "StudentNameUpdated": snController.text.isEmpty ? sn : snController.text,
      "FatherNameUpdated": fnController.text.isEmpty ? fn : fnController.text,
      "MotherNameUpdated": mnController.text.isEmpty ? mn : mnController.text,
      "CgpaUpdated":
          cgController.text.isEmpty ? cg : double.parse(cgController.text),
      "CityUpdated": ctController.text.isEmpty ? ct : ctController.text
    });
    print(jsonbody);
    final responseofAPI = await http.put(
        Uri.parse('http://192.168.1.19:8081/update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonbody);
    print("Code -----> ${responseofAPI.statusCode}");

    print(jsonDecode(responseofAPI.body));
    print(responseofAPI.body);
    return jsonDecode(responseofAPI.body);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("All Students"),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: const Color(0xffBCE0FD).withOpacity(.38),
          ),
          child: FutureBuilder(
            future: getStudentDetails(),
            builder: (context, data) {
              if (data.hasError) {
                return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(child: Text("${data.error}")));
              } else if (data.hasData) {
                var studentData = data.data as List<StudentDetails>;
                return Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: ListView.builder(
                        itemCount: studentData.length,
                        itemBuilder: ((context, index) {
                          final student = studentData[index];
                          final id = student.studentId;
                          final father = student.fatherName;
                          final mother = student.motherName;
                          final cg = student.cg;
                          final cityName = student.city;
                          final studentName = student.studentName;

                          return Padding(
                            padding: EdgeInsets.fromLTRB(
                                width * .06, 0, width * .06, 15),
                            child: GestureDetector(
                              onDoubleTap: () {
                                edit(context, id!, studentName!, father, mother,
                                    cg, cityName!);
                              },
                              child: Container(
                                color: Colors.white,
                                height: height * .13,
                                width: width * .6,
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ID : $id"),
                                    Text("$studentName"),
                                    Text("$father"),
                                    Text("$mother"),
                                    Text("$cg"),
                                    Text("$cityName"),
                                  ],
                                )),
                              ),
                            ),
                          );
                        }),
                        scrollDirection: Axis.vertical,
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }

  edit(BuildContext context, int id, String sn, fn, mn, var cg, String ct) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              content: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          'Update Student Information',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.purple),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.purple),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ))),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  updateStudent(id, sn, fn, mn, cg, ct);
                                },
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.purple),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ))),
                                onPressed: () {},
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  updateStudent(int id, String sn, fn, mn, var cg, String ct) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              actions: [
                // Update Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                      child: const Text(
                        'Update Details',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                      onPressed: () async {
                        var responseOfApi =
                            await updateStudentAPI(id, sn, fn, mn, cg, ct);
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              _timer = Timer(const Duration(seconds: 3), () {
                                Navigator.of(context).pop();
                              });
                              return AlertDialog(
                                content: Text(responseOfApi),
                              );
                            }).then((value) {
                          if (_timer.isActive) {
                            _timer.cancel();
                            Navigator.of(context).pop();
                          }
                          setState(() {
                            updateStudentAPI(id, sn, fn, mn, cg, ct);
                            idController.clear();
                            snController.clear();
                            fnController.clear();
                            mnController.clear();
                            cgController.clear();
                            ctController.clear();
                          });
                        });
                      },
                    ),
                  ),
                ),
              ],
              content: SingleChildScrollView(
                child: Container(
                  height: 560,
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row : Back Button + Edit Student Details
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(CupertinoIcons.arrow_left_circle,
                                  size: 32, color: Colors.lightBlueAccent)),
                          const Spacer(),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Edit Student Details',
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 10,
                          )
                        ],
                      ),
                      const SizedBox(height: 15),

                      text('Student ID'),
                      const SizedBox(height: 4),
                      form("$id", idController),
                      const SizedBox(height: 15),

                      text("Student's Name"),
                      const SizedBox(height: 4),
                      form(sn, snController),
                      const SizedBox(height: 15),

                      text("Father's Name"),
                      const SizedBox(height: 4),
                      form(fn, fnController),
                      const SizedBox(height: 15),

                      text("Mother's Name"),
                      const SizedBox(height: 4),
                      form(mn, mnController),
                      const SizedBox(height: 15),

                      text('CGPA'),
                      const SizedBox(height: 4),
                      form("$cg", cgController),
                      const SizedBox(height: 15),

                      text('City'),
                      const SizedBox(height: 4),
                      form(ct, ctController),
                    ],
                  ),
                ),
              ),
            ));
  }

  Text text(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.lightBlueAccent,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget form(String hintText, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffBCE0FD).withOpacity(.38),
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: Colors.blueAccent, width: 1.5),
      ),
      height: 50,
      child: Card(
          child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofocus: true,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        maxLength: 30,
        controller: controller,
        maxLines: 3,
        decoration: InputDecoration(
            counterText: "",
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 20, top: 8),
            hintStyle: const TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
            hintMaxLines: 2,
            hintText: hintText),
      )),
    );
  }
}
