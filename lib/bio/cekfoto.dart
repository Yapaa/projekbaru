import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class CekFoto extends StatefulWidget {
  @override
  _CekFotoState createState() => _CekFotoState();
}

class _CekFotoState extends State<CekFoto> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await _picker.pickImage(source: media);
    setState(() {
      // print(img!.path);
      _image = File(img!.path);
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                    getImage(ImageSource.gallery);
                  },
                  child: Text("Galeri Foto"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                    getImage(ImageSource.camera);
                  },
                  child: Text("Kamera"),
                ),
              ],
            ));
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Silakan pilih Sumber Media'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image),
                        Text('Dari Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera),
                        Text('Dari Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: GestureDetector(
                  onTap: () {
                    // myAlert();
                    showOptions();
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    child: _image == null
                        ? CircleAvatar(
                            radius: 100,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: kIsWeb
                                ? Image.network(
                                    _image!.path,
                                    fit: BoxFit.cover,
                                    width:
                                        200, //MediaQuery.of(context).size.width / 5,
                                    height:
                                        200, //MediaQuery.of(context).size.height / 5,
                                  )
                                : Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                    width:
                                        200, //MediaQuery.of(context).size.width / 5,
                                    height:
                                        200, //MediaQuery.of(context).size.height / 5,
                                  ),
                          ),
                  ),
                ) //Image.file(_image!,

                ),
          ],
        ),
      ),
    );
  }
}