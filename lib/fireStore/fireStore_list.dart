import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project1/Screen/Authentication/loginScreen.dart';
import 'package:my_project1/Utils/utility.dart';
import 'package:my_project1/fireStore/add_firestore_data.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final _auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance.collection('user').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('user');
  final editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FireStore', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error has occurd in the data');
                        }

                        return Card(
                          child: ListTile(
                            title: Text(
                                snapshot.data!.docs[index]['title'].toString()),
                            subtitle: Text(
                                snapshot.data!.docs[index]['id'].toString()),
                            trailing: PopupMenuButton(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                    child: ListTile(
                                  onTap: () {
                                    String title = snapshot
                                        .data!.docs[index]['title']
                                        .toString();
                                    String id = snapshot.data!.docs[index]['id']
                                        .toString();
                                    showMyDialog(title, id);
                                    print('main edit hoon');
                                  },
                                  leading: Icon(Icons.edit),
                                  title: Text('Edit'),
                                )),
                                PopupMenuItem(
                                    child: ListTile(
                                  onTap: () {
                                    String id = snapshot.data!.docs[index]['id']
                                        .toString();
                                    ref.doc(id).delete();
                                  },
                                  leading: Icon(Icons.delete),
                                  title: Text('Delete'),
                                ))
                              ],
                            ),
                          ),
                        );
                      }),
                );
              })
        ],
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 60,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddFireStoreDataScreen()));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepPurple,
        ),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update'),
            content: TextField(
              controller: editController,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    ref
                        .doc(id)
                        .update({'title': editController.text.toString()}).then(
                            (value) {
                      Utils().toastMessage('Data Update');
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }
}
