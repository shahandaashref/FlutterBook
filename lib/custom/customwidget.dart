
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class Customwidget extends StatelessWidget {
    final String image;
    final  String text1;
    final  String text2;
  const Customwidget(

    {super.key, required this.image, required this.text1, required this.text2}
    );

  @override
  Widget build(BuildContext context) {

    double sizeWidth = MediaQuery.sizeOf(context).width;
    //double sizeHieght = MediaQuery.sizeOf(context).height;
    return Column(
          children: [
            SizedBox(height: 80,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: sizeWidth*0.8,
                child:
                    Text(text1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),),),
            ),
                SizedBox(
              width: sizeWidth*0.7,
                      child: Text(text2,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                     // fontWeight: FontWeight.bold,
                                    ),),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset(image,),
              ),
              Row(
                children: [
                  Container(
                    width: sizeWidth*0.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff4657A7),
                    ),
                    
                  ),
                  Container(
                    width: sizeWidth*0.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 190, 193, 206),
                    ),),
                ],
              ),
            
              
          ],
        
    );
  }
}