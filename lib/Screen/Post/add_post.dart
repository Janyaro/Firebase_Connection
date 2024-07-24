import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_project1/Components/ReuseBtn.dart';
import 'package:my_project1/Utils/utility.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final databaseRer = FirebaseDatabase.instance.ref('Node');
  final postController = TextEditingController();
  bool isLoading = false;
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Add Post'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                maxLines: 4,
                controller: postController,
                decoration: const InputDecoration(
                    hintText: 'What is in your Mind',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: 'Enter Name', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 30,
              ),
              ReUseBtn(
                  btnTitle: 'ADD',
                  loading: isLoading,
                  ontap: () {
                    setState(() {
                      isLoading = true;
                    });
                    databaseRer
                        .child(DateTime.now().microsecondsSinceEpoch.toString())
                        .child('commit')
                        .set({
                      'title': postController.text.toString(),
                      'name': nameController.text.toString()
                    }).then((value) {
                      setState(() {
                        isLoading = false;
                      });
                      Utils().toastMessage(
                          'Data Successfully save in the database');
                    }).onError((error, stackTrace) {
                      setState(() {
                        isLoading = false;
                      });
                      Utils().toastMessage(error.toString());
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
