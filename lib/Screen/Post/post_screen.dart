import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_project1/Screen/Authentication/loginScreen.dart';
import 'package:my_project1/Screen/Post/add_post.dart';
import 'package:my_project1/Utils/utility.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Node');
  final searchController = TextEditingController();
  final editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        title: const Text('Post'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: const Icon(
                Icons.login_outlined,
                color: Colors.white,
              )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(
                hintText: 'Search here', border: OutlineInputBorder()),
            onChanged: (String title) {
              setState(() {});
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: FirebaseAnimatedList(
              defaultChild: Center(child: Text('Loading')),
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                String title = snapshot.child('title').value.toString();
                String id = snapshot.child('id').value.toString();
                if (searchController.text.isEmpty) {
                  return Card(
                    color: Colors.blueGrey[300],
                    child: ListTile(
                        title: Text(
                          snapshot.child('title').value.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          snapshot.child('id').value.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: PopupMenuButton(
                            itemBuilder: (BuildContext context) => [
                                  PopupMenuItem(
                                      child: ListTile(
                                    onTap: () {
                                      ShowMyDialog(title, id);
                                    },
                                    leading: const Icon(Icons.edit),
                                    title: const Text('Edit'),
                                  )),
                                  PopupMenuItem(
                                      child: ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text('Delete'),
                                  ))
                                ])),
                  );
                } else if (title
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase().toString())) {
                  return Card(
                    color: Colors.blueGrey[300],
                    child: ListTile(
                      title: Text(
                        snapshot.child('title').value.toString(),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPostScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> ShowMyDialog(String title, String id) {
    editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update'),
            content: Container(
              child: TextField(
                controller: editController,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.child(id).update({
                      'title': editController.text.toLowerCase()
                    }).then((value) {
                      Utils().toastMessage('Data has been updated');
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  },
                  child: Text('Update')),
            ],
          );
        });
  }
}
