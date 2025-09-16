import 'package:flutter/material.dart';
import 'package:flutterlearniti/core/widget/helper.dart';

// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutterlearniti/custom/custombackgrond.dart';

class IntroScrean extends StatefulWidget {
  const IntroScrean({super.key});

  @override
  State<IntroScrean> createState() => _IntroScreanState();
}

class _IntroScreanState extends State<IntroScrean> {
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    double sizeWidth = MediaQuery.sizeOf(context).width;
    double sizeHieght = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Helper.getResponsiveWidth(context, width: 20),
            vertical: Helper.getResponsiveHeight(context, height: 30),
          ),
          width: sizeWidth,
          height: sizeHieght,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/pig/Intro Screen.png',
              ), 
              fit: BoxFit.cover,
            ),
          ),

          // const Custombackgrond(),
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Helper.getResponsiveHeight(context, height: 30)),
                Text(
                  'Paperback.',
                  style: TextStyle(
                    color: Color(0xff292731),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Helper.getResponsiveHeight(context, height: 30)),
                Image.asset(
                  'assets/pig/Open Doodles Studying.png',
                  width: Helper.getResponsiveWidth(context, width: 200),
                ),
                //SvgPicture.asset('assets/pig/l1.svg'),
                SizedBox(height: Helper.getResponsiveHeight(context, height:30)),

                Padding(
                padding:  EdgeInsets.symmetric(horizontal: Helper.getResponsiveWidth(context, width: 25),vertical: Helper.getResponsiveWidth(context, width: 20)),
                  child: Column(
                    children: [
                      Text(
                        'A NEW WAY TO READ',
                        style: TextStyle(color: Color(0xffFF6C6C)),
                      ),
                      SizedBox(height: Helper.getResponsiveHeight(context, height: 30)),
                  
                  Text(
                    'Start reading the world’s best books for free today',
                    style:theme.textTheme.titleLarge
                  ),
                  SizedBox(height: Helper.getResponsiveHeight(context, height: 20)),
                  
                  Text(
                    'The first completely free audio book library with the latest world titles available right now.',
                  ),
                    ],
                  ),
                ),
              
                Spacer(),
                ElevatedButton(onPressed: () {
                  Navigator.pushNamed(context, 'login');
                }, child: Text('Get Started')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




