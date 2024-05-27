enum AppointmentFilter {
  upcoming('Mendatang'),
  past('Lampau');

  const AppointmentFilter(this.label);

  final String label;
}
