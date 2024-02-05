import 'package:attendence_app/components/keyboardd.dart';
import 'package:attendence_app/screens/participant.dart';
import 'package:flutter/material.dart';

class browseDatabase extends StatefulWidget {
  const browseDatabase({super.key});

  @override
  State<browseDatabase> createState() => _browseDatabaseState();
}

class _browseDatabaseState extends State<browseDatabase> {
  String studentId = '';
  TextEditingController num = TextEditingController();
  void keypadController(String a) {
    if (a != "⌫") {
      studentId += a;
    } else if (studentId.length > 0 && a == "⌫") {
      studentId = studentId.substring(0, studentId.length - 1);
    }
    num.text = studentId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Enter Participant Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextField(
                  controller: num,
                  textAlign: TextAlign.center,
                  readOnly: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Enter Roll No',
                    counterText: '',
                    contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                )),
            CustomKeyboard(onKeyPress: keypadController),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Participant(
                            studentID: "65c0fe396b68e5b84965310e");
                      },
                    ),
                  );
                },
                child: Text("Submit"))
          ]),
        ),
      ),
    );
  }
}
