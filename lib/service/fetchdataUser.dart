import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FetchDataUser {

  Future userRegister(String nama, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String baseUrl =
        "http://meetingapi.fillocoffee.web.id/api/v1/user/register";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: {'name': nama, 'password': password});

    print(response.statusCode);
    print(response.body);


    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      int userId = jsonData['user']['id'];
      String username = jsonData['user']['name'];

      prefs.setString('user_id', userId.toString());
      prefs.setString('username', username);

      return true;
    }

    else if (response.statusCode == 500) {
      showToast('User sudah terdaftar');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }

  Future userLogin(String nama, String password, bool isAdmin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String baseUrl =
        "http://meetingapi.fillocoffee.web.id/api/v1/user/signin";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: {'name': nama, 'password': password});


    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      int userId = jsonData['user']['id'];
      String username = jsonData['user']['name'];

      if(isAdmin==true && userId!=1){
        showToast('Anda bukan admin');
        return false;
      }

      prefs.setString('user_id', userId.toString());
      prefs.setString('username', username);



      return true;
    }

    else if (response.statusCode == 404) {
      showToast('Nama atau password salah');
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
