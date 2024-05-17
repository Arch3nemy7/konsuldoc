class Schedule {
  final String idDoctor;
  final String days;
  final DateTime timeStart;
  final DateTime timeEnd;

  Schedule(
      {required this.idDoctor,
      required this.days,
      required this.timeStart,
      required this.timeEnd});
}
