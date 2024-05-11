import 'package:flutter/material.dart';
import 'package:konsuldoc/presentations/widgets/styles.dart';

class OnboardingView extends StatelessWidget {
  final String image;
  final String content;
  final String title;

  const OnboardingView({
    super.key,
    required this.image,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            const SizedBox(height: 18),
            Text(
              title,
              style: welcomeTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: messageTextStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
