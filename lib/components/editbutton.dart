import 'package:flutter/material.dart';

class ReusableElevatedButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData? icon;
  final Widget child;

  const ReusableElevatedButton({
    required this.onTap,
    this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        elevation: 2.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon),
            const SizedBox(width: 4.0),
          ],
          child,
        ],
      ),
    );
  }
}
