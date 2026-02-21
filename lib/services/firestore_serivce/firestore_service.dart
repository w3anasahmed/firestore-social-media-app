import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(String name, String email) async {
    await firestore.collection('users').add({'name': name, 'email': email});
  }

  Future<String> getUserName(String email) async {
    final snapShot = await firestore.collection('users').get();

    for (var doc in snapShot.docs) {
      if (doc.data()['email'] == email) {
        return doc.data()['name'];
      } else {}
    }
    return 'not found';
  }

  Future<void> addPost(String post, String email) async {
    await firestore.collection('posts').add({
      'post': post,
      'email': email,
      'timeStamp': Timestamp.now(),
    });
  }

  Stream<List<Map<String, dynamic>>> getPostStream() {
    return firestore
        .collection('posts')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return doc.data();
          }).toList();
        });
  }
}
