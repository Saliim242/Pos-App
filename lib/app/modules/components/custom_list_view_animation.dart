import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ReusableListViewAnimation extends StatelessWidget {
  const ReusableListViewAnimation({
    super.key,
    required this.index,
    required this.widget,
  });

  final int index;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      delay: Duration(milliseconds: 150),
      child: SlideAnimation(
        duration: Duration(milliseconds: 2500),
        curve: Curves.fastLinearToSlowEaseIn,
        child: SlideAnimation(
          //verticalOffset: 30,
          // horizontalOffset: 30,
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 2500),
          child: widget,
        ),
      ),
    );
  }
}
