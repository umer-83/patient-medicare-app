import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({
    Key? key,
    required this.onChange, this.cIndex,
  }) : super(key: key);
  final Function(int) onChange;
  final cIndex;

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: GNav(
          gap: 8,
          activeColor: Colors.white,
          iconSize: 30,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          duration: const Duration(milliseconds: 800),
          tabBackgroundColor: const Color(0xff3A6351),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.notification_add_rounded,
              text: 'Requests',
            ),
            GButton(
              icon: Icons.search_off_outlined,
              text: 'Doctors',
            ),
            GButton(
              icon: Icons.dehaze,
              text: 'More',
            ),
          ],
          selectedIndex: widget.cIndex,
          onTabChange: widget.onChange,
        ),
      ),
    );
  }
}
