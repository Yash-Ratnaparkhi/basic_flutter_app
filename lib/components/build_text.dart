import 'package:flutter/material.dart';

Widget buildText(String label, String value) {
  return Table(
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    children: [
      TableRow(
        children: [
          RowText(
            text: label,
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          RowText(
            text: value,
            textStyle: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    ],
  );
}

class RowText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  const RowText({
    super.key,
    required this.text,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
      child: Text(text, style: textStyle),
    );
  }
}
