import 'package:flutter/material.dart';
import 'package:flutterlearniti/custom/aliencustom.dart';
import 'package:flutterlearniti/custom/backgrond.dart';
import 'package:flutterlearniti/custom/customwidget.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Backgrond(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Customwidget(
                  text1: 'Be the top with Mindo',
                  text2:
                      'Earn points for each quiz you complete and climb the leaderboard. Ready to become a Quizmaster champion? Tap "Start" to begin!',
                  image: 'assets/welcome/p1.png',
                ),
                const SizedBox(height: 10),
              Align(
  alignment: Alignment.centerRight,
  child: ElevatedButton(
    onPressed: () {
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: const Text('Start'),
  ),
),
Aliencustom(),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
