import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

enum Specialist {
  dental(
    label: 'Poli Gigi',
    icon: FluentIcons.dentist_48_regular,
    activeIcon: FluentIcons.dentist_48_filled,
  ),
  pediatrician(
    label: 'Poli Anak',
    icon: FluentIcons.teddy_24_regular,
    activeIcon: FluentIcons.teddy_24_filled,
  ),
  general(
    label: 'Poli Umum',
    icon: FluentIcons.briefcase_48_regular,
    activeIcon: FluentIcons.briefcase_48_filled,
  ),
  obstetrics(
    label: 'Poli Kandungan dan Kebidanan ',
    icon: Icons.pregnant_woman,
    activeIcon: Icons.pregnant_woman,
  ),
  internalMedicine(
    label: 'Poli Penyakit Dalam ',
    icon: Icons.medical_services,
    activeIcon: Icons.medical_services,
  ),
  surgical(
    label: 'Poli Bedah',
    icon: FluentIcons.cut_24_regular,
    activeIcon: FluentIcons.cut_24_filled,
  ),
  dematology(
    label: 'Poli Kulit',
    icon: Icons.face,
    activeIcon: Icons.face,
  ),
  eye(
    label: 'Poli Mata',
    icon: FluentIcons.people_eye_20_regular,
    activeIcon: FluentIcons.people_eye_20_filled,
  ),
  ent(
    label: 'Poli THT',
    icon: Icons.hearing,
    activeIcon: Icons.hearing,
  ),
  cardiology(
    label: 'Poli Jantung',
    icon: FluentIcons.heart_48_regular,
    activeIcon: FluentIcons.heart_48_filled,
  ),
  psychiatry(
    label: 'Poli Psikiatri',
    icon: Icons.psychology,
    activeIcon: Icons.psychology,
  ),
  orthopedic(
    label: 'Poli Orthopedic',
    icon: FluentIcons.dumbbell_28_regular,
    activeIcon: FluentIcons.dumbbell_28_filled,
  ),
  urology(
    label: 'Poli Urologi',
    icon: FluentIcons.water_24_regular,
    activeIcon: FluentIcons.water_24_filled,
  ),
  neurology(
    label: 'Poli Saraf',
    icon: FluentIcons.brain_circuit_24_regular,
    activeIcon: FluentIcons.brain_circuit_24_filled,
  );

  const Specialist(
      {required this.label, required this.icon, required this.activeIcon});

  final String label;
  final IconData icon;
  final IconData activeIcon;
}
