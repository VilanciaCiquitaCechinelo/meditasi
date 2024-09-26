import 'package:flutter/material.dart';
import 'package:meditasi/views/API_views.dart';

class MusicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.jpg'), // Ganti dengan path yang sesuai
                  fit: BoxFit.cover,
                ),
              ),
            ),
            TrackList(),
          ],
        ),
      ),
    );
  }
}
