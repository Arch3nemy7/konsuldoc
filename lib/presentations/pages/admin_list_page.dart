import 'package:flutter/material.dart';
import 'package:konsuldoc/presentations/widgets/doctor_search_bar.dart';
import 'package:konsuldoc/presentations/widgets/drawer/doctor_filter_drawer.dart';

class AdminListPage extends StatefulWidget {
  const AdminListPage({super.key});

  @override
  State<AdminListPage> createState() => _AdminListPageState();
}

class _AdminListPageState extends State<AdminListPage> {
  String dropdownValue = 'Filter';
  List<String> adminNames = ['Dr. Mariya Khan'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
        title: Center(
          child: Text(
            'Admin',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color(0xFFF6FAFE),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DoctorSearchBar(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: adminNames.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/3d_avatar_13.png"),
                          radius: 25,
                        ),
                        title: Text(
                          adminNames[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Poli Gigi',
                          style: TextStyle(),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                      height: 0,
                      endIndent: 15,
                      indent: 15,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            adminNames.add('Dr. New Doctor');
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFF9E287),
      ),
    );
  }
}
