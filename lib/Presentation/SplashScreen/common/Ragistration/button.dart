import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({super.key, required this.buttonName});
  final String buttonName;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      // ignore: sort_child_properties_last
      child:  Center(
          child: Text(
            widget.buttonName,
            style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          )),
      height: height*0.08,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade900),
    );
  }
}
