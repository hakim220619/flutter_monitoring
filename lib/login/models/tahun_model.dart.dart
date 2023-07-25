// To parse this JSON data, do
//
//     final tahun = tahunFromJson(jsonString);

import 'dart:convert';

Tahun tahunFromJson(String str) => Tahun.fromJson(json.decode(str));

String tahunToJson(Tahun data) => json.encode(data.toJson());

class Tahun {
    final bool success;
    final String message;
    final List<TahunData> data;

    Tahun({
        required this.success,
        required this.message,
        required this.data,
    });

    factory Tahun.fromJson(Map<String, dynamic> json) => Tahun(
        success: json["success"],
        message: json["message"],
        data: List<TahunData>.from(json["data"].map((x) => TahunData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class TahunData {
    final String id;
    final String tahun;
    final String isActive;

    TahunData({
        required this.id,
        required this.tahun,
        required this.isActive,
    });

    factory TahunData.fromJson(Map<String, dynamic> json) => TahunData(
        id: json["id"],
        tahun: json["tahun"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tahun": tahun,
        "is_active": isActive,
    };
}
