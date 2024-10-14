class UserModel {
  final int? id;
  final String email, nama, tglahir, kelamin, agama, alamat;
  UserModel(
      {required this.id,
      required this.email,
      required this.nama,
      required this.tglahir,
      required this.kelamin,
      required this.agama,
      required this.alamat});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      nama: json['nama'],
      tglahir: json['tglahir'],
      kelamin: json['kelamin'],
      agama: json['agama'],
      alamat: json['alamat'],
    );
  }
  Map<String, dynamic> toJson() => {
        'email': email,
        'nama': nama,
        'tglahir': tglahir,
        'kelamin': kelamin,
        'agama': agama,
        'alamat': alamat,
      };
}
