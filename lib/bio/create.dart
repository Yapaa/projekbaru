import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:projekbaru/Connection/api.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class TambahData extends StatefulWidget {
  const TambahData({super.key});

  @override
  State<StatefulWidget> createState() {
    return TambahDataState();
  }
}

class TambahDataState extends State<TambahData> {
  final formkey = GlobalKey<FormState>();

  // Controllers for form fields
  TextEditingController namaC = TextEditingController();
  TextEditingController merkC = TextEditingController();
  TextEditingController hargaC = TextEditingController();

  // final ImagePicker _picker = ImagePicker();
  // XFile? _image;
  // Uint8List? _webImageBytes;

  // Future<void> getImage() async {
  //   final img = await _picker.pickImage(source: ImageSource.gallery);
  //   if (img != null) {
  //     setState(() {
  //       _image = img;
  //     });

  //     if (kIsWeb) {
  //       _webImageBytes = await img.readAsBytes();
  //       setState(() {});
  //     }
  //   }
  // }
  // Future<void> uploadImage() async {
  //   if (_image == null) return;

  //   try {
  //     final bytes = await _image!.readAsBytes();
  //     final base64Image = base64Encode(bytes);

  //     final response = await http.post(
  //       Uri.parse('YOUR_SERVER_URL_HERE'),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({"image": base64Image}),
  //     );

  //     if (response.statusCode == 200) {
  //       // Handle success
  //       print("Image uploaded successfully: ${response.body}");
  //     } else {
  //       // Handle error
  //       print("Failed to upload image: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Error uploading image: $e");
  //   }
  // }

  Future<http.Response> createSw() async {
    try {
      Map<String, String> fields = {
        "nama": namaC.text,
        "merk": merkC.text,
        "harga": hargaC.text,
      };

      // if (_image != null) {
      //   if (kIsWeb) {
      //     final bytes = await _image!.readAsBytes();
      //     fields['photo'] = base64Encode(bytes);
      //   } else {
      //     final bytes = File(_image!.path).readAsBytesSync();
      //     fields['photo'] = base64Encode(bytes);
      //   }
      // }

      final response = await http.post(
        Uri.parse(BaseUrl.tambah),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(fields),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        try {
          final data = json.decode(response.body);
          return response;
        } catch (e) {
          print("Error parsing JSON: $e");
          throw Exception("Invalid JSON response: ${response.body}");
        }
      } else {
        print("Failed to send data. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to send data: ${response.body}");
      }
    } catch (e) {
      print("Error sending data: $e");
      rethrow;
    }
  }

  void _onConfirm(BuildContext context) async {
    try {
      http.Response response = await createSw();
      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['message'] ?? 'Failed to save data'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("An error occurred: $e"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menambah Data Siswa"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              // Input Nama
              TextFormField(
                controller: namaC,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Input Merk
              TextFormField(
                controller: merkC,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Merk",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Input Harga
              TextFormField(
                controller: hargaC,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Harga",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Tombol Simpan
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.cyan,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                onPressed: () {
                  _onConfirm(context);
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
