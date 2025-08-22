// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutterlearniti/core/widget/helper.dart';

class Customdrawer extends StatefulWidget {
  final  String name;
  final  String email;
  const Customdrawer({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  State<Customdrawer> createState() => _CustomdrawerState();
}

class _CustomdrawerState extends State<Customdrawer> {
  List<String>routes=[
    '/home',
    '/profile',
    '/settings',
  ];

  navroutes(int index){
    Navigator.pop(context);
    Navigator.pushNamed(context, routes[index]);
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          
          UserAccountsDrawerHeader(accountName:Text(widget.name) ,accountEmail:Text(widget.email) ,
          currentAccountPicture: ClipOval(
            
            child: Image.asset('assets/hello/profile.jpg',width: Helper.getResponsiveWidth(context, width: 100),height: Helper.getResponsiveHeight(context, height: 100),),)),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: (){
              navroutes(0);
              
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: (){
              navroutes(1);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: (){
              navroutes(2);
            },
          ),
        ],
      ),
    );
  }
}