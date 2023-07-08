// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class DocsCard extends StatelessWidget {
  DocsCard({
    Key? key,
    required this.drImage,
    required this.onTab,
    required this.drName,
    required this.drSpeclization,
  }) : super(key: key);
  final String drName;
  final String drSpeclization;
  final String drImage;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Image.network(
                        drImage,
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          drName,
                          style: TextStyle(
                              fontSize: 24,
                              color: Color(0xff3A6351),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          drSpeclization,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(
                  Icons.chevron_right,
                  size: 35,
                  color: Color(0xff3A6351),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
