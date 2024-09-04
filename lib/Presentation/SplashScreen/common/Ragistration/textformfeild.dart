import 'package:flutter/material.dart';

class TextForm extends StatefulWidget {
  const TextForm({super.key, required this.controller, required this.hint, required this.Icons});

  final TextEditingController controller;
  final String hint;
  final IconData Icons;

  @override
  State<TextForm> createState() => _TextForm();
}

class _TextForm extends State<TextForm> {
  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_outlined),
        hintText: widget.hint,
        border: const OutlineInputBorder(
            borderSide: BorderSide(width: 2),
            borderRadius: BorderRadius.all(Radius.circular(15))),
      ),
    );
  }
}
