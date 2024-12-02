import 'dart:convert';
import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projekbaru/Connection/api.dart';
import 'package:projekbaru/Models/UserModels.dart';
import 'package:projekbaru/bio/create.dart';
import 'package:projekbaru/bio/detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<UserModel>> sw;

  @override
  void initState() {
    super.initState();
    sw = getSwList();
  }

  Future<List<UserModel>> getSwList() async {
    final startTime = DateTime.now();
    final response =
        await http.get(Uri.parse(BaseUrl.data)).timeout(const Duration(seconds: 10));
    final endTime = DateTime.now();
    print(
        'Network request took ${endTime.difference(startTime).inMilliseconds} milliseconds');

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<UserModel> sw = items.map<UserModel>((json) {
      return UserModel.fromJson(json);
    }).toList();

    return sw;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Data Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<List<UserModel>>(
          future: sw,
          builder:
              (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text("No data found");
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data![index];
                return Card(
                  child: ListTile(
                    // leading: const Icon(Icons.person),
                    trailing: const Icon(Icons.table_rows),
                    title: Text(
                      "${data.merk} - ${data.nama}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.harga.toString()),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailSiswa(sw: data)));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman FormInput
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TambahData()), // Pastikan FormInput benar diimport
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}
