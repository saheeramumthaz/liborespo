import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:infolibra/screens/common/loginpage.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a long loading process
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to the next screen once the splash screen is done
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Ensure the splash screen fills the entire screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),



      body: Container(

        color: Colors.teal,
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(100),


        child: Column(
          children:[Image.asset('assets/img/logo.png'),
          Text('InfoLibra',style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.w800),)]
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Enable system overlays when disposing of the splash screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }
}
