import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meetingweb/service/fetchdataMeeting.dart';

class DetailMeetingUser extends StatefulWidget {
  final dynamic dataMeeting;
  final bool isRegistered;
  DetailMeetingUser({this.dataMeeting, this.isRegistered});
  @override
  _DetailMeetingUserState createState() => _DetailMeetingUserState();
}

class _DetailMeetingUserState extends State<DetailMeetingUser> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  double sliderValue = 0;

  bool isLoading = false;
  bool isLoadingScreen = false;

  bool isRegistered = false;

  bool isChange = false;

  @override
  void initState() {
    initDetailMeeting();
    isRegistered = widget.isRegistered;
    super.initState();
  }

  initDetailMeeting() {
    setState(() {
      isLoadingScreen = true;
    });

    setState(() {
      titleController.text = widget.dataMeeting['title'];
      descriptionController.text = widget.dataMeeting['description'];
      timeController.text = widget.dataMeeting['time'];
    });

    setState(() {
      isLoadingScreen = false;
    });

  }

  register(){

    setState(() {
      isLoading = true;
    });
    FetchDataMeeting fetchData = FetchDataMeeting();
    fetchData.registerMeeting(widget.dataMeeting['id'])
        .then((value) {
      if (value!=false) {
        setState(() {
          isLoading = false;
          isRegistered = true;
          isChange = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });

  }

  unRegister(){

    setState(() {
      isLoading = true;
    });
    FetchDataMeeting fetchData = FetchDataMeeting();
    fetchData.unregisterMeeting(widget.dataMeeting['id'])
        .then((value) {
      if (value!=false) {
        setState(() {
          isLoading = false;
          isChange = true;
          isRegistered = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });

  }


  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        backgroundColor: Color(0xff3e3a63),
        key: _scaffoldKey,
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            color: Colors.lightBlueAccent,
            onPressed: isLoading? (){} : () {
              isRegistered? unRegister() : register();
            },
            child: isLoading? SpinKitThreeBounce(
              color: Colors.white,
              size: 30.0,
            ) : Text(
              isRegistered? 'UNREGISTER':
              'REGISTER',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            if(isChange){
              Navigator.pop(context, true);
              return false;
            }
            else {
              Navigator.pop(context, false);
              return false;
            }
          },
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: statusbarHeight),
                  height: statusbarHeight + 50,
                  child: Center(
                    child: Text(
                      'Detail Meeting',
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
                isLoadingScreen? Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2-50-statusbarHeight),
                  child: CircularProgressIndicator(),
                ) : Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 106 - statusbarHeight,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          child: TextField(
                            readOnly: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            controller: titleController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                labelText: 'Title',
                                labelStyle: TextStyle(
                                    fontSize: 13, color: Color(0xffb0aed9)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffb0aed9)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xffb0aed9)))),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          child: TextField(
                            readOnly: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            controller: descriptionController,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                labelText: 'Description',
                                labelStyle: TextStyle(
                                    fontSize: 13, color: Color(0xffb0aed9)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffb0aed9)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xffb0aed9)))),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          child: TextField(
                            readOnly: true,
                            onTap: (){

                            },
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            controller: timeController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                labelText: 'Time',
                                labelStyle: TextStyle(
                                    fontSize: 13, color: Color(0xffb0aed9)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffb0aed9)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xffb0aed9)))),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(height: 20)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

}


