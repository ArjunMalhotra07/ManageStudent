import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  CustomField({Key? key, required this.hintText, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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

class CustomTextStyle extends StatelessWidget {
  var title;
  CustomTextStyle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.purpleAccent,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
