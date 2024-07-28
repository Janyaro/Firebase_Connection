import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project1/Components/ReuseBtn.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:my_project1/Utils/utility.dart';

class Image_upload extends StatefulWidget {
  const Image_upload({super.key});

  @override
  State<Image_upload> createState() => _Image_uploadState();
}

class _Image_uploadState extends State<Image_upload> {
  bool loading = false;
  File? _image;

  final picker = ImagePicker();
  final databaseRef = FirebaseDatabase.instance.ref('Table');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future getImage() async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (pickedImage != null) {
      _image = File(pickedImage.path);
    } else {
      print('Image Not Selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  getImage();
                },
                child: Container(
                  width: 250,
                  height: 200,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: _image != null
                      ? Image.file(_image!.absolute)
                      : Icon(Icons.image),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ReUseBtn(btnTitle: 'Upload', ontap: () async {})
          ],
        ),
      ),
    );
  }
}
