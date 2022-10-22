// To parse this JSON data, do
//
//     final IncomingStudentDetailsJson = IncomingStudentDetailsJsonFromJson(jsonString);

import 'dart:convert';

IncomingStudentDetailsJson IncomingStudentDetailsJsonFromJson(String str) =>
    IncomingStudentDetailsJson.fromJson(json.decode(str));

String IncomingStudentDetailsJsonToJson(IncomingStudentDetailsJson data) =>
    json.encode(data.toJson());

class IncomingStudentDetailsJson {
  IncomingStudentDetailsJson({
    this.data,
    this.message,
  });

  List<StudentDetails>? data;
  String? message;

  factory IncomingStudentDetailsJson.fromJson(Map<String, dynamic> json) =>
      IncomingStudentDetailsJson(
        data: List<StudentDetails>.from(
            json["data"].map((x) => StudentDetails.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class StudentDetails {
  StudentDetails({
    this.studentId,
    this.studentName,
    this.fatherName,
    this.motherName,
    this.cgpa,
    this.city,
  });

  var studentId;
  var studentName;
  var fatherName;
  var motherName;
  var cgpa;
  var city;

  factory StudentDetails.fromJson(Map<String, dynamic> json) => StudentDetails(
        studentId: json["StudentId"],
        studentName: json["StudentName"],
        fatherName: json["FatherName"],
        motherName: json["MotherName"],
        cgpa: json["Cgpa"].toDouble(),
        city: json["City"],
      );

  Map<String, dynamic> toJson() => {
        "StudentId": studentId,
        "StudentName": studentName,
        "FatherName": fatherName,
        "MotherName": motherName,
        "Cgpa": cgpa,
        "City": city,
      };
}
