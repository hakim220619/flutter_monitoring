import 'package:http/http.dart';
import 'package:monitoring/login/models/jumlah_produksi_model.dart';
import 'package:monitoring/login/models/luas_lahan_model.dart';
import 'package:monitoring/login/models/tahun_model.dart.dart';

class GrafikService {
  static const url = 'monitoring.dlhcode.com';
  Future<Tahun> fetchTahun() async {
    final response = await get(
      Uri.http(url, '/api/tahun'),
      headers: {
        'Accept': 'application/json'
      }
    );
    if(response.statusCode == 200){
      return tahunFromJson(response.body);
    } else {
      throw Exception('failed to get tahun');
    }
  }

  Future<LuasLahan> fetchLuasLahan(String tahunId) async {
    final response = await post(
      Uri.http(url, '/api/luas_lahan_by_komoditi'),
      headers: {
        'Accept': 'application/json'
      },body: {
        'id': tahunId
      }
    );
    if(response.statusCode == 200){
      return luasLahanFromJson(response.body);
    } else {
      throw Exception('failed to get luash lahan');
    }
  }

  Future<JumlahProduksi> fetchJumlahProduksi(String tahunId) async {
    final response = await post(
      Uri.http(url, '/api/jumlah_produksi_by_komoditi'),
      headers: {
        'Accept': 'application/json'
      },body: {
        'id': tahunId
      }
    );
    if(response.statusCode == 200){
      return jumlahProduksiFromJson(response.body);
    } else {
      throw Exception('failed to get jumlah produksi');
    }
  }
}