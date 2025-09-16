import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterlearniti/core/widget/helper.dart';
import 'package:flutterlearniti/custom/customtextfeild.dart';
//import 'package:flutterlearniti/welcomePages/userdata.dart';

class RegisterScrean extends StatefulWidget {
  const RegisterScrean({super.key});

  @override
  State<RegisterScrean> createState() => _RegisterScreanState();
}

class _RegisterScreanState extends State<RegisterScrean> {
  final GlobalKey<FormState> _keyform = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userController= TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

    //@override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   //_confirmPasswordController.dispose();
  //   _userController.dispose();
  //   super.dispose();
  // }
//}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/hello/Register.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _keyform,
              child: Container(
                padding: EdgeInsets.all(
                  Helper.getResponsiveWidth(context, width: 40),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    SizedBox(
                      height: Helper.getResponsiveHeight(context, height: 100),
                    ),
                    Text('Register', style: theme.textTheme.displayLarge),
                    //user name
                    Customtextfeild(
                      controller: _userController,
                      type: 'Username',
                      hintText: 'Enter your Username',
                      label: 'Username',
                      icon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.person),
                      ),
                      validateFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Username';
                        }
                        return null;
                      },
                    ),

                    ///email
                    Customtextfeild(
                      controller: _emailController,
                      type: 'email',
                      hintText: 'Enter your email',
                      label: 'Email',
                      icon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.email),
                      ),
                      validateFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email';
                        }
                        return null;
                      },
                    ),

                    ///password
                    Customtextfeild(
                      controller: _passwordController,
                      type: 'password',
                      hintText: 'Enter password',
                      label: 'Password',
                      icon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.lock),
                      ),
                      validateFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    Customtextfeild(
                      type: 'password',
                      hintText: 'Confirm Password',
                      label: 'Confirm Password',
                      icon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.lock),
                      ),
                      
                      validateFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Confirm Password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: Helper.getResponsiveHeight(context, height: 24),
                    ),

                    SizedBox(
                      width: Helper.getResponsiveWidth(context, width: 300),
                      height: Helper.getResponsiveHeight(context, height: 50),
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            final credential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                            Navigator.pushNamedAndRemoveUntil(context, '/home',
                            (Route<dynamic> route) => false,
                            //arguments: Userdata(_emailController.text,_userController.text),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              Helper.showErrorMessage(context,'The password provided is too weak.');
                              // print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              Helper.showErrorMessage(context,'The account already exists for that email.');
                              // print('The account already exists for that email.', );
                            }
                          } catch (e) {
                            print(e);
                          }
                          //Navigator.pop(context);
                        },
                        child: Text('Register'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}