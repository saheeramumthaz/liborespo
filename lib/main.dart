import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:infolibra/screens/admin/adminpage.dart';
import 'package:infolibra/screens/common/loginpage.dart';
import 'package:infolibra/screens/common/registerpage.dart';
import 'package:infolibra/screens/common/splash_page.dart';

import 'package:infolibra/screens/user/issue_book.dart';
import 'package:infolibra/screens/user/studentpage.dart';
import 'package:infolibra/screens/user/teacherpage.dart';

import 'book_page.dart';
import 'firebase_options.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
       initialRoute: '/',
       routes: {
         '/':(context)=>SplashScreen(),
        'login':(context)=>LoginPage(),
         'register':(context)=>RegisterPage(),
         'admin':(context)=>AdminPage(),
         'teacher':(context)=>TeacherPage(),
         'student':(context)=>StudentPage(),
         'book':(context)=>BookPage()

      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.teal.shade600,
        appBarTheme: AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(color: Colors.white,fontSize: 18),

            iconTheme:  IconThemeData(color: Colors.white)
        ),
        textTheme: TextTheme(
            displayLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
            displaySmall:TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,

            )
        ),),

    );
  }
}
