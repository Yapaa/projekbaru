import 'package:flutter/material.dart';

class EditDataSiswa extends StatefulWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController emailController,
      namaController,
      alamatController,
      jenis_kelaminController,
      agamaController,
      tanggal_lahirController;

  EditDataSiswa(
      {super.key, required this.formkey,
      required this.emailController,
      required this.namaController,
      required this.alamatController,
      required this.jenis_kelaminController,
      required this.agamaController,
      required this.tanggal_lahirController});

  @override
  EditDataSiswaState createState() => EditDataSiswaState();
}

class EditDataSiswaState extends State<EditDataSiswa> {
  String? selectedValue;
  String? selectedReligion; // Menyimpan nilai yang dipilih
  final agamaController = TextEditingController();
  final jenis_kelaminController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      autovalidateMode: AutovalidateMode.always,
      child: SingleChildScrollView(
        child: Column(
          children: [
            txtEmail(),
            txtNama(),
            txtAlamat(),
            txtGender(),
            txtReligion(),
            txtBirth(),
          ],
        ),
      ),
    );
  }

  txtEmail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0), // Membuat sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.emailController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Email",
          prefixIcon:
              Icon(Icons.person), // Menambahkan ikon di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Masukan Email baru anda.';
          }
          return null;
        },
      ),
    );
  }

  txtNama() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0), // Membuat sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.namaController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Nama Siswa",
          prefixIcon:
              Icon(Icons.person), // Menambahkan ikon di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Masukan Nama Anda.';
          }
          return null;
        },
      ),
    );
  }

  txtAlamat() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0), // Membuat sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.alamatController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Student Address",
          prefixIcon: Icon(Icons.add_home),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
      ),
    );
  }

  txtGender() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Jenis Kelamin',
          prefixIcon: Icon(Icons.mosque), // Anda bisa mengganti ikon jika perlu
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        isExpanded: true,
        hint: const Text(
          'Pilih Jenis Kelamin',
          style: TextStyle(fontSize: 14),
        ),
        items: const [
          DropdownMenuItem(
            value: '1', // ID untuk Laki-laki
            child: Text('Laki-laki', style: TextStyle(fontSize: 14)),
          ),
          DropdownMenuItem(
            value: '2', // ID untuk Perempuan
            child: Text('Perempuan', style: TextStyle(fontSize: 14)),
          ),
        ],
        // Menggunakan selectedValue jika ada, jika tidak, menggunakan nilai dari controller
        value: selectedValue ??
            (jenis_kelaminController.text.isNotEmpty
                ? jenis_kelaminController.text
                : null),
        onChanged: (String? value) {
          setState(() {
            selectedValue = value; // Set nilai yang dipilih
            jenis_kelaminController.text =
                selectedValue!; // Simpan ke controller
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Pilih Jenis Kelamin Anda.';
          }
          return null;
        },
      ),
    );
  }

  txtReligion() {
    List<DropdownMenuItem<String>> items = [
      const DropdownMenuItem(value: '1', child: Text('Islam')),
      const DropdownMenuItem(value: '2', child: Text('Kristen')),
      const DropdownMenuItem(value: '3', child: Text('Katolik')),
      const DropdownMenuItem(value: '4', child: Text('Hindu')),
      const DropdownMenuItem(value: '5', child: Text('Buddha')),
      const DropdownMenuItem(value: '6', child: Text('Konghucu')),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Agama',
          prefixIcon: Icon(Icons.mosque),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        isExpanded: true,
        hint: const Text(
          'Pilih Agama',
          style: TextStyle(fontSize: 14),
        ),
        items: items,
        value: selectedReligion ??
            (agamaController.text.isNotEmpty ? agamaController.text : null),
        onChanged: (String? value) {
          setState(() {
            selectedReligion = value; // Set nilai yang dipilih
            agamaController.text =
                selectedReligion ?? ''; // Simpan ke controller
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Pilih Agama Anda.';
          }
          return null;
        },
      ),
    );
  }

  txtBirth() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0), // Membuat sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.tanggal_lahirController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Student Birthday",
          prefixIcon: Icon(Icons.cake),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        readOnly: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Masukan Tanggal Lahir Anda.';
          }
          return null;
        },
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year - 150),
            lastDate: DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
          );
          if (pickedDate != null) {
            setState(() {
              widget.tanggal_lahirController.text =
                  "${pickedDate.toLocal()}".split(' ')[0];
            });
          }
        },
      ),
    );
  }
}
