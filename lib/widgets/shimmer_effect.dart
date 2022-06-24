import 'package:flutter/material.dart';

class ShimmerEffect extends StatelessWidget {
  final double height, width;

  ShimmerEffect(this.height, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              Colors.grey.withOpacity(0.3),
              Colors.grey.withOpacity(0.1),
              Colors.grey.withOpacity(0.1),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0, 0.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
