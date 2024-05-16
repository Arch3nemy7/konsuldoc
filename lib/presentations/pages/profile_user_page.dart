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
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/3d_avatar_13.png"),
                  ),
                  Positioned(
                    right: -12,
                    bottom: 0,
                    child: SizedBox(
                      height: 50,
                      width: 105,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Center(
                            child: Image.asset(
                              "assets/images/message-edit.png",
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                Image.asset(
                  'assets/images/user-edit.png',
                  width: 24,
                  height: 24,
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
                Image.asset(
                  'assets/images/logout.png',
                  width: 24,
                  height: 24,
                ),
                SizedBox(width: 15),
                Text(
                  'Logout',
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

  _History() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: () {},
            child: Row(
              children: [
                Image.asset(
                  'assets/images/clock.png',
                  width: 24,
                  height: 24,
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
