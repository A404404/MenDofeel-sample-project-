import 'package:flutter/material.dart';

import '../widgets/user_info.dart';

class ForumSection extends StatefulWidget {
  final Map forumData;

  ForumSection(this.forumData);

  @override
  State<ForumSection> createState() => _ForumSectionState();
}

class _ForumSectionState extends State<ForumSection> {
  int? currrentLikes;
  bool? isLiked;
  bool checkLike = false;

  @override
  void initState() {
    super.initState();
    currrentLikes = widget.forumData['likescount'];
    isLiked = widget.forumData['is_liked'];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserInfo(
          userImage: widget.forumData['anon'] == false
              ? widget.forumData['profile_photo']
              : "https://cdn4.vectorstock.com/i/1000x1000/00/93/account-vector-38560093.jpg",
          userName: widget.forumData['anon'] == false
              ? widget.forumData['fullname']
              : "Anonymous User",
          postTime: widget.forumData['publishtime'],
        ),
        GestureDetector(
          onDoubleTap: () {
            if (!checkLike) {
              setState(() {
                checkLike = true;
                currrentLikes = currrentLikes! + 1;
                isLiked = !isLiked!;
              });
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(widget.forumData['question']),
              ),
              if (widget.forumData['post_photo'] != null)
                Container(
                  child: Image.network(widget.forumData['post_photo']),
                ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(
                      isLiked! ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      checkLike = !checkLike;
                      setState(() {
                        if (checkLike) {
                          currrentLikes = currrentLikes! + 1;
                        } else {
                          currrentLikes = currrentLikes! - 1;
                        }
                        isLiked = !isLiked!;
                      });
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(currrentLikes.toString()),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.comment,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("4"),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                alignment: Alignment.bottomRight,
                child: Icon(Icons.arrow_back),
              ),
            )
          ],
        ),
        Divider(
          thickness: 1.5,
          height: 0,
        ),
      ],
    );
  }
}
