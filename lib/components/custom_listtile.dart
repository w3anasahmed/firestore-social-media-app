import 'package:flutter/material.dart';
import 'package:social_app/services/firestore_serivce/firestore_service.dart';

class CustomListtile extends StatelessWidget {
  final String email;
  final String post;
  final String timestamp;
  final bool deleteable;
  final String docID;

  CustomListtile({
    super.key,
    required this.email,
    required this.post,
    required this.timestamp,
    required this.deleteable,
    required this.docID,
  });

  final FirestoreService firebase = FirestoreService();

  void delete() async {
    await firebase.deletePost(docID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),

      child: deleteable
          ? ListTile(
              title: Text(post, style: TextStyle(fontSize: 16)),
              subtitle: Text(timestamp.toString()),
              trailing: IconButton(
                onPressed: () => delete(),
                icon: Icon(Icons.delete),
              ),
            )
          : ListTile(
              title: Text(post, style: TextStyle(fontSize: 16)),
              subtitle: Text(
                email,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Text(timestamp.toString()),
            ),
    );
  }
}
