import 'package:flutter/material.dart';

class CustomListtile extends StatelessWidget {
  final String email;
  final String post;
  final String timestamp;
  const CustomListtile({
    super.key,
    required this.email,
    required this.post,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),

      child: ListTile(
        title: Text(post, style: TextStyle(fontSize: 16)),
        subtitle: Text(email, style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(timestamp.toString()),
      ),
    );
  }
}
