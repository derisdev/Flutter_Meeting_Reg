import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FetchDataMeeting {


  Future storeDataMeeting(Map dataMeeting) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id');

    dataMeeting['user_id'] = userId;

    String baseUrl =
        "http://meetingapi.fillocoffee.web.id/api/v1/meeting";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: dataMeeting);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);

      return jsonData['meeting'];
    }

    else if (response.statusCode == 404) {
      showToast('Data tidak ditemukan');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }

  Future updateDataMeeting(int idMeeting, String title, String description, String time) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id');

    String baseUrl =
        "http://meetingapi.fillocoffee.web.id/api/v1/meeting/$idMeeting";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: {
          'title': title,
          'description': description,
          'time': time,
          'user_id' : userId,
          '_method' : 'PATCH'

        });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {

      return true;
    }

    else if (response.statusCode == 404) {
      showToast('Data tidak ditemukan');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }


  Future getAllDataMeeting() async {

    String baseUrl =
        "http://meetingapi.fillocoffee.web.id/api/v1/meeting";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"});

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['meetings'];
    }

    else if (response.statusCode == 404) {
      showToast('Data tidak ditemukan');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }



  Future getAllMeetingRegistered(String idUser) async {

    String baseUrl =
        "http://meetingapi.fillocoffee.web.id/api/v1/meeting/$idUser";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"});

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['user']['meetings'];
    }

    else if (response.statusCode == 404) {
      showToast('Data tidak ditemukan');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }


  Future deleteMeeting(String idMeeting) async {

    String baseUrl =
        "http://meetingapi.fillocoffee.web.id/api/v1/meeting/$idMeeting";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
    body: {
      '_method' : 'DELETE'
    });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    }

    else if (response.statusCode == 404) {
      showToast('Data tidak ditemukan');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }


  Future registerMeeting(int idMeeting) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id');

    Map body = {
      "user_id" : userId,
      "meeting_id" : idMeeting.toString(),
    };

    String baseUrl =
        "http://meetingapi.fillocoffee.web.id/api/v1/meeting/registration";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: body);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201) {
      return true;
    }

    else if (response.statusCode == 404) {
      showToast('Data tidak ditemukan');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }


  Future unregisterMeeting(int idMeeting) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id');

    Map body = {
      "user_id" : userId,
      "_method" : 'DELETE'
    };

    String baseUrl =
        "http://meetingapi.fillocoffee.web.id/api/v1/meeting/registration/$idMeeting";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: body);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    }

    else if (response.statusCode == 404) {
      showToast('Data tidak ditemukan');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }

}



showToast(String text) {
  Fluttertoast.showToast(
      msg:
      text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 14.0,
      backgroundColor: Colors.grey,
      textColor: Colors.white);
}
