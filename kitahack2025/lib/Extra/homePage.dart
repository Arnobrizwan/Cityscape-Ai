import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitahack2025/Extra/crud.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService _firestoreService =
      FirestoreService();
  final TextEditingController nameController =
      TextEditingController();
  final TextEditingController ageController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firestore CRUD")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                ),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(
                    labelText: "Age",
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    String id =
                        DateTime.now()
                            .millisecondsSinceEpoch
                            .toString();
                    String name =
                        nameController.text.trim();
                    int age = int.parse(
                      ageController.text.trim(),
                    );

                    await _firestoreService.addUser(
                      id,
                      name,
                      age,
                    );
                    nameController.clear();
                    ageController.clear();
                  },
                  child: Text("Add User"),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestoreService.getUsers(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var users = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    var user = users[index];
                    String id = user.id;
                    String name = user["name"];
                    int age = user["age"];

                    return ListTile(
                      title: Text(name),
                      subtitle: Text("Age: $age"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              _showUpdateDialog(
                                id,
                                name,
                                age,
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              await _firestoreService
                                  .deleteUser(id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showUpdateDialog(
    String id,
    String currentName,
    int currentAge,
  ) {
    nameController.text = currentName;
    ageController.text = currentAge.toString();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Update User"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                ),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(
                    labelText: "Age",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  String updatedName =
                      nameController.text.trim();
                  int updatedAge = int.parse(
                    ageController.text.trim(),
                  );

                  await _firestoreService.updateUser(
                    id,
                    updatedName,
                    updatedAge,
                  );
                  Navigator.pop(context);
                },
                child: Text("Update"),
              ),
            ],
          ),
    );
  }
}
