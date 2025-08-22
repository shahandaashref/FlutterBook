// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutterlearniti/core/widget/helper.dart';

// ignore: must_be_immutable
class Customtextfeild extends StatefulWidget {
  String type;
  final String label;
  final String hintText;
  final Widget icon;
  final String? Function(String?)? validateFunction;
  final TextEditingController? controller;
  
  Customtextfeild({
    super.key,
    required this.type,
    required this.label,
    required this.hintText,
    required this.icon,
    this.controller,
    this.validateFunction,
  });

  @override
  State<Customtextfeild> createState() => _CustomtextfeildState();
}

class _CustomtextfeildState extends State<Customtextfeild> {
  bool showpass=false;
  @override
  void initState() {
    showpass=false;
    super.initState();
  }
  
  @override

  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Helper.getResponsiveHeight(context, height: 24)),
        Text(widget.label, style: theme.textTheme.bodyMedium),
        SizedBox(height: Helper.getResponsiveHeight(context, height: 16)),
        TextFormField(
          validator: widget.validateFunction,
          obscureText: !showpass&&widget.type=='password',
          controller:widget.controller ,
          keyboardType: widget.type == 'email' 
            ? TextInputType.emailAddress 
            : TextInputType.text,
          decoration: InputDecoration(
           // hoverColor: Color(0xff235576),
            //labelText: 'Email',
            suffixIcon: widget.type=='password'?
            IconButton(onPressed: (){
                  setState(() {
                    showpass=!showpass;
                  });
            },
            icon: Icon(
            showpass==true
              ?Icons.remove_red_eye
              :Icons.visibility_off_outlined
              )):
            null,
            border: OutlineInputBorder(
              gapPadding: 7,
              
            ),
            hintText: widget.hintText,
            prefixIcon:widget.icon,


          ),

        ),
      ],
    );
  }
}