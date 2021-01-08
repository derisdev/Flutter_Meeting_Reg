import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meetingweb/tab/akun.dart';
import 'package:meetingweb/tab/jadwal_meeting.dart';


class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {


  DateTime currentBackPressTime;



  final pages = [
    JadwalMeeting(),
    Akun()
  ];

  int selectedIndex = 0;


  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
              icon: Icon(Icons.timelapse_rounded, size: 20,),
              title: Text('Meeting', style: TextStyle(fontSize: 13))
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded,size: 20,),
              title: Text('Akun', style: TextStyle(fontSize: 13))
          ),
        ],
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Color(0xff10c8ff),
        onTap: onTap,
      ),
      // membuat objek dari kelas TabBarView
      body: WillPopScope(child: pages.elementAt(selectedIndex), onWillPop: onWillPop),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'tekan sekali lagi untuk keluar');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
