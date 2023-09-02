import 'package:flutter/material.dart';

class CustomSendButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomSendButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          color: Colors.green,
        ),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        child: Row(
          children: const [
            Icon(
              Icons.send, // WhatsApp send icon
              size: 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
