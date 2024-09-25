import 'package:flutter/material.dart';

class CommonText extends StatefulWidget {
  const CommonText({super.key, required this.text});
  final String text;
  @override
  State<CommonText> createState() => _CommonTextState();
}

class _CommonTextState extends State<CommonText> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        widget.text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
