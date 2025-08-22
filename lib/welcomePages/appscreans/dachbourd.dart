import 'package:flutter/material.dart';
import 'package:flutterlearniti/custom/customnavbar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Customnavbar(),
      body: Container(
        child: Column(
          children: [
            Text('Dashbaord'),
            Container(
              child: Column(
                children: [
                  Image.asset(''),
                  Text(''),
                  Text(''),
                  Text('',),
                  Text(''),
                  
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}