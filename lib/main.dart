import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterlearniti/core/mytheme.dart';
import 'package:flutterlearniti/provider/bookprovider.dart';
import 'package:flutterlearniti/provider/savedprovider.dart';
import 'package:flutterlearniti/allapppages/appscreans/Athuntication/forgotpassword.dart';
import 'package:flutterlearniti/allapppages/appscreans/Athuntication/login.dart';
import 'package:flutterlearniti/allapppages/appscreans/Athuntication/register.dart';
import 'package:flutterlearniti/allapppages/appscreans/bookstoreitem.dart';
import 'package:flutterlearniti/allapppages/appscreans/dachbourd.dart';
import 'package:flutterlearniti/allapppages/appscreans/homescrean.dart';
import 'package:flutterlearniti/allapppages/appscreans/introscrean.dart';
import 'package:flutterlearniti/allapppages/appscreans/saved.dart';
import 'package:flutterlearniti/allapppages/appscreans/search.dart';
import 'package:flutterlearniti/allapppages/appscreans/settings.dart';
import 'package:provider/provider.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

// // Ideal time to initialize
// await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Savedprovider()),
        ChangeNotifierProvider(create: (context) => BooksProvider()),
      ],
      child: DevicePreview(
        enabled: true,
        builder: (context) => MyApp(), // Wrap your app
      ),
    ),
  );
}


class MyApp extends StatefulWidget {
  @override
  

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: MyPaperbackTheme.theme,
      initialRoute:'/intoscrean',
      routes: {
        '/booksing': (context) => Bookstoreitem(),
        '/register': (context) => RegisterScrean(),
        'login': (context) => LoginPage(),
        '/forgot-password':(context)=>Forgotpassword(),
        '/intoscrean': (context) => IntroScrean(),
        '/home': (context) => HomeScreen(),
        //'/library': (context) => Librarybookscreen(),
        '/profile':(context)=>ProfilePage(),
        '/settings':(context)=>Settings(),
        '/search':(context)=>Search(),
        //'/dashboard':(context)=>Dashboard(),
        //'/book-details':(context)=>BookDetailsPage()
        '/saved':(context)=>Saved(),
      },
    );
  }
}
