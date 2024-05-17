import 'package:flutter/material.dart';

class MemberDetailPage extends StatelessWidget {
  const MemberDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Pasien'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF6FAFE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 75,
              backgroundImage:
                  NetworkImage('https://via.placeholder.com/120x120'),
            ),
            const SizedBox(height: 20),
            buildDetailRow('Nama', 'Budi Hariyanto'),
            buildDetailRow('Nomor Ponsel', '+1232-12456789'),
            buildDetailRow('Jenis Kelamin', 'Laki-laki'),
            buildDetailRow('Tanggal Lahir', '2 Maret 1984'),
            buildDetailRow('Alamat', 'Jl. Jayanegara No 102, Surabaya',
                isMultiline: true),
            const SizedBox(height: 20),
            buildDetailRow('Jadwal', ''),
            const SizedBox(height: 10),
            buildScheduleBox('01:00 PM'),
            const SizedBox(height: 10),
            buildScheduleBox('Jumat 1 Maret 2024'),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String title, String value,
      {bool isMultiline = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment:
            isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              ': $value',
              style: const TextStyle(
                color: Color(0xFF757B82),
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildScheduleBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF71787E),
        borderRadius: BorderRadius.circular(5),
        boxShadow: kElevationToShadow[4],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
