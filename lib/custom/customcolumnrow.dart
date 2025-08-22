import 'package:flutter/material.dart';

class Customcolumnrow extends StatelessWidget {
  final String text1;
  final String text2;
  const Customcolumnrow({super.key,required this.text1,required this.text2});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    double sizeHieght = MediaQuery.sizeOf(context).height;
    return Column(
                children: [
                  Text(text1,style: theme.textTheme.headlineMedium,),
                  SizedBox(height: sizeHieght*0.01,),
                  Text(text2,style: theme.textTheme.bodySmall,)
                ],
              );
  }
}