import 'dart:convert';

LuasLahan luasLahanFromJson(String str) => LuasLahan.fromJson(json.decode(str));

String luasLahanToJson(LuasLahan data) => json.encode(data.toJson());

class LuasLahan {
    final bool success;
    final String message;
    final List<LuasLahanData> data;

    LuasLahan({
        required this.success,
        required this.message,
        required this.data,
    });

    factory LuasLahan.fromJson(Map<String, dynamic> json) => LuasLahan(
        success: json["success"],
        message: json["message"],
        data: List<LuasLahanData>.from(json["data"].map((x) => LuasLahanData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class LuasLahanData {
    final String idKomoditi;
    final String namaKomoditi;
    final String luasArea;
    final String tahun;

    LuasLahanData({
        required this.idKomoditi,
        required this.namaKomoditi,
        required this.luasArea,
        required this.tahun,
    });

    factory LuasLahanData.fromJson(Map<String, dynamic> json) => LuasLahanData(
        idKomoditi: json["id_komoditi"],
        namaKomoditi: json["nama_komoditi"],
        luasArea: json["luas_area"],
        tahun: json["tahun"],
    );

    Map<String, dynamic> toJson() => {
        "id_komoditi": idKomoditi,
        "nama_komoditi": namaKomoditi,
        "luas_area": luasArea,
        "tahun": tahun,
    };
}
