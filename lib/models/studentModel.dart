class StudentDetails {
  var studentId;
  var studentName;
  var fatherName;
  var motherName;
  var cg;
  var city;

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
