import 'package:flutter/material.dart';

class TextFieldFiveLines extends StatelessWidget {
  const TextFieldFiveLines({
    Key? key,
    required this.title,
    required this.controller,
  }) : super(key: key);
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        controller: controller,
        style: TextStyle(fontSize: 16),
        maxLines: 5,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
          hintText: title,
        ),
      ),
    );
  }
}
