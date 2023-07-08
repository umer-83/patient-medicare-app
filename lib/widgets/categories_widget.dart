// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../typography/bold_16_black.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    Key? key,
    required this.categoryTitle,
    required this.categoryImage,
    required this.onTab,
  }) : super(key: key);
  final String categoryTitle;
  final String categoryImage;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                // image: AssetImage('assets/images/c1.png'),
                image: AssetImage(categoryImage),
                width: 60,
                height: 60,
              ),
              SizedBox(height: 10),
              Bold16Black(
                title: categoryTitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
