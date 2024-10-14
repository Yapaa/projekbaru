import 'dart:convert';
import 'package:flutter/material.dart';
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

  TextEditingController emailC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  TextEditingController tglahirC = TextEditingController();
  TextEditingController tplahirC = TextEditingController();
  TextEditingController kelaminC = TextEditingController();
  TextEditingController agamaC = TextEditingController();
  String? selectedValue;
  String? selectedReligion;

  Future<http.Response> createSw() async {
    try {
      final response = await http.post(
        Uri.parse(BaseUrl.tambah),
        body: {
          "email": emailC.text,
          "nama": namaC.text,
          "alamat": alamatC.text,
          "kelamin": kelaminC.text, // Ensure that these fields are not null
          "agama": agamaC.text,
          "tglahir": tglahirC.text,
          "tplahir": tplahirC.text,
        },
      );

      if (response.statusCode == 200) {
        print("Data sent successfully: ${response.body}");
      } else {
        print("Failed to send data. Status code: ${response.statusCode}");
      }

      return response;
    } catch (e) {
      print("Error sending data: $e");
      rethrow;
    }
  }

  void _onConfirm(context) async {
    try {
      http.Response response = await createSw();
      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        // If the request is successful and the server returned success
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      } else {
        // Show an error message if the request fails
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['message'] ?? 'Failed to save data'),
        ));
      }
    } catch (e) {
      // Handle the error in case of failure
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
              // Input NISN
              TextFormField(
                controller: emailC,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Input Nama
              TextFormField(
                controller: namaC,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Input Alamat
              TextFormField(
                controller: alamatC,
                decoration: const InputDecoration(
                  labelText: "Alamat",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Dropdown Jenis Kelamin
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Jenis Kelamin",
                  border: OutlineInputBorder(),
                ),
                value: selectedValue ??
                    (kelaminC.text.isNotEmpty ? kelaminC.text : null),
                items: const [
                  DropdownMenuItem(
                    value: "1", // ID untuk Laki-laki
                    child: Text("Laki-laki"),
                  ),
                  DropdownMenuItem(
                    value: "2", // ID untuk Perempuan
                    child: Text("Perempuan"),
                  ),
                ],
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value; // Set nilai yang dipilih
                    kelaminC.text = selectedValue!; // Simpan ke controller
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Jenis Kelamin tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Dropdown Agama
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Agama",
                  border: OutlineInputBorder(),
                ),
                value: selectedReligion ??
                    (agamaC.text.isNotEmpty ? agamaC.text : null),
                items: const [
                  DropdownMenuItem(
                    value: "1", // ID untuk Islam
                    child: Text("Islam"),
                  ),
                  DropdownMenuItem(
                    value: "2", // ID untuk Kristen
                    child: Text("Kristen"),
                  ),
                  DropdownMenuItem(
                    value: "3", // ID untuk Katolik
                    child: Text("Katolik"),
                  ),
                  DropdownMenuItem(
                    value: "4", // ID untuk Hindu
                    child: Text("Hindu"),
                  ),
                  DropdownMenuItem(
                    value: "5", // ID untuk Buddha
                    child: Text("Buddha"),
                  ),
                  DropdownMenuItem(
                    value: "6", // ID untuk Lainnya
                    child: Text("Konghucu"),
                  ),
                ],
                onChanged: (String? value) {
                  setState(() {
                    selectedReligion = value; // Set nilai yang dipilih
                    agamaC.text =
                        selectedReligion ?? ''; // Simpan ke controller
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Agama tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Input Tanggal Lahir
              TextFormField(
                controller: tglahirC,
                decoration: const InputDecoration(
                  labelText: "Tanggal Lahir",
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      tglahirC.text = "${pickedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tanggal lahir tidak boleh kosong";
                  }
                  return null;
                },
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
