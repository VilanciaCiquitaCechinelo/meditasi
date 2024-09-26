import 'package:flutter/material.dart';

class DateBox extends StatelessWidget {
  final String date;
  final VoidCallback onTap;

  DateBox({required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, // Expand to full width
        height: 70, // Set the height to match the item extent
        color: Colors.black.withOpacity(0.5),
        padding: EdgeInsets.all(10), // Remove padding
        margin: EdgeInsets.all(10), // Remove margin
        child: Center(
          child: Text(date, style: TextStyle(fontSize: 18, color: Colors.white)),
        ),
      ),
    );
  }
}

