import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konsuldoc/domain/entities/doctor_session.dart';

class PilihSesi extends StatelessWidget {
  final String title;
  final DoctorSession session;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  PilihSesi(
      {required this.title,
      required this.onDelete,
      required this.session,
      required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          IconButton(
            onPressed: onDelete,
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
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        selectStart(context);
                      },
                      icon: Icon(Icons.schedule_outlined),
                      label: Text(session.timeStart.format(context)),
                      style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black54,
                          alignment: Alignment.centerLeft,
                          minimumSize: Size.fromHeight(64),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3))),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    "-",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        selectEnd(context);
                      },
                      icon: Icon(Icons.schedule_outlined),
                      label: Text(session.timeEnd.format(context)),
                      style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black54,
                          alignment: Alignment.centerLeft,
                          minimumSize: const Size.fromHeight(64),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3))),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: session.quota.toString(),
                onChanged: (value) {
                  session.quota = int.tryParse(value) ?? 0;
                  onUpdate();
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: "Kuota",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void selectStart(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: session.timeStart,
      helpText: "Pilih jam mulai",
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (time == null) return;
    session.timeStart = time;
    onUpdate();
  }

  void selectEnd(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: session.timeEnd,
      helpText: "Pilih jam berakhir",
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (time == null) return;
    session.timeEnd = time;
    onUpdate();
  }
}
