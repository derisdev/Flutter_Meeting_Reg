import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meetingweb/admin/detail_meeting.dart';
import 'package:meetingweb/admin/tambah_meeting.dart';
import 'package:meetingweb/login.dart';
import 'package:meetingweb/service/fetchdataMeeting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListMeeting extends StatefulWidget {
  final int index;
  ListMeeting({this.index});
  @override
  _ListMeetingState createState() => _ListMeetingState();
}

class _ListMeetingState extends State<ListMeeting> {

  var scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime currentBackPressTime;


  String username = '';

  List listDataMeeting = [];
  bool isLoading = true;

  @override
  void initState() {
    getAllMeeting();
    super.initState();
  }


  getAllMeeting() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    this.username = username;
    setState(() {
      isLoading = true;
    });
    FetchDataMeeting fetchData = FetchDataMeeting();
    fetchData.getAllDataMeeting().then((value) {
      if (value != false) {
        setState(() {
          listDataMeeting = value;
          isLoading = false;
        });

        if(widget.index!=null){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailMeeting(listDataMeeting[widget.index], widget.index))).then((value){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListMeeting()));
          });
        }

      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  deleteMeeting(int id){

    setState(() {
      isLoading = true;
    });


    FetchDataMeeting fetchDataMeeting = FetchDataMeeting();
    fetchDataMeeting.deleteMeeting(id.toString()).then((value){
      if(value!=false){

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListMeeting()));
        setState(() {
          isLoading = false;
        });
      }
      else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }


  showToast(String text) {
    Fluttertoast.showToast(
        msg:
        text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
        backgroundColor: Colors.lightBlueAccent,
        textColor: Colors.white);
  }



  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xff3e3a63),
        drawer: buildDrawer(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TambahMeeting()));
          },
          child: Container(
            width: 60,
            height: 60,
            child: Icon(
              Icons.add,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Color(0xff3587fc), Color(0xff10c8ff)],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.5, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp)),
          ),
        ),
        body: WillPopScope(
          onWillPop: onWillPop,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: statusbarHeight),
                    height: statusbarHeight + 50,
                    child: Center(
                      child: Text(
                        'Daftar Meeting',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xff3587fc), Color(0xff10c8ff)],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(0.5, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                  ),
                  Positioned(
                      left: 10,
                      top: 30,
                      child: IconButton(
                        icon: Icon(Icons.menu, color: Colors.white,),
                        onPressed: (){
                          scaffoldKey.currentState.openDrawer();
                        },
                      )),
                ],
              ),
              Container(
                height:
                MediaQuery.of(context).size.height - 50 - statusbarHeight,
                child: isLoading
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : listDataMeeting.isEmpty
                    ? Center(
                  child: Text('Belum ada Meeting',
                      style:
                      TextStyle(color: Colors.white, fontSize: 17)),
                )
                    : MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                      itemCount: listDataMeeting.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 20),
                          margin: EdgeInsets.only(
                              top: index == 0 ? 6 : 0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailMeeting(listDataMeeting[index], index)));
                            },
                            child: Dismissible(
                              key: Key('item ${listDataMeeting[index]}'),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction){
                                confirm(context, listDataMeeting[index]);
                                return Future.value(false);
                              },
                              background: Container(
                                child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: ListTile(
                                      trailing: Icon(Icons.delete_forever, color: Colors.lightBlueAccent),
                                    )
                                ),
                              ),
                              child: Card(
                                  color: Color(0xff434372),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20),
                                  ),
                                  child: ListTile(
                                    leading: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: 30,
                                        minHeight: 30,
                                        maxWidth: 30,
                                        maxHeight: 30,
                                      ),
                                      child: Image.asset(
                                        'assets/images/conversation.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    title: Text(
                                      listDataMeeting[index]['title'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    subtitle: Text(
                                      listDataMeeting[index]
                                      ['time'],
                                      style: TextStyle(
                                          color: Color(0xffadaad6)),
                                    ),
                                    trailing: Icon(Icons.chevron_right, color: Color(0xffadaad6)),
                                  )),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildDrawer(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color(0xff3e3a63), //This will change the drawer background to blue.
        //other styles
      ),
      child: Drawer(

        child: ListView(
          children: <Widget>[
            new Container(
              child: new DrawerHeader(
                  child: CircleAvatar(
                      radius: 57,
                      backgroundColor: Color(0xffe6e6e6),
                      backgroundImage: AssetImage('assets/images/account.png')
                  )),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff3587fc), Color(0xff10c8ff)],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.5, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp)),),
            ListTile(
              title: Text(username, style: TextStyle(color: Colors.white, fontSize: 15),),
              leading: Icon(Icons.person, color: Colors.white,),
              onTap: ()  {

              },
            ),

            RaisedButton(
              onPressed: ()async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('is_Meeting', false);
                prefs.setBool('is_admin', false);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn()));
              },
              color: Color(0xff10c8ff),
              child: Text('Logout'),
            )
          ],
        ),
      ),
    );
  }


  Future<Null> confirm(BuildContext context, dynamic dataMeeting) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Konformasi Hapus"),
            content: const Text("Yakin ingin menghapus?"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    deleteMeeting(dataMeeting['id']);
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("Hapus")
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Batal"),
              ),
            ],
          );
        })) {
    }
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
