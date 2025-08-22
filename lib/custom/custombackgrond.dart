import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Custombackgrond extends StatelessWidget {
  const Custombackgrond({super.key});

  @override
  Widget build(BuildContext context) {
      double sizeWidth = MediaQuery.sizeOf(context).width;
    double sizeHieght = MediaQuery.sizeOf(context).height;
    return Container(

      width: sizeWidth,
      height: sizeHieght,
      decoration: BoxDecoration(
        color: Colors.white//Color(0xff292731)
      ),
      child:
      Align(
        alignment: Alignment.bottomCenter,
        child: SvgPicture.asset('assets/pig/BG Bottom.svg',
        width: sizeWidth,
        )
        ),
      //  Column(
      //     children: [
          
      //       Container(
      //         width: sizeWidth,
      //         height: sizeHieght*0.5,
      //         decoration: BoxDecoration(
      //           color: Color.fromARGB(255, 255, 255, 255),
      //           borderRadius: BorderRadius.only(
      //             bottomLeft:Radius.circular(180),
      //             bottomRight:Radius.circular(180)
      //           ),
      //         ),
      //       ),
      //     ],
      // ),

    );
  }
}