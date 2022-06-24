import 'package:flutter/material.dart';

import '../widgets/shimmer_effect.dart';


class ShimmerLoading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                child:Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Colors.grey.withOpacity(0.3),
                          Colors.grey.withOpacity(0.1),
                          Colors.grey.withOpacity(0.1),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.5, 0.0),
                        stops: [0.0, 1.0,0.0],
                        tileMode: TileMode.clamp),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              ShimmerEffect(13,size.width * 0.3),
            ],
          ),
          ShimmerEffect(13,size.width * 0.8),
          ShimmerEffect(13,size.width * 0.6),
          ShimmerEffect(200,size.width),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
