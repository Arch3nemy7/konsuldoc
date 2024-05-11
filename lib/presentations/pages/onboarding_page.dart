import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:konsuldoc/presentations/widgets/custom_elevated_button.dart';
import 'package:konsuldoc/presentations/widgets/onboarding_view.dart';
import 'package:konsuldoc/router/auth_router.gr.dart';

@RoutePage()
class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: const [
                OnboardingView(
                  image: 'assets/images/female_doctor_with_stethoscope.png',
                  title: 'Temui Dokter Secara Online',
                  content:
                      'Temukan Dokter dan buat janji temu kapan saja, di mana saja',
                ),
                OnboardingView(
                  image: 'assets/images/young_doctor_with_clipboard.png',
                  title: 'Terhubung dengan Spesialis',
                  content:
                      ' Jelajahi Beragam Spesialis Medis Online, Menawarkan Berbagai Keahlian yang Disesuaikan dengan Kebutuhan Perawatan Kesehatan Anda',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 2; i++)
                  Radio(
                    value: i,
                    groupValue: _currentPage,
                    onChanged: (int? value) {
                      if (value != null) {
                        _pageController.animateToPage(
                          value,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    activeColor: const Color.fromRGBO(0, 76, 105, 1),
                  ),
                CustomElevatedButton(
                  onPressed: () {
                    _currentPage == 0 ? 
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ) : context.pushRoute(const SignInRoute());
                  },
                  text: 'Next',
                  width: 92,
                  height: 40,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
