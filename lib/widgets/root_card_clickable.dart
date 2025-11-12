import 'package:flutter/material.dart';

class RootCardClickable extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  const RootCardClickable({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}