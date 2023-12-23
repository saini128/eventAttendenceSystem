import 'package:attendence_app/screens/participant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Dashboard extends StatelessWidget {
  int present_participants = 80;
  int total_participants = 100;
  int total_teams = 20;
  int present_teams = 18;

  Dashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ccslogo.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 20),
                Text(
                  "Welcome to Dashboard",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print("ScanQR");
                  },
                  child: Text('Scan QR', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 3,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    print("Check Database");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Participant();
                        },
                      ),
                    );
                  },
                  child: Text('Check Database', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 3,
                  ),
                ),
                SizedBox(height: 30),
                Text('Present Participants: ' +
                    present_participants.toString() +
                    '/' +
                    total_participants.toString()),
                SizedBox(height: 10),
                Text('Teams Entered: ' +
                    present_teams.toString() +
                    '/' +
                    total_teams.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
