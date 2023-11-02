import 'package:flutter/material.dart';

class RotatingBackground extends StatefulWidget {
  const RotatingBackground({super.key});

  @override
  _RotatingBackgroundState createState() => _RotatingBackgroundState();
}

class _RotatingBackgroundState extends State<RotatingBackground> {
  int currentPageIndex = 0;
  List<String> imagePaths = [
    'assets/mountain.jpg',
    'assets/ocean.jpg',
    'assets/plains.jpg',
    'assets/forest.jpg',
    'assets/swamp.jpg',
  ];

  void _changePage(int newIndex) {
    setState(() {
      currentPageIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        int newIndex = (currentPageIndex + 1) % imagePaths.length;
        _changePage(newIndex);
      },
      child: Image.asset(
        imagePaths[currentPageIndex],
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
