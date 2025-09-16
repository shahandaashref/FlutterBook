import 'package:flutter/material.dart';
import 'package:flutterlearniti/custom/aliencustom.dart';
import 'package:flutterlearniti/custom/backgrond.dart';
import 'package:flutterlearniti/custom/customwidget.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:Stack(
        children: [
        const Backgrond(),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Customwidget(text1: 'test your self with Mindo quizes',
                text2: ' Hi, I\'m Mindo! Choose from various categories and challenge yourself with multiple quizzes. Let\'s show the world your genius!',
                image:'assets/welcome/p2.png' ,
                
                    ),
              ],
            ),
          ),
              Aliencustom(),
        ],
      ),
    ); 
    
  }
}