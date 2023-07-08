// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    Key? key,
    required this.cardTitle,
    required this.iconData,
  }) : super(key: key);
  final String cardTitle;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  iconData,
                  size: 30,
                  color: Color(0xff4F7344),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  cardTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xff4F7344),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
