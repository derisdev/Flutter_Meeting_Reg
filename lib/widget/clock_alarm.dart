import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class PageViewPlayer extends StatefulWidget {
  final String time;
  final dynamic jadwalMinum;
  PageViewPlayer({Key key, @required this.time, this.jadwalMinum}) : super(key:key);
  @override
  _PageViewPlayerState createState() => _PageViewPlayerState();
}

class _PageViewPlayerState extends State<PageViewPlayer> {

  CountdownTimerController controller;

  String deskripsi = '';

  @override
  void initState() {
    initDeskripsi();

    initCountDown();
    super.initState();
  }
  initDeskripsi(){
    setState(() {
      deskripsi = widget.jadwalMinum['terapi']+' x '+widget.jadwalMinum['dosis'].split('x').last;
    });
  }

  initCountDown(){

    int jam =  int.parse(widget.time.split(':').first);
    int menit =  int.parse(widget.time.split(':').last);

    DateTime dateNow = DateTime.now();
    DateTime alarmTime = DateTime(dateNow.year, dateNow.month, dateNow.day,jam, menit);

    int difference = alarmTime.difference(dateNow).inSeconds;

    if(difference<0){
      DateTime alarmTime = DateTime(dateNow.year, dateNow.month, dateNow.day,jam, menit).add(Duration(days: 1));

      difference = alarmTime.difference(dateNow).inSeconds;
    }

    print(difference);


    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * difference;
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {
    print('onEnd');
  }






  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff3587fc), Color(0xff10c8ff)],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.5, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                ),
              ),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 10,color: Colors.blue[100].withOpacity(0.5),style: BorderStyle.solid)
                    ),
                    child: Center(
                      child: Text(
                        widget.time,
                        style: new TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Text(
                    deskripsi,
                    style: new TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ),
            Container(
                height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width,
                color: Color(0xff3e3a63),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Center(
                        child: CountdownTimer(
                          controller: controller,
                          widgetBuilder: (_, CurrentRemainingTime time) {
                            if (time == null) {
                              return Text('Game over');
                            }
                            return Text(
                                '${time.hours==null?'00':time.hours} : ${time.min==null? '00' : time.min} : ${time.sec}', style: new TextStyle(
                              fontSize: 40.0,
                              color: Colors.white,
                            ),);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    SizedBox(height: 30,),
                    Text(
                      'Hitung mundur',
                      style: new TextStyle(
                        fontSize: 17.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
            ),
          ],
        )
      ),
    );
  }
}
