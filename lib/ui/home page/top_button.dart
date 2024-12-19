import 'package:flutter/material.dart';

class TopButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const TopButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent, // No background
          side: const BorderSide(color: Color.fromARGB(68, 158, 158, 158), width: 1), // Subtle boundary
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // No rounded corners
          ),
          padding: const EdgeInsets.symmetric(vertical: 12), // Minimal padding
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.black), // Simple text style
        ),
      ),
    );
  }
}
