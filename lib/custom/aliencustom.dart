import 'package:flutter/material.dart';
import 'package:flutterlearniti/core/widget/helper.dart';

class Aliencustom extends StatelessWidget {
  const Aliencustom({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: Helper.getResponsiveWidth(context, width: 120),
      height: 2,
      color: const Color.fromARGB(255, 255, 255, 255), 
      margin: EdgeInsets.symmetric(horizontal:Helper.getResponsiveWidth(context, width: 10)),
    );
  }
}