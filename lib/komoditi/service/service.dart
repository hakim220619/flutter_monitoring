import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:monitoring/komoditi/view/komoditi.dart';

import 'package:shared_preferences/shared_preferences.dart';


class KomoditiService {
  static final _client = http.Client();

  static final _tambahRekap =
      Uri.parse('https://monitoring.dlhcode.com/api/tambah_rekapan');
  // ignore: non_constant_identifier_names
  static send_data(id, provinsi, kabupaten, Kecamatan, tbm, tm, tr, produksi,
      // ignore: non_constant_identifier_names
      Pekebun, tahun, keterangan, context) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
    http.Response response = await _client.post(_tambahRekap,headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      }, body: {
      "id_provinsi": provinsi.toString(),
      "id_kabupaten": kabupaten.toString(),
      "id_kecamatan": Kecamatan.toString(),
      "id_tahun": tahun.toString(),
      "id_komoditi": id.toString(),
      "tbm": tbm.toString(),
      "tm": tm.toString(),
      "tr": tr.toString(),
      "produksi": produksi.toString(),
      "pekebun": Pekebun.toString(),
      "status": '1',
      "keterangan": keterangan.toString(),
    });
    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const KomodityPage(),
        ),
        (route) => false,
      );
    }
  }
}
