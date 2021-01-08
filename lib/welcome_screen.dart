import 'package:flutter/material.dart';
import 'package:meetingweb/login.dart';
import 'package:slide_to_act/slide_to_act.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3e3a63),
      body:  Stack(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
        ),
        buildShape(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 80,),
              Text('Selamat datang di       ', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20,),
              Text('“Meeting Registration”          ', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),               ),
              SizedBox(height: 140,),
              Text('Meeting Registration adalah kumpulan list meeting dimana user bisa melakukan register dan unregister pada meeting yang ada',
                  style: TextStyle(color: Colors.white, fontSize: 17)),
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height*3/4,
          left:0.0,
          right:0.0,
          bottom:0.0,
          child: Builder(
            builder: (context) {
              final GlobalKey<SlideActionState> _key = GlobalKey();
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SlideAction(
                  key: _key,
                  outerColor: Colors.lightBlueAccent.withOpacity(0.7),
                  onSubmit: () {
                    Future.delayed(
                      Duration(seconds: 1),
                          () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn())),
                    );
                  },
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Geser untuk melanjutkan',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  sliderButtonIcon: Icon(Icons.chevron_right, color: Colors.lightBlueAccent.withOpacity(0.7),),
                ),
              );
            },
          ),
        )
      ]),
    );
  }


  static Widget buildShape(){
    return ClipPath(
      clipper: CustomShapeClass(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff3587fc), Color(0xff10c8ff)],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.5, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp
          ),
        ),
      ),
    );
  }

}



class CustomShapeClass extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    // TODO: implement getClip
    var path = new Path();
    path.lineTo(0, size.height / 4.5);
    var firstControlPoint = new Offset(size.width / 4.5, size.height / 2.4);
    var firstEndPoint = new Offset(size.width / 2.5, size.height / 2.3 - 60);
    var secondControlPoint =
    new Offset(size.width - (size.width / 3), size.height / 2.9 - 65);
    var secondEndPoint = new Offset(size.width, size.height / 5 - 40);

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

