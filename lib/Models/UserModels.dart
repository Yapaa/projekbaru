import 'dart:io';

class UserModel {
  final int id;
  final String nama, merk;
  final int harga;
  UserModel(
      {required this.id,
      required this.nama,
      required this.merk,
      required this.harga,
      });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nama: json['nama'],
      merk: json['merk'],
      harga: json['harga'],
    );
  }
  Map<String, dynamic> toJson() => {
        'nama': nama,
        'merk': merk,
        'harga': harga,
      };
}
