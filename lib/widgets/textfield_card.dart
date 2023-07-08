// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextFieldItem extends StatelessWidget {
  const TextFieldItem({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;

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
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
        ),
      ),
    );
  }
}
