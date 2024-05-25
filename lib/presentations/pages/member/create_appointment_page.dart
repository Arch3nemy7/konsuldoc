import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateAppointment extends StatefulWidget {
  const CreateAppointment({Key? key}) : super(key: key);

  @override
  State<CreateAppointment> createState() => _CreateAppointmentState();
}

class _CreateAppointmentState extends State<CreateAppointment> {
  late int _selectedDayIndex; 
  late DateTime _currentDate; 
  int _selectedTimeIndex = -1; 
  late ScrollController _dateScrollController;
  int _lastSelectedDayIndex = -1; 

  @override
  void initState() {
    super.initState();
    _selectedDayIndex = -1; 
    _currentDate = DateTime.now(); 
    _dateScrollController = ScrollController();
  }

  
  List<DateTime> getDatesInMonth() {
    final int daysInMonth =
        DateTime(_currentDate.year, _currentDate.month + 1, 0).day;
    return List.generate(
      daysInMonth,
      (index) => DateTime(_currentDate.year, _currentDate.month, index + 1),
    );
  }

  
  void changeDay(int index) {
    if (_lastSelectedDayIndex == index) {
     
      setState(() {
        _selectedDayIndex = -1;
        _selectedTimeIndex = -1; 
      });
      _lastSelectedDayIndex = -1;
    } else {
      setState(() {
        _selectedDayIndex = index;
        _selectedTimeIndex = -1;
        _lastSelectedDayIndex =
            index; 
      });
    }
  }



  void changeTime(int index) {
    if (_selectedTimeIndex == index) {
     
      setState(() {
        _selectedTimeIndex = -1;
      });
    } else {
      setState(() {
        _selectedTimeIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<DateTime> _datesInMonth = getDatesInMonth();

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
                    offset: Offset(0, 3), 
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 9,
                  ),
                  Icon(
                    Icons.account_circle,
                    size: 130,
                    color: Colors.black,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Profile Doctor',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      Divider(
                        color: Colors.black,
                        thickness: 10.0,
                        height: 10,
                      ),
                      Text('specialist',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          )),
                      Text('lokasi',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(5),
              child: const Column(
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
            ),
            SizedBox(height: 20),
            const Text(
              'Jam Praktik',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 55,
              child: ListView.builder(
                controller: _dateScrollController,
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedTimeIndex;
                  return GestureDetector(
                    onTap: () {
                      if (_selectedTimeIndex == index) {
                        // Jika diklik dua kali, maka reset pilihan jam
                        changeTime(-1);
                      } else {
                        // Jika tidak, maka ganti pilihan jam
                        changeTime(index);
                      }
                    },
                    child: Container(
                      width: 85,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isSelected
                            ? Color.fromRGBO(34, 100, 136, 1)
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Jam ke-${index + 1}',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Tanggal',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    // Tampilkan dialog atau tampilan lain untuk memilih bulan
                    showDatePicker(
                      context: context,
                      initialDate: _currentDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ).then((newDate) {
                      if (newDate != null) {
                        setState(() {
                          _currentDate = newDate;
                          _selectedDayIndex = _datesInMonth.indexWhere((date) =>
                              date.year == newDate.year &&
                              date.month == newDate.month &&
                              date.day ==
                                  newDate
                                      .day); // Menemukan indeks tanggal yang dipilih
                          _selectedTimeIndex =
                              -1; // Reset indeks jam yang dipilih
                        });
                      }
                    });
                  },
                  icon: Icon(Icons.arrow_drop_down),
                ),
              ],
            ),
            Container(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _datesInMonth.length,
                itemBuilder: (context, index) {
                  final date = _datesInMonth[index];
                  final formattedDay =
                      DateFormat.E().format(date).substring(0, 3);
                  final formattedDate = DateFormat('dd').format(date);
                  final isPastDay = date.isBefore(DateTime.now());
                  final isSelected = index == _selectedDayIndex;
                  return GestureDetector(
                    onTap: () {
                      if (!isPastDay) {
                        changeDay(index);
                      }
                    },
                    child: Container(
                      width: 60,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isSelected
                            ? Color.fromRGBO(34, 100, 136, 1)
                            : (isPastDay ? Colors.grey : Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              formattedDay,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Tambahkan fungsi untuk melakukan appointment di sini
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(34, 100, 136, 1)),
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
                child: Text(
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
