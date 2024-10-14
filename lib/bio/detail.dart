import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projekbaru/Connection/api.dart';
import 'dart:convert';
import 'package:projekbaru/Models/UserModels.dart';
import 'package:projekbaru/bio/update.dart';

class DetailSiswa extends StatefulWidget {
  final UserModel sw;
  const DetailSiswa({super.key, required this.sw});

  @override
  _DetailSiswaState createState() => _DetailSiswaState();
}

class _DetailSiswaState extends State<DetailSiswa> {
  void deleteSiswa(context) async {
    http.Response response = await http.post(Uri.parse(BaseUrl.hapus), body: {
      'id': widget.sw.id.toString(),
    });
    pesan() {
      Fluttertoast.showToast(
          msg: "Penghapusan Data Berhasil",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    final data = json.decode((response.body));
    if (data['success']) {
      pesan();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  void confirmDelete(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('Apakah Anda yakin menghapus data ini?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Icon(Icons.cancel),
              ),
              ElevatedButton(
                  onPressed: () => deleteSiswa(context),
                  child: const Icon(Icons.check_circle))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Siswa'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => confirmDelete(context),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ID : ${widget.sw.id}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Email : ${widget.sw.email}",
              style: const TextStyle(fontSize: 20),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Text(
              "Nama : ${widget.sw.nama}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Alamat : ${widget.sw.alamat}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Gender : ${widget.sw.kelamin}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Agama : ${widget.sw.agama}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Tanggal Lahir : ${widget.sw.tglahir}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Nama : ${widget.sw.nama}",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman FormInput
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Edit(sw: widget.sw)), // Pastikan FormInput benar diimport
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.edit),
      ),
    );
  }
}
