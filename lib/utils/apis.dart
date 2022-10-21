import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:api_test_app/models/studentModel.dart';

class APIs {
  Future<List<StudentDetails>?> getStudentDetails() async {
    // var uri = Uri.parse('http://192.168.1.19:8081/everyStudent');
    var uri = Uri.parse('http://192.168.33.98:8081/everyStudent');

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      return data.map((e) => StudentDetails.fromJson(e)).toList();
    }
    return null;
  }

  Future<String> updateStudentAPI(var id, sn, fn, mn, cg, ct, idOld, snOld,
      fnOld, mnOld, cgOld, ctOld) async {
    final jsonbody = jsonEncode({
      "StudentId": id,
      "StudentName": sn,
      "FatherName": fn,
      "MotherName": mn,
      "Cgpa": cg,
      "City": ct,
      "StudentIdUpdated": idOld.isEmpty ? id : int.parse(idOld),
      "StudentNameUpdated": snOld.isEmpty ? sn : snOld,
      "FatherNameUpdated": fnOld.isEmpty ? fn : fnOld,
      "MotherNameUpdated": mnOld.isEmpty ? mn : mnOld,
      "CgpaUpdated": cgOld.isEmpty ? cg : double.parse(cgOld),
      "CityUpdated": ctOld.isEmpty ? ct : ctOld
    });
    print(jsonbody);
    // final responseofAPI = await http.put(
    //     Uri.parse('http://192.168.1.19:8081/update'),
    //     headers: {'Content-Type': 'application/json'},
    //     body: jsonbody);
    final responseofAPI = await http.put(
        Uri.parse('http://192.168.33.98:8081/update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonbody);
    print("Code -----> ${responseofAPI.statusCode}");

    print(jsonDecode(responseofAPI.body));
    print(responseofAPI.body);
    return jsonDecode(responseofAPI.body);
  }

  Future<String> deleteStudent(int id) async {
    final jsonbody = jsonEncode(<String, dynamic>{
      "StudentId": id,
    });
    print(jsonbody);
    // final responseofAPI = await http.delete(
    //     Uri.parse('http://192.168.1.19:8081/remove'),
    //     headers: {'Content-Type': 'application/json'},
    //     body: jsonbody);
    final responseofAPI = await http.delete(
        Uri.parse('http://192.168.33.98:8081/remove'),
        headers: {'Content-Type': 'application/json'},
        body: jsonbody);
    print("Code -----> ${responseofAPI.statusCode}");
    return jsonDecode(responseofAPI.body);
  }
}
