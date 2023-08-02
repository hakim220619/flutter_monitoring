import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:monitoring/komoditi/view/komoditi.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../home/view/home.dart';

class KomoditiService {
  static final _client = http.Client();

  static var _tambahRekap =
      Uri.parse('https://monitoring.dlhcode.com/api/tambah_rekapan');
  static send_data(id, provinsi, kabupaten, Kecamatan, tbm, tm, tr, produksi,
      Pekebun, tahun, hasilPanen, keterangan, context) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      var token = preferences.getString('token');
    http.Response response = await _client.post(_tambahRekap,headers: {
        "Accept": "application/json",
        "Authorization": "Bearer " + token.toString(),
      }, body: {
      "id_provinsi": provinsi.toString(),
      "id_kabupaten": kabupaten.toString(),
      "id_kecamatan": Kecamatan.toString(),
      "id_tahun": tahun.toString(),
      "id_komoditi": id.toString(),
      "tbm": tbm.toString(),
      "tm": tm.toString(),
      "tr": tr.toString(),
      "jumlah": hasilPanen.toString(),
      "produksi": produksi.toString(),
      "pekebun": Pekebun.toString(),
      "status": '1',
      "keterangan": keterangan.toString(),
    });
    if (response.statusCode == 200) {
      var rekap = jsonDecode(response.body);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => KomodityPage(),
        ),
        (route) => false,
      );
    }
  }
}
