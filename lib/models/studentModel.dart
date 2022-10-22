// To parse this JSON data, do
//
//     final studentDetails = studentDetailsFromJson(jsonString);

import 'dart:convert';

StudentDetails studentDetailsFromJson(String str) =>
    StudentDetails.fromJson(json.decode(str));

String studentDetailsToJson(StudentDetails data) => json.encode(data.toJson());

class StudentDetails {
  StudentDetails({
    this.data,
    this.message,
  });

  List<Datum>? data;
  String? message;

  factory StudentDetails.fromJson(Map<String, dynamic> json) => StudentDetails(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
