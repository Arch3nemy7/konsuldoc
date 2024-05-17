import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

// TODO: Isi daftar spesialis / poli
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
  General(
    label: 'Poli Umum',
    icon: FluentIcons.briefcase_48_regular,
    activeIcon: FluentIcons.briefcase_48_filled,
  ),
  Obstetrics(
    label: 'Poli Kandungan dan Kebidanan ',
    icon: Icons.pregnant_woman,
    activeIcon: Icons.pregnant_woman,
  ),
  Internal_Medicine(
    label: 'Poli Penyakit Dalam ',
    icon: Icons.medical_services,
    activeIcon: Icons.medical_services,
  ),
  Surgical(
    label: 'Poli Bedah',
    icon: FluentIcons.cut_24_regular,
    activeIcon: FluentIcons.cut_24_filled,
  ),
  Dematology(
    label: 'Poli Kulit',
    icon: Icons.face,
    activeIcon: Icons.face,
  ),
  Eye(
    label: 'Poli Mata',
    icon: FluentIcons.people_eye_20_regular,
    activeIcon: FluentIcons.people_eye_20_filled,
  ),
  Ent(
    label: 'Poli THT',
    icon: Icons.hearing,
    activeIcon: Icons.hearing,
  ),
  Cardiology(
    label: 'Poli Jantung',
    icon: FluentIcons.heart_48_regular,
    activeIcon: FluentIcons.heart_48_filled,
  ),
  Psychiatry(
    label: 'Poli Psikiatri',
    icon: Icons.psychology,
    activeIcon: Icons.psychology,
  ),
  Orthopedic(
    label: 'Poli Orthopedic',
    icon: FluentIcons.dumbbell_28_regular,
    activeIcon: FluentIcons.dumbbell_28_filled,
  ),
  Urology(
    label: 'Poli Urologi',
    icon: FluentIcons.water_24_regular,
    activeIcon: FluentIcons.water_24_filled,
  ),
  Neurology(
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
