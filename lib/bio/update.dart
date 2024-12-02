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

  late TextEditingController
      namaController,
      merkController,
      hargaController,

  Future; editSw() async {
    return await http.post(Uri.parse(BaseUrl.edit), body: {
      "id": widget.sw.id.toString(),
      "nama": namaController.text,
      "merk": merkController.text,
      "harga": hargaController.text
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
    namaController = TextEditingController(text: widget.sw.nama);
    merkController = TextEditingController(text: widget.sw.merk);
    hargaController = TextEditingController(text: widget.sw.harga.toString());
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
          child: FormView(
            formkey: formkey,
            namaController: namaController,
            merkController: merkController,
            hargaController: hargaController,
          ),
        ),
      ),
    );
  }
}
