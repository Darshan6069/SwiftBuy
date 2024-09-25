import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GoogleFacebookButton extends StatefulWidget {
  const GoogleFacebookButton({super.key, required this.image});
  final String image;

  @override
  State<GoogleFacebookButton> createState() => _GoogleFacebookButtonState();
}

class _GoogleFacebookButtonState extends State<GoogleFacebookButton> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.07,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 15,
                child: SvgPicture.asset(widget.image)),
            SizedBox(
              width: width * 0.04,
            ),
            const Text(
              'Sign Up with Google',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
