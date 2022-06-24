import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final String userImage;
  final String userName;
  final String postTime;

  UserInfo(
      {required this.userImage,
      required this.userName,
      required this.postTime});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(userImage),
      ),
      title: Text(
        userName,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(postTime),
      trailing: IconButton(
        icon: Icon(
          Icons.more_horiz,
        ),
        onPressed: () {},
      ),
    );
  }
}
