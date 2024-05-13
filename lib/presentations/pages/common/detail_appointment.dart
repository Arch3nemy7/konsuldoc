import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailAppointment extends StatelessWidget {
  const DetailAppointment({Key? key}) : super(key: key);

  // Function to generate the list of practice hours for each day
  List<Widget> _buildPracticeHours(BuildContext context) {
    return [
      _buildDaySchedule(context, 'Senin', '08:00 - 12:00'),
      _buildDaySchedule(context, 'Selasa', '08:30 - 12:30'),
      _buildDaySchedule(context, 'Rabu', '09:00 - 13:00'),
      _buildDaySchedule(context, 'Kamis', '09:30 - 13:30'),
      _buildDaySchedule(context, 'Jumat', '10:00 - 14:00'),
      _buildDaySchedule(context, 'Sabtu', '10:30 - 14:30'),
      _buildDaySchedule(context, 'Minggu', '11:00 - 15:00'),
    ];
  }

  // Function to build the schedule widget for each day
  Widget _buildDaySchedule(BuildContext context, String day, String schedule) {
    return Row(
      
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        
        children: [
          SizedBox(width: 70,),
           Expanded(
            flex: 5,
             child: Text(
                day,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
           ),
          
       Expanded(
        flex: 10,
         child: Text(
                schedule,
                style: TextStyle(color: Colors.grey),
              ),
       ),
          
        ],
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Janji',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Tambahkan fungsi untuk tombol titik tiga di sini
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 9,
                  ),
                  const Icon(
                    Icons.account_circle,
                    size: 130,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Profile Doctor',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const Divider(
                        color: Colors.black,
                        thickness: 10.0,
                        height: 10,
                      ),
                      Text('specialist',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          )),
                      Text('lokasi',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tentang Saya',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'sd jswqnbvdyweghubsbdbsadks\nskscs ckcskcksckcs\nedednaiddibs',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    const Text(
                      'Jam Praktik :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

              ],
            ),
                const SizedBox(height: 10),
                // Display practice hours for each day
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildPracticeHours(context),
                ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Tambahkan fungsi untuk melakukan appointment di sini
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromRGBO(34, 100, 136, 1)),
                  shadowColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.grey.withOpacity(0.8);
                    },
                  ),
                  elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return 0;
                      }
                      return 5;
                    },
                  ),
                ),
                child: const Text(
                  'Buat Appointment',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
