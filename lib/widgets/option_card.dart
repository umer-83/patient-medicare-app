// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  OptionCard({
    Key? key,
    required this.optionTitle,
    required this.optionImage,
    required this.optionSubTitle,
    required this.onTab,
  }) : super(key: key);
  final String optionTitle;
  final String optionSubTitle;
  final String optionImage;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(90.0),
                    child: Image.asset(
                      optionImage,
                      height: 60,
                      width: 60,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        optionTitle,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xff3A6351),
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        optionSubTitle,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff333333),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.chevron_right,
                size: 30,
                color: Color(0xff3A6351),
              )
            ],
          ),
        ),
      ),
    );
  }
}
