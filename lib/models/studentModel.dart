class StudentDetails {
  int? studentId;
  String? studentName;
  String? fatherName;
  String? motherName;
  var cg;
  String? city;

  StudentDetails(this.studentId, this.studentName, this.fatherName,
      this.motherName, this.cg, this.city);

  StudentDetails.fromJson(Map<String, dynamic> json) {
    studentId = json['StudentId'];
    studentName = json['StudentName'];
    fatherName = json['FatherName'];
    motherName = json['MotherName'];
    cg = json['Cgpa'];
    city = json['City'];
  }
}
