import "dart:io";

import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;
  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Photo Gallery'),
            onPressed: () {},
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: showOptions,
            child: Text('Select Image'),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: _image == null
                  ? Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFe0f2f1),
                      ),
                      child: Column(
                        children: [
                        Icon(Icons.camera_alt),
                        Text(" Tidak Ada Gambar ")
                      ],
                      ),
                    )
                  : kIsWeb
                      ? Image.network(
                          _image!.path,
                          fit: BoxFit.fill,
                          width: 200,
                          height: 200,
                        )
                      : Image.file(
                          _image!,
                          fit: BoxFit.fill,
                          width: 200,
                          height: 200,
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
