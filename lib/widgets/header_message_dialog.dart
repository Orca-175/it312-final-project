import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:it312_final_project/extensions/string_utilities.dart';

class HeaderMessageDialog extends StatelessWidget {
  final String header;
  final String message;
  final TextButton action;
  const HeaderMessageDialog({super.key, required this.header, required this.message, required this.action});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(header, style: const TextStyle(fontSize: 20.0)),
            const SizedBox(height: 8.0),
            Text(message),
            const SizedBox(height: 12.0),
            action,
          ],
        ),
      ),
    );
  }
}