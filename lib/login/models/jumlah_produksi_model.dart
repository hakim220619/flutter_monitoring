import 'dart:convert';

JumlahProduksi jumlahProduksiFromJson(String str) => JumlahProduksi.fromJson(json.decode(str));

String jumlahProduksiToJson(JumlahProduksi data) => json.encode(data.toJson());

class JumlahProduksi {
    final bool success;
    final String message;
    final List<JumlahProduksiData> data;

    JumlahProduksi({
        required this.success,
        required this.message,
        required this.data,
    });

    factory JumlahProduksi.fromJson(Map<String, dynamic> json) => JumlahProduksi(
        success: json["success"],
        message: json["message"],
        data: List<JumlahProduksiData>.from(json["data"].map((x) => JumlahProduksiData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class JumlahProduksiData {
    final String idKomoditi;
    final String namaKomoditi;
    final String jumlahProduksi;
    final String tahun;

    JumlahProduksiData({
        required this.idKomoditi,
        required this.namaKomoditi,
        required this.jumlahProduksi,
        required this.tahun,
    });

    factory JumlahProduksiData.fromJson(Map<String, dynamic> json) => JumlahProduksiData(
        idKomoditi: json["id_komoditi"],
        namaKomoditi: json["nama_komoditi"],
        jumlahProduksi: json["jumlah_produksi"],
        tahun: json["tahun"],
    );

    Map<String, dynamic> toJson() => {
        "id_komoditi": idKomoditi,
        "nama_komoditi": namaKomoditi,
        "jumlah_produksi": jumlahProduksi,
        "tahun": tahun,
    };
}
