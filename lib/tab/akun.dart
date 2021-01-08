import 'package:flutter/material.dart';
import 'package:meetingweb/login.dart';
import 'package:meetingweb/service/fetchdataMeeting.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../jadwal_meeting_user.dart';

class Akun extends StatefulWidget {
  @override
  _AkunState createState() => _AkunState();
}

class _AkunState extends State<Akun> {

  List listDataMeeting = [];

  String id = '';
  String nama = '';

  bool isLoading = true;

  @override
  void initState() {
    initDataUser();
    super.initState();
  }

  initDataUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('user_id');
      nama = prefs.getString('username');
    });
    getAllMeetingRegistered();
  }


  getAllMeetingRegistered() async {

    setState(() {
      isLoading = true;
    });
    FetchDataMeeting fetchData = FetchDataMeeting();
    fetchData.getAllMeetingRegistered(id).then((value) {
      if (value != false) {
        setState(() {
          listDataMeeting = value;
          isLoading = false;
        });

      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff3e3a63),
        body: isLoading? Center(
          child: CircularProgressIndicator(),
        ) :  Stack(
        children: [
          buildShape(),
          Positioned(
              top: 80,
              left: 20,
              child: Text(nama, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),)
          ),
          Positioned(
              top: 110,
              left: 20,
              child: Text('${listDataMeeting.length} Meeting', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13),)
          ),
          Positioned(
              top: 40,
              right: 10,
              child: InkWell(
                onTap: () async {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn()));
                },
                child: Container(
                  width: 30,
                  height: 30,
                  child: Image.asset('assets/images/logout.png')
                  ,
                ),
              )
          ),
          Positioned(
              top: 94,
              right: 45,
              child: CircleAvatar(
                radius: 63,
                backgroundColor: Colors.blue[100].withOpacity(0.5),
              )
          ),
          Positioned(
              top: 100,
              right: 50,
              child: CircleAvatar(
                radius: 57,
                backgroundColor: Color(0xffe6e6e6),
                backgroundImage: AssetImage('assets/images/account.png')
              )
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            margin: EdgeInsets.only(top: 250),
            child: ListView(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => JadwalMeetingUser()));
                  },
                  child: Card(
                    color: Color(0xff434372),
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        child: FloatingActionButton(
                          heroTag: null,
                          backgroundColor: Color(0xff434372),
                          child: Image.asset('assets/images/verify.png', width: 20, height: 20,),
                          onPressed: (){

                          },
                        ),
                      ),
                      title: Text('Lihat Jadwal Meeting', style: TextStyle(color: Colors.white)),
                      trailing: Icon(Icons.chevron_right, color: Color(0xffaeabd6),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
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


