import 'package:flutter/material.dart';

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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      fillColor: Color(0xFFE5E8ED),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Search',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: adminNames.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: ListTile(
                        onTap: () {
                          _showDetailAdmin();
                        },
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

  _detailAdmin() {
    return Column(
      children: [
        Text(
          'Admin',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Divider(
          indent: 10,
          endIndent: 10,
        ),
        Center(
          child: Column(
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://gravatar.com/avatar/27205e5c51cb03f862138b22bcb5dc20f94a342e744ff6df1b8dc8af3c865109.jpg"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDetailAdmin() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.42,
          minChildSize: 0.3,
          maxChildSize: 0.7,
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
                    const Text('Admin',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        )),
                    Divider(
                      color: Colors.black38,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 120,
                              width: 120,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://gravatar.com/avatar/27205e5c51cb03f862138b22bcb5dc20f94a342e744ff6df1b8dc8af3c865109.jpg"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          'Budi Harianto',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text('admin123@gmail.com'),
                        Text('0812345678'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 140,
                            child: ElevatedButton(
                              onPressed: () {
                                // Tambahkan fungsi untuk melakukan appointment di sini
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
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return 0;
                                    }
                                    return 5;
                                  },
                                ),
                              ),
                              child: const Text(
                                'Hapus',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
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
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return 0;
                                    }
                                    return 5;
                                  },
                                ),
                              ),
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
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
      },
    );
  }
}
