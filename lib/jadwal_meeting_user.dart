import 'package:flutter/material.dart';
import 'package:meetingweb/detail_meeting_user.dart';
import 'package:meetingweb/service/fetchdataMeeting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JadwalMeetingUser extends StatefulWidget {
  @override
  _JadwalMeetingUserState createState() => _JadwalMeetingUserState();
}

class _JadwalMeetingUserState extends State<JadwalMeetingUser> {
  List listDataMeeting = [];
  String idUser = '';
  bool isLoading = true;
  bool isLoadingButton = false;

  @override
  void initState() {
    initIdUSer();
    super.initState();
  }

  initIdUSer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idUser = prefs.getString('user_id');
    setState(() {
      this.idUser = idUser;
    });
    getAllMeetingRegistered();
  }

  getAllMeetingRegistered() async {

    setState(() {
      isLoading = true;
    });
    FetchDataMeeting fetchData = FetchDataMeeting();
    fetchData.getAllMeetingRegistered(idUser).then((value) {
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



  registerMeeting(int idMeeting) async {
    setState(() {
      isLoadingButton = true;
    });
    FetchDataMeeting fetchData = FetchDataMeeting();
    fetchData.registerMeeting(idMeeting).then((value) {
      if (value != false) {
        setState(() {
          isLoadingButton = false;
        });
      } else {
        setState(() {
          isLoadingButton = false;
        });
      }
    });
  }

  unregisterMeeting(int idMeeting) async {
    setState(() {
      isLoadingButton = true;
    });
    FetchDataMeeting fetchData = FetchDataMeeting();
    fetchData.unregisterMeeting(idMeeting).then((value) {
      if (value != false) {
        setState(() {
          isLoadingButton = false;
        });
      } else {
        setState(() {
          isLoadingButton = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        backgroundColor: Color(0xff3e3a63),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: statusbarHeight),
              height: statusbarHeight + 50,
              child: Center(
                child: Text(
                  'Jadwal Meeting User',
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
            Container(
              height:
                  MediaQuery.of(context).size.height - 106 - statusbarHeight,
              child: isLoading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : listDataMeeting.isEmpty
                      ? Center(
                          child: Text('Data Kosong',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17)),
                        )
                      : MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView.builder(
                              itemCount: listDataMeeting.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.only(top: index == 0 ? 8 : 0),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailMeetingUser(
                                                        dataMeeting:
                                                            listDataMeeting[
                                                                index],
                                                        isRegistered: true))).then((value){
                                                          if(value!=false){
                                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JadwalMeetingUser()));

                                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        height: 80,
                                        child: Card(
                                            elevation: 0,
                                            color: Color(0xff434372),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                                                title: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10.0),
                                                  child: Text(
                                                    listDataMeeting[index]
                                                        ['title'],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  listDataMeeting[index]
                                                      ['time'],
                                                  style: TextStyle(
                                                      color: Color(0xffadaad6)),
                                                ),
                                               )),
                                      )),
                                );
                              }),
                        ),
            ),
          ],
        ));
  }

}
