import 'package:flutter/material.dart';

class RootColumn extends StatelessWidget {
  final String header;
  final List<Widget> children;
  const RootColumn({super.key, required this.header, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('$header:', style: const TextStyle(fontSize: 20.0)),
        const SizedBox(height: 12.0),
        ...children,
      ],
    );
  }
}