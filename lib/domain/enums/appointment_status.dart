enum AppointmentStatus {
  waiting("Menunggu"),
  done("Selesai");

  const AppointmentStatus(this.label);

  final String label;
}
