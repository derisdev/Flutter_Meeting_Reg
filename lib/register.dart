import 'package:meetingweb/homepage.dart';
import 'package:meetingweb/service/fetchdataUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meetingweb/components/arrow_button.dart';
import 'package:meetingweb/login.dart';
import 'package:meetingweb/utils/viewport_size.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> with SingleTickerProviderStateMixin {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String greeting;

  bool isLoading = false;
  bool isLoginPasien = true;

  @override
  void initState() {
    initGreeting();
    super.initState();
  }



  userRegister () {
    setState(() {
      isLoading = true;
    });
    FetchDataUser fetchData = FetchDataUser();
    fetchData.userRegister(
        usernameController.text, passwordController.text)
        .then((value) {
      if (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }


  initGreeting(){
    var hour = DateTime.now().hour;
    if (hour < 12) {
      setState(() {
        greeting = 'Selamat Pagi';
      });
    }
    if (hour >= 12 && hour < 18) {
      setState(() {
        greeting = 'Selamat Sore';
      });
    }
    else if(hour>=18){
      setState(() {
        greeting = 'Selamat Malam';
      });
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ViewportSize.getSize(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff3e3a63),
      key: _scaffoldKey,
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipPath(
              clipper: CustomShapeClass(),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff3587fc), Color(0xff10c8ff)],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.5, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50),
                        buildText(
                          text: 'Register',
                          padding: EdgeInsets.only(top: height * 0.04),
                          fontSize: width * 0.09,
                          fontFamily: 'YesevaOne',
                        ),
                        buildText(
                          text: greeting,
                          padding: EdgeInsets.only(top: height * 0.04),
                          fontSize: width * 0.09,
                          fontFamily: 'YesevaOne',
                        ),
                        buildText(
                          fontSize: width * 0.04,
                          padding: EdgeInsets.only(
                            top: height * 0.02,
                          ),
                          text: 'Masukkan informasi kamu dibawah',
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 300),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText(
                      text: 'Username',
                      padding: EdgeInsets.only(
                          top: height * 0.04, bottom: height * 0.015),
                      fontSize: width * 0.04,
                    ),
                    inputField(
                      hintText: 'Masukkan username',
                      controller: usernameController,
                      isPassword: false,
                    ),
                    buildText(
                      text: 'Password',
                      padding: EdgeInsets.only(
                        top: height * 0.03,
                        bottom: height * 0.015,
                      ),
                      fontSize: width * 0.04,
                    ),
                    inputField(
                      hintText: 'Password kamu',
                      controller: passwordController,
                      isPassword: true,
                    ),
                    isLoading?
                    Container(
                      width: ViewportSize.width - ViewportSize.width * 0.15,
                      margin: EdgeInsets.only(
                        top: ViewportSize.height * 0.02,
                      ),
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: ViewportSize.width * 0.155,
                        height: ViewportSize.width * 0.155,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: const Color(0xFFFFFFFF),
                          shadows: [
                            BoxShadow(
                              color: const Color(0x55000000),
                              blurRadius: ViewportSize.width * 0.02,
                              offset: Offset(3, 3),
                            ),
                          ],
                        ),
                        child: SpinKitThreeBounce(
                          size: 20,
                          color: Color(0xff3e3a63),
                        ),
                      ),
                    )
                        :

                    InkWell(
                        onTap: (){
                          if(usernameController.text.isNotEmpty && passwordController.text.isNotEmpty){
                            userRegister();
                          }
                          else {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Harap Lengkapi Data')));
                          }
                        },
                        child: const ArrowButton()),
                        Row(
                      children: [
                        buildText(
                          fontSize: width * 0.04,
                          padding: EdgeInsets.only(
                            top: 0,
                          ),
                          text: 'Sudah punya akun?',
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogIn()));
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:250,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildText(
      {double fontSize, EdgeInsets padding, String text, String fontFamily}) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFFFFFFFF),
          fontSize: fontSize,
          fontFamily: fontFamily ?? '',
        ),
      ),
    );
  }

  Widget inputField({String hintText, TextEditingController controller, bool isPassword}){
    return Container(
      width: ViewportSize.width * 0.85,
      alignment: Alignment.center,
      child: Theme(
        data: ThemeData(
          primaryColor: const Color(0x55000000),
        ),
        child: TextField(
          controller: controller,
          obscureText:  isPassword? true  : false ,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ViewportSize.width * 0.025),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: const Color(0xffaeabd6),
            ),
            fillColor: const Color(0xff434372),
            filled: true,
          ),
        ),
      ),
    );
  }

// static Widget buildShape(){
//   return
// }

}



class CustomShapeClass extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    // TODO: implement getClip
    var path = new Path();
    path.lineTo(0, size.height/2.5);
    var firstControlPoint = new Offset(size.width / 4, size.height / 3);
    var firstEndPoint = new Offset(size.width / 2, size.height / 2 - 100);
    var secondControlPoint =
    new Offset(size.width - (size.width / 4), size.height / 2 - 65);
    var secondEndPoint = new Offset(size.width, size.height / 4 - 40);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height / 3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper)
  {
    return true;
  }
}

