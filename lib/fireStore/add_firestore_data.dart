import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_project1/Components/ReuseBtn.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_project1/Utils/utility.dart';

class AddFireStoreDataScreen extends StatefulWidget {
  const AddFireStoreDataScreen({super.key});

  @override
  State<AddFireStoreDataScreen> createState() => _AddFireStoreDataScreenState();
}

class _AddFireStoreDataScreenState extends State<AddFireStoreDataScreen> {
  final noteController = TextEditingController();
  final fireStoe = FirebaseFirestore.instance.collection('user');
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Add FireStoreData',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: noteController,
              maxLines: 5,
              decoration: const InputDecoration(
                  hintText: "What's in you Mind", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            ReUseBtn(
                btnTitle: 'Add',
                loading: loading,
                ontap: () {
                  setState(() {
                    loading = true;
                  });
                  String id = DateTime.now().microsecondsSinceEpoch.toString();
                  fireStoe.doc(id).set({
                    'title': noteController.text.toString(),
                    'id': id
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage('Data Saved');
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                })
          ],
        ),
      ),
    );
  }
}
