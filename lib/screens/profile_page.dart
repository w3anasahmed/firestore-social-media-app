import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/custom_listtile.dart';
import 'package:social_app/services/auth/auth_serivce.dart';
import 'package:social_app/services/firestore_serivce/firestore_service.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final AuthSerivce authSerivce = AuthSerivce();
  final FirestoreService firestore = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('P R O F I L E')),

      body: Padding(
        padding: EdgeInsetsGeometry.all(25),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.person,
                size: 100,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),

            SizedBox(height: 20),
            //user name
            buildUserName(),

            //email id
            Text(
              authSerivce.currentUser!.email.toString(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: firestore.getPostStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.hasError ||
                      snapshot.data == null) {
                    return Center(child: Text('no data'));
                  } else {
                    List postList = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot post = postList[index];
                        String docID = post.id;

                        Map<String, dynamic> postData =
                            post.data() as Map<String, dynamic>;

                        String email = postData['email'];
                        String postMessage = postData['post'].toString();
                        Timestamp time = postData['timeStamp'];
                        DateTime date = time.toDate();
                        if (email == authSerivce.currentUser!.email) {
                          return CustomListtile(
                            email: email,
                            post: postMessage,
                            timestamp: "${date.day}.${date.month}.${date.year}",

                            deleteable: true,
                            docID: docID,
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUserName() {
    return FutureBuilder<String>(
      future: firestore.getUserName(authSerivce.currentUser!.email.toString()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return const Text("No name");
        }

        return Text(
          snapshot.data!,
          style: TextStyle(
            fontSize: 30,
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}
