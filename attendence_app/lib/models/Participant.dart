class Participant {
  final String name;
  final String teamName;
  final int teamId;
  final int rollNo;
  bool attendence;

  Participant(
      {required this.name,
      required this.teamName,
      required this.teamId,
      required this.rollNo,
      this.attendence = false});
}
