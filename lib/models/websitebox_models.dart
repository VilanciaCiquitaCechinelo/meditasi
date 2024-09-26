import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class WebsiteLinkBox extends StatelessWidget {
  final String url; // URL ke website yang ingin dituju

  WebsiteLinkBox({required this.url});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Recommendation for you:', // Teks yang ada di sebelah kiri
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white, // Warna teks
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 20), // Jarak antara teks dan kotak
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue, // Warna latar belakang kotak
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () {
              // Navigasi ke website saat kotak ditekan
              launch(url); // Pastikan untuk mengimpor 'package:url_launcher/url_launcher.dart'
            },
            child: Text(
              'Check It Now', // Teks yang menampilkan tautan
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}