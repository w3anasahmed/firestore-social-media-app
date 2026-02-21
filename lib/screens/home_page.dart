import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/custom_drawer.dart';
import 'package:social_app/components/custom_listtile.dart';
import 'package:social_app/components/custom_textfield.dart';
import 'package:social_app/services/auth/auth_serivce.dart';
import 'package:social_app/services/firestore_serivce/firestore_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthSerivce authSerivce = AuthSerivce();

  final FirestoreService firestore = FirestoreService();
  final TextEditingController post = TextEditingController();

  void logout() async {
    authSerivce.signOut();
  }

  void onPressPost() {
    firestore.addPost(post.text, authSerivce.currentUser!.email.toString());
    post.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('H O M E')),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextfield(
                    controller: post,
                    hintText: 'say something',
                    isObscure: false,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    onPressed: () => onPressPost(),
                    icon: Icon(Icons.check, size: 25),
                  ),
                ),
              ],
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
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String email = snapshot.data![index]['email']
                            .toString();
                        String post = snapshot.data![index]['post'].toString();
                        Timestamp time = snapshot.data![index]['timeStamp'];
                        DateTime date = time.toDate();
                        return CustomListtile(
                          email: email,
                          post: post,
                          timestamp: "${date.day}.${date.month}.${date.year}",
                        );
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
}
