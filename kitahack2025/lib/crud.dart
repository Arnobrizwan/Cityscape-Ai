import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // CREATE: Add a new user
  Future<void> addUser(
    String id,
    String name,
    int age,
  ) async {
    await _db.collection("users").doc(id).set({
      "name": name,
      "age": age,
    });
  }

  // READ: Get all users as a stream
  Stream<QuerySnapshot> getUsers() {
    return _db.collection("users").snapshots();
  }

  // UPDATE: Update user details
  Future<void> updateUser(
    String id,
    String name,
    int age,
  ) async {
    await _db.collection("users").doc(id).update({
      "name": name,
      "age": age,
    });
  }

  // DELETE: Remove a user
  Future<void> deleteUser(String id) async {
    await _db.collection("users").doc(id).delete();
  }
}
