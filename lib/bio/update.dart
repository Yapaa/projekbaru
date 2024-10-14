import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:projekbaru/Connection/api.dart';
import 'package:projekbaru/Models/UserModels.dart';
import 'package:projekbaru/bio/form.dart';

class Edit extends StatefulWidget {
  final UserModel sw;

  const Edit({super.key, required this.sw});

  @override
  State<StatefulWidget> createState() => EditState();
}

class EditState extends State<Edit> {
  final formkey = GlobalKey<FormState>();

  late TextEditingController emailController,
      namaController,
      alamatController,
      jenis_kelaminController,
      agamaController,
      tanggal_lahirController;

  Future editSw() async {
    return await http.post(Uri.parse(BaseUrl.edit), body: {
      "id": widget.sw.id.toString(),
      "email": emailController.text,
      "nama": namaController.text,
      "alamat": alamatController.text,
      "kelamin": jenis_kelaminController.text,
      "agama": agamaController.text,
      "tglahir": tanggal_lahirController.text
    });
  }

  pesan() {
    Fluttertoast.showToast(
        msg: "Perubahan data berhasil",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _onConfirm(context) async {
    http.Response response = await editSw();
    final data = json.decode(response.body);
    if (data['success']) {
      pesan();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    emailController = TextEditingController(text: widget.sw.email);
    namaController = TextEditingController(text: widget.sw.nama);
    alamatController = TextEditingController(text: widget.sw.alamat);
    jenis_kelaminController = TextEditingController(text: widget.sw.kelamin);
    agamaController = TextEditingController(text: widget.sw.agama);
    tanggal_lahirController = TextEditingController(text: widget.sw.tglahir);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Siswa",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4.0,
      ),
      bottomNavigationBar: BottomAppBar(
          child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange,
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        onPressed: () {
          _onConfirm(context);
        },
        child: Text("Update"),
      )),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: EditDataSiswa(
            formkey: formkey,
            emailController: emailController,
            namaController: namaController,
            alamatController: alamatController,
            jenis_kelaminController: jenis_kelaminController,
            agamaController: agamaController,
            tanggal_lahirController: tanggal_lahirController,
          ),
        ),
      ),
    );
  }
}
