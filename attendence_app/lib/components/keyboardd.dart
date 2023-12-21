import 'package:flutter/material.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyPress;

  CustomKeyboard({required this.onKeyPress});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildKey('1'),
            buildKey('2'),
            buildKey('3'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildKey('4'),
            buildKey('5'),
            buildKey('6'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildKey('7'),
            buildKey('8'),
            buildKey('9'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildKey('0'),
            buildKey('⌫'), // Backspace key
          ],
        ),
      ],
    );
  }

  Widget buildKey(String value) {
    return MaterialButton(
      onPressed: () => onKeyPress(value),
      child: Text(value, style: TextStyle(fontSize: 24)),
      padding: EdgeInsets.all(16),
    );
  }
}
