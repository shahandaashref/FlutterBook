import 'package:flutter/material.dart';

class Backgrond extends StatelessWidget {
  const Backgrond({super.key});

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.sizeOf(context).width;
    double sizeHieght = MediaQuery.sizeOf(context).height;
    return Container(
      color: Color(0xff91A1ED),
      width: sizeWidth,
      height: sizeHieght,
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: -20,

            child: Container(
              width: sizeWidth*0.2,
              height: sizeHieght*0.2,
              decoration: BoxDecoration(
                color: Color(0xffCDD5F6),
                shape: BoxShape.circle,
              ),
              
            ),
          ),
          Positioned(
              top: -5,
              right: -5,
            child: Container(
            
              width: sizeWidth*0.2,
              height: sizeHieght*0.1,
              decoration: BoxDecoration(
                color: Color(0xffCDD5F6),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              )),
          ),
            Positioned(
              bottom: 30,
              left: -5,
              child: Container(
              width: sizeWidth*0.3,
              height: sizeHieght*0.2,
              decoration: BoxDecoration(
                color: Color(0xffCDD5F6),
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
              )),
            ),
        ],
      ),

    );
  }
}