import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konsuldoc/core/utils/formatter.dart';
import 'package:konsuldoc/domain/entities/doctor_session.dart';
import 'package:time_range_picker/time_range_picker.dart';

class PilihSesi extends StatefulWidget {
  final String title;
  final DoctorSession session;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const PilihSesi({
    super.key,
    required this.title,
    required this.onDelete,
    required this.session,
    required this.onUpdate,
  });

  @override
  State<PilihSesi> createState() => _PilihSesiState();
}

class _PilihSesiState extends State<PilihSesi> {
  late final _timeController = TextEditingController(
      text:
          "${widget.session.timeStart.toTimeString()} - ${widget.session.timeEnd.toTimeString()}");

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const Border(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title),
          IconButton(
            onPressed: widget.onDelete,
            icon: const Icon(Icons.delete),
            color: Colors.red,
          ),
        ],
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: widget.session.quota.toString(),
                onChanged: (value) {
                  widget.session.quota = int.tryParse(value) ?? 0;
                  widget.onUpdate();
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: "Kuota",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: _pickTime,
                child: AbsorbPointer(
                  child: TextField(
                    controller: _timeController,
                    decoration: const InputDecoration(
                      labelText: 'Jam Sesi',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _pickTime() async {
    final TimeRange? picked = await showTimeRangePicker(
      context: context,
      fromText: "Mulai",
      toText: "Selesai",
      start: widget.session.timeStart,
      end: widget.session.timeEnd,
      disabledTime: TimeRange(
        startTime: const TimeOfDay(hour: 21, minute: 0),
        endTime: const TimeOfDay(hour: 6, minute: 0),
      ),
      labels: [
        "0",
        "3",
        "6",
        "9",
        "12",
        "15",
        "18",
        "21",
      ].asMap().entries.map((e) {
        return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
      }).toList(),
      rotateLabels: false,
      snap: true,
    );

    if (picked != null) {
      widget.session.timeStart = picked.startTime;
      widget.session.timeEnd = picked.endTime;
      _timeController.text =
          "${picked.startTime.toTimeString()} - ${picked.endTime.toTimeString()}";
      widget.onUpdate();
    }
  }
}
