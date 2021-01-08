import 'package:flutter/material.dart';
import 'package:meetingweb/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin/list_meeting.dart';
import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), (){
      checkIsLogin();
    });
    super.initState();
  }

  void checkIsLogin() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool isLogin = prefs.getBool('is_login');
    // if(isLogin==null){
      // isLogin = false;
    // }
      // if(isLogin){
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      // }
      // else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      // }
  }



  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/splash.png",
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }
}
