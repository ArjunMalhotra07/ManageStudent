import 'dart:async';
import 'package:api_test_app/models/studentModel.dart';
import 'package:api_test_app/pages/addStudent.dart';
import 'package:api_test_app/utils/apis.dart';
import 'package:api_test_app/utils/customWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  late Future? myFuture = APIs().getStudentDetails();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFuture = APIs().getStudentDetails();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddStudent()),
            );
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("1st Sem - 2018 CSE Sec A"),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: const Color(0xffBCE0FD).withOpacity(.38),
          ),
          child: FutureBuilder(
            future: myFuture,
            builder: (context, data) {
              if (data.hasError) {
                return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(child: Text("${data.error}")));
              } else if (data.hasData) {
                var studentData = data.data as List;
                // var studentDataObject = studentData
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
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
                          final cg = student.cgpa;
                          final cityName = student.city;
                          final studentName = student.studentName;
                          return SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: SingleChildScrollView(
                                child: GestureDetector(
                                  onDoubleTap: () {
                                    edit(context, id!, studentName!, father,
                                        mother, cg, cityName!);
                                  },
                                  child: Column(children: [
                                    CustomReadOnlyField(
                                        hintText: id.toString()),
                                    CustomReadOnlyField(hintText: studentName),
                                    CustomReadOnlyField(hintText: father),
                                    CustomReadOnlyField(hintText: mother),
                                    CustomReadOnlyField(
                                        hintText: cg.toString()),
                                    CustomReadOnlyField(hintText: cityName),
                                  ]),
                                ),
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

  edit(BuildContext context, var id, String sn, fn, mn, cg, ct) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              content: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Update ${sn}'s Information",
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
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
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
                                width: 20,
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
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  confirmation(id, sn);
                                },
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

  confirmation(int id, String sn) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              content: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Confirm to delete $sn from the database',
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
                                },
                                child: const Text(
                                  "Cancel",
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
                                onPressed: () async {
                                  String response =
                                      await APIs().deleteStudent(id);
                                  Navigator.of(context).pop();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        _timer = Timer(
                                            const Duration(seconds: 3), () {
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
                                      myFuture = APIs().getStudentDetails();
                                      idController.clear();
                                    });
                                  });
                                },
                                child: const Text(
                                  "Confirm",
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

  updateStudent(var id, String sn, fn, mn, cg, ct) {
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
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.purpleAccent),
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
                        var responseOfApi = await APIs().updateStudentAPI(
                            id,
                            sn,
                            fn,
                            mn,
                            cg,
                            ct,
                            idController.text,
                            snController.text,
                            fnController.text,
                            mnController.text,
                            cgController.text,
                            ctController.text);
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
                          }
                          setState(() {
                            myFuture = APIs().getStudentDetails();
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
                                  size: 32, color: Colors.purpleAccent)),
                          const Spacer(),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Edit Student Details',
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 30,
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      CustomTextStyle(title: "Student ID"),
                      const SizedBox(height: 4),
                      CustomField(
                          hintText: id.toString(), controller: idController),
                      const SizedBox(height: 15),

                      CustomTextStyle(title: "Student's Name"),
                      const SizedBox(height: 4),
                      CustomField(hintText: sn, controller: snController),
                      const SizedBox(height: 15),

                      CustomTextStyle(title: "Father's Name"),
                      const SizedBox(height: 4),
                      CustomField(hintText: fn, controller: fnController),
                      const SizedBox(height: 15),

                      CustomTextStyle(title: "Mother's Name"),
                      const SizedBox(height: 4),
                      CustomField(hintText: mn, controller: mnController),
                      const SizedBox(height: 15),

                      CustomTextStyle(title: "CGPA"),
                      const SizedBox(height: 4),
                      CustomField(
                          hintText: cg.toString(), controller: cgController),
                      const SizedBox(height: 15),

                      CustomTextStyle(title: "City"),
                      const SizedBox(height: 4),
                      CustomField(hintText: ct, controller: ctController),
                    ],
                  ),
                ),
              ),
            ));
  }
}
