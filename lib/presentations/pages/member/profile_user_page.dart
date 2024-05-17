import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileUserPage extends StatelessWidget {
  const ProfileUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          _profilePict(),
          Text(
            'Budi Haryanto',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            '0812636728',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _EditProfile(),
          _History(),
          _Logout(),
        ],
      ),
    );
  }

  _profilePict() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://gravatar.com/avatar/27205e5c51cb03f862138b22bcb5dc20f94a342e744ff6df1b8dc8af3c865109.jpg"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _EditProfile() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
                SizedBox(width: 15),
                Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        Divider(
          indent: 20,
          endIndent: 20,
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }

  _Logout() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                SizedBox(width: 15),
                Text(
                  'Logout',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        Divider(
          indent: 20,
          endIndent: 20,
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }

  _History() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: Colors.black,
                ),
                SizedBox(width: 15),
                Text(
                  'History',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        Divider(
          indent: 20,
          endIndent: 20,
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}
