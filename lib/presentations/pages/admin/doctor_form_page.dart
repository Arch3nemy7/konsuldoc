import 'package:flutter/material.dart';

class DoctorFormPage extends StatefulWidget {
  const DoctorFormPage({Key? key}) : super(key: key);

  @override
  State<DoctorFormPage> createState() => _DoctorFormPageState();
}

class _DoctorFormPageState extends State<DoctorFormPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _specialistController = TextEditingController();
  TextEditingController _datetimeinput = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _specialistController.dispose();
    _datetimeinput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dokter'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2020/12/13/16/37/woman-5828786_1280.jpg',
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 4, color: Colors.white),
                          color: Color.fromRGBO(28, 42, 58, 1),
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.perm_identity_rounded),
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                    return "Masukkan nama yang valid";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Deskripsi",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukkan deskripsi";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _specialistController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Spesialis",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.medical_services),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukkan spesialis";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Text(
                'Hari Kerja',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 1,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Senin'),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // Atur jarak di sini
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: "Dari",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.access_time),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0), // Atur jarak di sini
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // Atur jarak di sini
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: "Sampai",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.access_time),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _datetimeinput,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Tanggal",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.edit_calendar_rounded),
                ),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2101),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: ColorScheme.light(
                            primary:
                                Colors.blue, // Atur warna pilih tanggal di sini
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null && picked != _datetimeinput.text) {
                    setState(() {
                      _datetimeinput.text = picked.toString().split(" ")[0];
                    });
                  }
                },
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text('Tambah'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(58, 115, 149, 1),
                    foregroundColor: Colors.white,
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
