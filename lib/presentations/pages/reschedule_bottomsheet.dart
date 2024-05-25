import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BottomsheetReschedule extends StatefulWidget {
  const BottomsheetReschedule({super.key});

  @override
  State<BottomsheetReschedule> createState() => _BottomsheetRescheduleState();
}

class _BottomsheetRescheduleState extends State<BottomsheetReschedule> {
  late int _selectedDayIndex; // Indeks hari yang dipilih
  late DateTime _currentDate; // Tanggal saat ini
  int _selectedTimeIndex = -1; // Indeks jam yang dipilih
  late ScrollController _dateScrollController;
  int _lastSelectedDayIndex = -1; // Indeks hari yang terakhir kali dipilih

  @override
  void initState() {
    super.initState();
    _selectedDayIndex = -1; // Set default ke -1 (tidak ada yang dipilih)
    _currentDate = DateTime.now(); // Set tanggal saat ini
    _dateScrollController = ScrollController();
  }

  // Mendapatkan daftar tanggal dalam satu bulan ini
  List<DateTime> getDatesInMonth() {
    final int daysInMonth =
        DateTime(_currentDate.year, _currentDate.month + 1, 0).day;
    return List.generate(
      daysInMonth,
      (index) => DateTime(_currentDate.year, _currentDate.month, index + 1),
    );
  }

  // Mengganti hari berdasarkan indeks yang dipilih
  void changeDay(int index) {
    if (_lastSelectedDayIndex == index) {
      // Jika diklik dua kali pada hari yang sama, maka reset pilihan hari
      setState(() {
        _selectedDayIndex = -1;
        _selectedTimeIndex = -1; // Reset indeks jam yang dipilih
      });
      _lastSelectedDayIndex = -1;
    } else {
      setState(() {
        _selectedDayIndex = index;
        _selectedTimeIndex = -1; // Reset indeks jam yang dipilih
        _lastSelectedDayIndex =
            index; // Simpan indeks hari yang terakhir kali dipilih
      });
    }
  }

  void changeTime(int index) {
    if (_selectedTimeIndex == index) {
      // Jika diklik dua kali pada jam yang sama, maka reset pilihan jam
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
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Re-Schedule',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    )),
                Divider(
                  color: Colors.black38,
                  thickness: 1,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Anda yakin ingin menjadwalkan',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(107, 114, 128, 1)),
                      ),
                      Text(
                        'ulang janji temu Anda?',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(107, 114, 128, 1)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Jadwal',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                        width: 140,
                       
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:                          
                              Colors.grey,
                          
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                'Sesi 1', // Ubah sesuai rentang jam praktiknya
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      Colors.white ,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '09:00 - 10:00', // Ubah sesuai rentang jam praktiknya
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                       Colors.white ,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                        
                      ),
                      Container(
                        width: 180,
                       
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:                          
                              Colors.grey,
                          
                        ),
                        child: Center(
                          child: Column(
                            children: [
                        
                              Text(
                                '24 April 2024', // Ubah sesuai rentang jam praktiknya
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                       Colors.white ,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'Jam Praktik',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 70,
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
                            width: 110,
                            
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
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                            children: [
                              Text(
                                'Sesi ${index + 1}', // Ubah sesuai rentang jam praktiknya
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '09:00 - 10:00', // Ubah sesuai rentang jam praktiknya
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
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
                                _selectedDayIndex = _datesInMonth.indexWhere(
                                    (date) =>
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
                            setState(() {
                              if (!isPastDay) {
                                changeDay(index);
                              }
                            });
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
                                  offset: Offset(
                                      0, 4), // changes position of shadow
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
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    formattedDate,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
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
                  )
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 140,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 207, 31, 31)),
                            shadowColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors.grey.withOpacity(0.8);
                              },
                            ),
                            elevation:
                                MaterialStateProperty.resolveWith<double>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return 0;
                                }
                                return 5;
                              },
                            ),
                          ),
                          child: const Text(
                            'Batal',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 140,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(34, 100, 136, 1)),
                            shadowColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors.grey.withOpacity(0.8);
                              },
                            ),
                            elevation:
                                MaterialStateProperty.resolveWith<double>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return 0;
                                }
                                return 5;
                              },
                            ),
                          ),
                          child: const Text(
                            'Simpan',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
