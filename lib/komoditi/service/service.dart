import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../home/view/home.dart';

class KomoditiService {
  // static final _client = http.Client();

  // static var _loginUrl = Uri.parse('https://monitoring.dlhcode.com/api/login');
  static send_data(id, Kecamatan, tbm, tm, tr, produksi, pekerja, tahun, context) async {
    print(id);
    print(Kecamatan);
    print(tbm);
    // bool isLoading = false;
    // http.Response response = await _client
    //     .post(_loginUrl, body: {"kecamatan": Kecamatan, "password": password});
    // if (response.statusCode == 200) {
    //   var Users = jsonDecode(response.body);
    //   // print(Users);
    //   SharedPreferences pref = await SharedPreferences.getInstance();
    //   await pref.setString("email", email);
    //   await pref.setString("id_user", Users['user']['id'].toString());
    //   await pref.setString("token", Users['data']);
    //   await pref.setBool("is_login", true);
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //       builder: (BuildContext context) => HomePage(),
    //     ),
    //     (route) => false,
    //   );
    // }
  }
}
