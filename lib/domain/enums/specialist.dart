import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

// TODO: Isi daftar spesialis / poli
enum Specialist {
  dental(
    label: 'Dokter Gigi',
    icon: FluentIcons.dentist_48_regular,
    activeIcon: FluentIcons.dentist_48_filled,
  ),
  pediatrician(
    label: 'Dokter Anak',
    icon: FluentIcons.teddy_24_regular,
    activeIcon: FluentIcons.teddy_24_filled,
  ),
  dental2(
    label: 'Poli Gigi',
    icon: FluentIcons.dentist_48_regular,
    activeIcon: FluentIcons.dentist_48_filled,
  ),
  dental3(
    label: 'Poli Gigi',
    icon: FluentIcons.dentist_48_regular,
    activeIcon: FluentIcons.dentist_48_filled,
  ),
  dental4(
    label: 'Poli Gigi',
    icon: FluentIcons.dentist_48_regular,
    activeIcon: FluentIcons.dentist_48_filled,
  ),
  dental5(
    label: 'Poli Gigi',
    icon: FluentIcons.dentist_48_regular,
    activeIcon: FluentIcons.dentist_48_filled,
  ),
  dental6(
    label: 'Poli Gigi',
    icon: FluentIcons.dentist_48_regular,
    activeIcon: FluentIcons.dentist_48_filled,
  );

  const Specialist(
      {required this.label, required this.icon, required this.activeIcon});

  final String label;
  final IconData icon;
  final IconData activeIcon;
}
