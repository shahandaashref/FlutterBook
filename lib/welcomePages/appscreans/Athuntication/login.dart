import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterlearniti/core/widget/helper.dart';
import 'package:flutterlearniti/custom/aliencustom.dart';
import 'package:flutterlearniti/custom/customtextfeild.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  //bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Password';
    }
    return null;
  }

  List<String> imagepath = [
    'assets/hello/google.svg',
    'assets/hello/facebook.svg',
    'assets/hello/apple.svg',
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/hello/Register.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,

            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(
                  Helper.getResponsiveWidth(context, width: 40),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    SizedBox(
                      height: Helper.getResponsiveHeight(context, height: 50),
                    ),
                    Text('Login', style: theme.textTheme.displayLarge),
                    SizedBox(
                      height: Helper.getResponsiveHeight(context, height: 32),
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
                      validateFunction: _validateEmail,
                    ),

                    ///password
                    Customtextfeild(
                      controller: _passwordController,
                      type: 'password',
                      hintText: 'Enter password',
                      label: 'Password',
                      icon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.local_mall),
                      ),
                      validateFunction: _validatePassword,
                    ),
                    SizedBox(
                      height: Helper.getResponsiveHeight(context, height: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                              activeColor: theme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            Text(
                              "Remember me",
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/forgot-password');
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: theme.colorScheme.primary),
                          ),
                        ),
                      ],
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
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password:  _passwordController.text,
                                );
                            Navigator.pushNamedAndRemoveUntil(context, '/home',
                            (Route<dynamic> route) => false,
                            arguments: {
                              'name': userCredential.user?.displayName ?? '',
                              'email': userCredential.user?.email ?? '',
                            },
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          }

                          // setState(() {
                          
                          // });
                        },

                        child: Text('Login'),
                      ),
                    ),
                    SizedBox(
                      height: Helper.getResponsiveHeight(context, height: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: theme.colorScheme.primary),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Aliencustom(), Text('OR'), Aliencustom()],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(imagepath.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(imagepath[index]),
                          );
                        }),
                      ],
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
