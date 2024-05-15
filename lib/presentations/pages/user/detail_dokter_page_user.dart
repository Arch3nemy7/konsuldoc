import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class DetailDokterPageUser extends StatelessWidget {
  const DetailDokterPageUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Dokter'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF6FAFE),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 124.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: kElevationToShadow[4],
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                            NetworkImage('https://www.example.com/avatar.jpg'),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. Mariya Khan',
                            style: TextStyle(
                              color: Color(0xFF1F2A37),
                              fontSize: 20.0,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 1,
                            ),
                          ),
                          Divider(),
                          Text(
                            'Sp. Jantung Pembuluh Darah',
                            style: TextStyle(
                              color: Color(0xFF4B5563),
                              fontSize: 14.0,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                  height:
                      24), // Memberikan jarak antara card dan teks "Tentang Dokter"
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Tentang Dokter',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.50,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ExpandableText(
                  'Mariya Khan, seorang ahli jantung yang berdedikasi, membawa segudang pengalaman ke Pusat Kardiologi Golden Gate di Golden Gate, CA. ',
                  maxLines: 2,
                  animationDuration: Duration(milliseconds: 500),
                  expandText: 'lihat selengkapnya',
                  collapseText: 'lihat lebih sedikit',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                  height:
                      24), // Memberikan jarak antara "Tentang Dokter" dan "Jadwal Praktik"
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Jadwal Praktik',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    letterSpacing: 0.10,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(text: 'SENIN'),
                      WidgetSpan(
                        child: SizedBox(width: 32),
                      ),
                      TextSpan(text: '12.00 - 17.00 WIB\n'),
                      TextSpan(text: 'SELASA'),
                      WidgetSpan(
                        child: SizedBox(width: 20),
                      ),
                      TextSpan(text: '12.00 - 17.00 WIB\n'),
                      TextSpan(text: 'RABU'),
                      WidgetSpan(
                        child: SizedBox(width: 38),
                      ),
                      TextSpan(text: '12.00 - 17.00 WIB\n'),
                      TextSpan(text: 'KAMIS'),
                      WidgetSpan(
                        child: SizedBox(width: 30),
                      ),
                      TextSpan(text: '12.00 - 17.00 WIB\n'),
                      TextSpan(text: 'JUMAT'),
                      WidgetSpan(
                        child: SizedBox(width: 26),
                      ),
                      TextSpan(text: '12.00 - 17.00 WIB'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                  height:
                      24), // Memberikan jarak antara "Jadwal Praktik" dan tombol
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi ketika tombol Buat Janji ditekan
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004C69), // Warna biru
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    minimumSize: const Size(
                        double.infinity, 45), // Lebar tombol memenuhi layar
                  ),
                  child: const Text(
                    'Buat Janji',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
