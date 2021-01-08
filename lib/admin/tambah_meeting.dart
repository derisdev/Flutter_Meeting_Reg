import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meetingweb/admin/list_meeting.dart';
import 'package:meetingweb/service/fetchdataMeeting.dart';

class TambahMeeting extends StatefulWidget {
  @override
  _TambahMeetingState createState() => _TambahMeetingState();
}

class _TambahMeetingState extends State<TambahMeeting> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new  GlobalKey<ScaffoldState>();

  double sliderValue = 0;

  bool isLoading = false;
  bool isLoadingScreen = false;


  @override
  void initState() {
    super.initState();

  }

  addDataMeeting(Map dataMeeting){
    setState(() {
      isLoading = true;
    });
    FetchDataMeeting fetchData = FetchDataMeeting();
    fetchData.storeDataMeeting(dataMeeting)
        .then((value) {
      if (value!=false) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListMeeting()));
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
        body: SingleChildScrollView(
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
                height: MediaQuery.of(context).size.height - 50 - statusbarHeight,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Container(
                        height: 50,
                        child: TextField(
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 13),
                          controller: titleController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
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
                          textAlign: TextAlign.left,
                          style:
                          TextStyle(color: Colors.white, fontSize: 13),
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
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(1920, 3, 5),
                                maxTime: DateTime.now(),
                                theme: DatePickerTheme(
                                    headerColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    itemStyle: TextStyle(
                                        color: Color(0xffb0aed9), fontWeight: FontWeight.bold, fontSize: 13),
                                    doneStyle: TextStyle(color: Color(0xffb0aed9), fontSize: 13)),
                                onChanged: (date) {

                                }, onConfirm: (date) {
                                  setState(() {
                                    timeController.text = date.toString().split('.').first;
                                  });
                                }, currentTime: DateTime.now(), locale: LocaleType.id);
                          },
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 13),
                          controller: timeController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.edit,
                                  color: Colors.white, size: 13),
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
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: titleController.text.isNotEmpty && descriptionController.text.isNotEmpty && timeController.text.isNotEmpty
                           ? Colors.lightBlueAccent : Colors.lightBlueAccent.withOpacity(0.5),
                          onPressed: isLoading? (){} : () {
                            {
                              if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty && timeController.text.isNotEmpty

                              ){


                                Map dataMeeting = {
                                  'title': titleController.text,
                                  'description':  descriptionController.text,
                                  'time': timeController.text,
                                };
                                addDataMeeting(dataMeeting);
                              }
                              else {
                                Fluttertoast.showToast(
                                    msg:
                                    'Harap isi semua data',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    fontSize: 14.0,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white);
                              }}
                          },
                          child: isLoading? SpinKitThreeBounce(
                            color: Colors.white,
                            size: 30.0,
                          ) : Text(
                            'Selanjutnya',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
