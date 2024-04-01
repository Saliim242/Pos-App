import 'package:flutter/material.dart';

class DisplayErrorContainerCredit extends StatelessWidget {
  const DisplayErrorContainerCredit({
    super.key,
    required this.text,
    this.onTap,
    required this.bgColor,
    required this.fontColor,
  });

  final String text;
  final void Function()? onTap;
  final Color bgColor;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 55,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          "${text}",
          style: TextStyle(
            fontSize: 18,
            color: fontColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
