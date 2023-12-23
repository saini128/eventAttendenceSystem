import 'package:flutter/material.dart';

class browseDatabase extends StatefulWidget {
  const browseDatabase({super.key});

  @override
  State<browseDatabase> createState() => _browseDatabaseState();
}

class _browseDatabaseState extends State<browseDatabase> {
  String rollNo = '';
  TextEditingController num = TextEditingController();
  void keypadController(String a) {
    if (a != "⌫") {
      rollNo += a;
    } else if (rollNo.length > 0 && a == "⌫") {
      rollNo = rollNo.substring(0, rollNo.length - 1);
    }
    num.text = rollNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
