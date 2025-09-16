
import 'package:flutter/material.dart';

import 'package:flutterlearniti/core/widget/helper.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  bool _isExpanded = false;
 @override
  void initState() {
    _isExpanded = false;
    super.initState();
  }

  List<CurveData> curves = [
    CurveData('Linear:', Curves.linear, Colors.amber),
    CurveData('bounceOut:', Curves.bounceOut, Colors.deepPurple),
    CurveData('easeInCirc:', Curves.easeInCirc, Colors.teal),
    CurveData('easeInOutQuint:', Curves.easeInOutQuint, Colors.brown),
    CurveData('easeInExpo:', Curves.easeInExpo, Colors.redAccent),
    CurveData('fastOutSlowIn:', Curves.fastOutSlowIn, Colors.green),
    CurveData('easeInOutCubic:', Curves.easeInOutCubic, Colors.blueAccent),
    CurveData('linearToEaseOut:', Curves.linearToEaseOut, Colors.deepOrange),
    CurveData('slowMiddle:', Curves.slowMiddle, Colors.deepPurpleAccent),
    CurveData('fastEaseInToSlowEaseOut:', Curves.fastEaseInToSlowEaseOut, Colors.purpleAccent),
    CurveData('easeInOutCubicEmphasized:', Curves.easeInOutCubicEmphasized, Colors.blue),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: curves.length,
                itemBuilder: (context, index) {
                  final curve = curves[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Helper.getResponsiveWidth(context, width: 40),
                      vertical: Helper.getResponsiveWidth(context, width: 10),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(curve.curvename),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            width: _isExpanded ? 150.0 : 60,
                            height: 20,
                            curve: curve.curve,
                            decoration: BoxDecoration(
                              color: curve.color,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          
              SizedBox(height: Helper.getResponsiveHeight(context, height: 40)),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text('tap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurveData {
  final String curvename;
  final Curve curve;
  final Color color;
  CurveData(this.curvename, this.curve, this.color);
}