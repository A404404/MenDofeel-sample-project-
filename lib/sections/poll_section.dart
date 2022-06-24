import 'package:flutter/material.dart';

import '../widgets/user_info.dart';

class PollSection extends StatefulWidget {
  final Map pollData;
  PollSection(this.pollData);

  @override
  State<PollSection> createState() => _PollSectionState();
}

class _PollSectionState extends State<PollSection> {
  bool isPollSelected = false;
  int? _selectedIndex;
  List? voteList;


  List checkPercentage() {

    int totalVotes = widget.pollData['total'] + 1;
    List votePercantageList = [];
    
    for(int i=0;i<widget.pollData['choices'].length;i++){
      if(_selectedIndex == i){
        votePercantageList.add((widget.pollData['choices'][i]['votes']+1) / totalVotes * 100);
      }
      else{
        votePercantageList.add((widget.pollData['choices'][i]['votes']) / totalVotes * 100);
      }
    }
    return votePercantageList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserInfo(
          userImage: widget.pollData['profile_photo'],
          userName: widget.pollData['fullname'],
          postTime: widget.pollData['publish'],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(widget.pollData['question_text']),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.pollData['choices'].length,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                  isPollSelected = !isPollSelected;
                });
                voteList = checkPercentage();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),

                  gradient: isPollSelected && _selectedIndex == index
                      ? LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                              Colors.redAccent.withOpacity(0.7),
                            Colors.deepOrangeAccent.withOpacity(0.7),
                            Colors.redAccent.withOpacity(0.7),
                              Colors.redAccent
                            ])
                      : LinearGradient(
                          colors: [
                            Colors.grey.withOpacity(0.3),
                            Colors.grey.withOpacity(0.3),
                          ],
                        ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.pollData['choices'][index]['choice_text']),
                    if (isPollSelected)
                      Text(
                          '${voteList![index].round()}%'),
                  ],
                ),
              ),
            );
          },
        ),
        Divider(
          thickness: 1.5,
        ),
      ],
    );
  }
}


