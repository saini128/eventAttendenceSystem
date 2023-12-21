import 'package:attendence_app/models/Participant.dart';
import 'package:attendence_app/dummyDatabase.dart';

class CloudFunctions {
  Participant? fetchData(Database db, int rollNo) {
    for (var participant in db.db) {
      if (participant.rollNo == rollNo) {
        return participant;
      }
    }

    return null;
  }

  Participant? updateAttendance(Database db, int rollNo, bool present) {
    for (var participant in db.db) {
      if (participant.rollNo == rollNo) {
        participant.present = present;
        return participant;
      }
    }

    return null;
  }
}
