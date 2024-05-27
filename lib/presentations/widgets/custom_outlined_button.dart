import 'package:flutter/material.dart';
import '../../core/theme/styles.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final Widget leading;
  final VoidCallback? onPressed;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.leading,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: leading,
        label: Text(
          text,
          style: buttonTextStyle,
        ),
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }
}
