import 'package:flutter/material.dart';

class LabeledField extends StatelessWidget {
  final String data;
  final String label;
  const LabeledField({super.key, required this.data, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Text('$label:'),
          Expanded(child: Text(data, textAlign: TextAlign.end)),
        ],
      ),
    );
  }
}
