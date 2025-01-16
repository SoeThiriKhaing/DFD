import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double width;
  final double height;
  final TextStyle textStyle;

  const ReusableButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFFFFC740), // Default color
    this.width = double.infinity,
    this.height = 50.0, // Default height
    this.textStyle = const TextStyle(color: Colors.white),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: Size(width, height),
        ),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
