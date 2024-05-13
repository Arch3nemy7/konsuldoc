import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: Color.fromRGBO(229, 231, 235, 1),
            endIndent: 24.0,
          ),
        ),
        Text("Atau", style: TextStyle(color: Colors.blueGrey)),
        Expanded(
          child: Divider(
            color: Color.fromRGBO(229, 231, 235, 1),
            indent: 24.0,
          ),
        ),
      ],
    );
  }
}
