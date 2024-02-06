import 'package:HackTU/components/keyboardd.dart';
import 'package:HackTU/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String passk = '';
  bool showErrorBorder = false;
  TextEditingController passkey = TextEditingController();
  void keypadController(String a) {
    if (passk.length < 4 && a != "⌫") {
      passk += a;
      showErrorBorder = false;
    } else if (passk.length > 0 && a == "⌫") {
      passk = passk.substring(0, passk.length - 1);
      showErrorBorder = false;
    }
    passkey.text = passk;
    if (passk == "5461") {
      print("password matched");
      passkey.text = '';
      passk = '';
      showErrorBorder = false;
      setState(() {});
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Dashboard();
          },
        ),
      );
    } else if (passk.length == 4) {
      showErrorBorder = true;
    } else {
      showErrorBorder = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 150,
                    child: Image(image: AssetImage('assets/ccslogo.png'))),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "HackTU Attendence Portal",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: TextField(
                      controller: passkey,
                      obscureText: true,
                      readOnly: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: 'Enter passkey',
                        counterText: '',
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: showErrorBorder
                                  ? Colors.red
                                  : Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: showErrorBorder
                                  ? Colors.red
                                  : Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: showErrorBorder
                                  ? Colors.red
                                  : Colors.transparent),
                        ),
                      ),
                    )),
                CustomKeyboard(onKeyPress: keypadController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
