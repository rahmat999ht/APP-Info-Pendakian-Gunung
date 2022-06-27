// To parse this JSON data, do
//
//     final modelListGunung = modelListGunungFromJson(jsonString);

import 'dart:convert';

List<ModelGunung> modelGunungFromJson(String str) => List<ModelGunung>.from(
    json.decode(str).map((x) => ModelGunung.fromJson(x)));

String modelGunungToJson(List<ModelGunung> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListDataGunung {
  final List<ModelGunung> modelGunung;
  final ModelProv modelProv;

  ListDataGunung({
    required this.modelGunung,
    required this.modelProv,

  });
}


List<ModelProv> modelProvFromJson(String str) => List<ModelProv>.from(json.decode(str).map((x) => ModelProv.fromJson(x)));

String modelProvToJson(List<ModelProv> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelProv {
    ModelProv({
        required this.idProvinsi,
        required this.namaProvinsi,
    });

    final String idProvinsi;
    final String namaProvinsi;

    factory ModelProv.fromJson(Map<String, dynamic> json) => ModelProv(
        idProvinsi: json["id_provinsi"],
        namaProvinsi: json["nama_provinsi"],
    );

    Map<String, dynamic> toJson() => {
        "id_provinsi": idProvinsi,
        "nama_provinsi": namaProvinsi,
    };
}


class ModelGunung {
  ModelGunung({
    required this.idGunung,
    required this.nama,
    required this.lokasi,
    required this.lat,
    required this.lon,
    required this.deskripsi,
    required this.jalurPendakian,
    required this.infoGunung,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.image5,
    required this.idProvinsi,
  });

  final String idGunung;
  final String nama;
  final String lokasi;
  final String lat;
  final String lon;
  final String deskripsi;
  final String jalurPendakian;
  final String infoGunung;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String idProvinsi;

  factory ModelGunung.fromJson(Map<String, dynamic> json) => ModelGunung(
        idGunung: json["id_gunung"],
        nama: json["nama"],
        lokasi: json["lokasi"],
        lat: json["lat"],
        lon: json["lon"],
        deskripsi: json["deskripsi"],
        jalurPendakian: json["jalur_pendakian"],
        infoGunung: json["info_gunung"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        image4: json["image4"],
        image5: json["image5"],
        idProvinsi: json["id_provinsi"],
      );

  Map<String, dynamic> toJson() => {
        "id_gunung": idGunung,
        "nama": nama,
        "lokasi": lokasi,
        "lat": lat,
        "lon": lon,
        "deskripsi": deskripsi,
        "jalur_pendakian": jalurPendakian,
        "info_gunung": infoGunung,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "image4": image4,
        "image5": image5,
        "id_provinsi": idProvinsi,
      };
}
