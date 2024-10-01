
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  Future<void> push(BuildContext context, {required Widget target}) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => target,
      ),
    );
  }

  Future<void> pushAndRemoveUntil(BuildContext context,
      {required Widget target}) async {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => target,
      ),
          (route) => false,
    );
  }
}

extension MediaQueryExtension on BuildContext {
  double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
}
