import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:konsuldoc/presentations/controllers/appointment_controller.dart';
import 'package:konsuldoc/presentations/controllers/doctor_controller.dart';

@RoutePage()
class CreateAppointmentPage extends ConsumerStatefulWidget {
  final String idDoctor;
  const CreateAppointmentPage({Key? key, required this.idDoctor})
      : super(key: key);

  @override
  ConsumerState<CreateAppointmentPage> createState() =>
      _CreateAppointmentPageState();
}

class _CreateAppointmentPageState extends ConsumerState<CreateAppointmentPage> {
  late int _selectedDayIndex;
  late DateTime _currentDate;
  int _selectedTimeIndex = -1;
  late ScrollController _dateScrollController;
  int _lastSelectedDayIndex = -1;
  final TextEditingController _complaintsController = TextEditingController();

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
        _lastSelectedDayIndex = index;
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

  void createAppointment() {
    final complaints = _complaintsController.text;
    final DateTime selectedDate = _currentDate.add(Duration(days: _selectedDayIndex));
    final int selectedTime = _selectedTimeIndex;

    ref
        .read(appointmentControllerProvider)
        .add(widget.idDoctor, selectedDate, selectedTime, complaints)
        .then((value) {
      if (value) context.maybePop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<DateTime> datesInMonth = getDatesInMonth();

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
      body: ref.watch(fetchDoctorByIdProvider(widget.idDoctor)).when(data: (appointment) {
        return Container(
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
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
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
            const SizedBox(height: 20),
            const Text(
              'Jam Praktik',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
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
                        changeTime(-1);
                      } else {
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
                            ? const Color.fromRGBO(34, 100, 136, 1)
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
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
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Tanggal',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: _currentDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ).then((newDate) {
                      if (newDate != null) {
                        setState(() {
                          _currentDate = newDate;
                          _selectedDayIndex = getDatesInMonth().indexWhere((date) =>
                              date.year == newDate.year &&
                              date.month == newDate.month &&
                              date.day == newDate.day);
                          _selectedTimeIndex = -1;
                        });
                      }
                    });
                  },
                  icon: const Icon(Icons.arrow_drop_down),
                ),
              ],
            ),
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: datesInMonth.length,
                itemBuilder: (context, index) {
                  final date = datesInMonth[index];
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
                            ? const Color.fromRGBO(34, 100, 136, 1)
                            : (isPastDay ? Colors.grey : Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
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
            TextFormField(
              controller: _complaintsController,
              decoration: InputDecoration(
                labelText: 'Masukkan keluhan sakit',
                hintText: 'Masukkan keluhan sakit...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: createAppointment,
                child: const Text('Buat Janji'),
              ),
            ),
          ],
        ),
      );
      }
       , error:  (error, stackTrace) => Text(error.toString()), loading: () => CircularProgressIndicator(),)
      ,
    );
  }
}
