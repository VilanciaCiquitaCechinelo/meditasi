import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:meditasi/controllers/intl.dart';
import 'dart:async';

import '../loginpage.dart';
import '../models/websitebox_models.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginPage _auth = Get.put(LoginPage());
  int remainingHours = 0;
  int remainingMinutes = 0;
  int remainingSeconds = 0;
  bool isCountingDown = false;
  Timer? countdownTimer;

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Time's Up"),
          content: Text(
            'The countdown has finished.',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void startCountdown(int hours, int minutes) {
    setState(() {
      isCountingDown = true;
      remainingHours = hours;
      remainingMinutes = minutes;
      remainingSeconds = 0; // Reset seconds
    });

    const oneSecond = Duration(seconds: 1);
    countdownTimer = Timer.periodic(oneSecond, (Timer timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else if (remainingMinutes > 0) {
        setState(() {
          remainingMinutes--;
          remainingSeconds = 59;
        });
      } else if (remainingHours > 0) {
        setState(() {
          remainingHours--;
          remainingMinutes = 59;
          remainingSeconds = 59;
        });
      } else {
        // Countdown finished, show the dialog
        setState(() {
          isCountingDown = false;
        });
        timer.cancel(); // Stop the countdown timer
        _showTimeUpDialog(); // Show the dialog when the time is up
      }
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel(); // Cancel the countdown timer when the screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _auth.logout(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hello There,',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '\nYou had a good Sleep last night',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ideal hours of sleep',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center, // Set alignment horizontal ke center
                        children: [
                          SizedBox(height: 60.0),
                          Text(
                            '${7}',
                            style: TextStyle(
                              fontSize: 40.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'h',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' ${30}',
                            style: TextStyle(
                              fontSize: 40.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'm',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 90.0), // Tambahkan jarak horizontal 16.0 pixel
                          ElevatedButton(
                            onPressed: isCountingDown
                                ? null
                                : () {
                              startCountdown(7, 30);
                              setSleepStartTime();
                            },
                            child: Text(
                              'Mulai',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: isCountingDown
                                ? () {
                              // Tombol Stop
                              countdownTimer?.cancel();
                              setState(() {
                                isCountingDown = false;
                                remainingHours = 0;
                                remainingMinutes = 0;
                                remainingSeconds = 0;
                              });
                            }
                                : null,
                            child: Text(
                              ' Stop ',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Remaining Time: ${remainingHours.toString().padLeft(2, '0')}h ${remainingMinutes.toString().padLeft(2, '0')}m ${remainingSeconds.toString().padLeft(2, '0')}s',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30), // Tambahkan jarak antara teks
                      WebsiteLinkBox(url: 'https://www.contohnamawebsite.com'),
                      SizedBox(height: 20), // Tambahkan jarak antara teks
                      WebsiteLinkBox(url: 'https://www.contohnamawebsite.com'),
                      SizedBox(height: 20), // Tambahkan jarak antara teks
                      WebsiteLinkBox(url: 'https://www.contohnamawebsite.com'),
                      SizedBox(height: 40), // Tambahkan jarak antara teks
                      Text(
                        'Sleep Breakdown',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            width: 150,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5), // Background color (light gray)
                              border: Border.all(width: 2, color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Went to bed',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  sleepStartTime ?? 'Not started yet', // Display start sleep time
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 60), // Add some spacing between boxes
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
