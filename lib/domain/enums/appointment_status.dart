enum AppointmentStatus {
  pending('Pending'),
  approved('Disetujui'),
  rejected('Ditolak'),
  cancelled('Dibatalkan');

  const AppointmentStatus(this.label);

  final String label;
}
