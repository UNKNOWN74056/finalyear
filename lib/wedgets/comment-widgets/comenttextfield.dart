import 'package:flutter/material.dart';

class commenttextfield extends StatelessWidget {
  final TextEditingController controller;

  const commenttextfield({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      cursorWidth: 2,
      controller: controller,
      keyboardType: TextInputType.multiline,
      maxLines: null, // Allows multiple lines
      minLines: 1,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.all(10),
        fillColor: Colors.grey.shade300,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none, // Remove the border
        ),
        hintText: "Type a comment...",
      ),
    );
  }
}
