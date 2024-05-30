enum AppointmentFilter {
  upcoming('Mendatang'),
  past('Riwayat');

  const AppointmentFilter(this.label);

  final String label;
}
