import 'package:api_test_app/utils/customWidgets.dart';
import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        height: 50,
        width: 50,
        color: Colors.red,
      )),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        height: 50,
        width: 50,
        color: Colors.blue,
      )),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        height: 50,
        width: 50,
        color: Colors.pink,
      )),
    );
  }
}

class PageOriginal extends StatelessWidget {
  PageOriginal({Key? key}) : super(key: key);
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      children: [Page1(), Page2(), Page3()],
      controller: _controller,
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Container(
      height: 20,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 50, 50, 10),
          child: SingleChildScrollView(
            child: Column(children: [
              CustomReadOnlyField(hintText: "ID"),
              box,
              CustomReadOnlyField(hintText: "Student's Name"),
              box,
              CustomReadOnlyField(hintText: "Father's Name"),
              box,
              CustomReadOnlyField(hintText: "Mother's Name"),
              box,
              CustomReadOnlyField(hintText: "CGPA"),
              box,
              CustomReadOnlyField(hintText: "City"),
              box,
              const Text(
                "Add Student",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
