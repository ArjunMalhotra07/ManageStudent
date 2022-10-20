import 'dart:convert';

import 'package:api_test_app/models/studentModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllStudents extends StatefulWidget {
  const AllStudents({super.key});

  @override
  State<AllStudents> createState() => _AllStudentsState();
}

class _AllStudentsState extends State<AllStudents> {
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
}
